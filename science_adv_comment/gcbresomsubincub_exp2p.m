function [obs,cres1,cres2,q10b_pct,q10f,q10s,flab,k1c,k2c,k1w,k2w]=gcbresomsubincub_exp2p(obsf,do_plot, qrange)
if(nargin==1)
    do_plot=0;
end
%Ms=1800;

%incubator=get_incubation(Ms,xloc);
obs=getobs(obsf);

Extra.id_f1=1;
Extra.id_k1_tl=2;
Extra.id_k2_tl=3;
Extra.id_k1_th=4;
Extra.id_k2_th=5;
Extra.qrange=qrange;

Extra.ctot=1.0;
Extra.tl=obs.days10C;
Extra.th=obs.days20C;


Extra.f1_0=5.76e-2;
Extra.k1_0=8.68e-3;
Extra.k2_0=0.74e-4;
%generate synthetic measurements
%Extra.err_tl=incubator.err10C.*randn(size(Extra.t));
%Extra.err_th=interp1(Extra.th,incubator.err20C,Extra.tl).*randn(size(Extra.t));

Extra.err_tl=obs.err10C;
Extra.err_th=obs.err20C;

Extra.obs_csh_tl=obs.obs10C;
Extra.obs_csh_th=obs.obs20C;

load_module('DREAM_ZS');

% Recommended parameter settings
MCMCPar.seq = 10;                       % Number of Markov chains / sequences (for high dimensional and highly nonlinear problems, larger values work beter!!)
MCMCPar.DEpairs = 1;                    % Number of chain pairs to generate candidate points
MCMCPar.nCR = 3;                        % Number of crossover values used
MCMCPar.k = 10;                         % Thinning parameter for appending X to Z
MCMCPar.parallelUpdate = 0.9;           % Fraction of parallel direction updates
MCMCPar.eps = 5e-2;                     % Perturbation for ergodicity
MCMCPar.steps = inline('MCMCPar.ndraw/(20 * MCMCPar.seq)'); % Number of steps before calculating convergence diagnostics
MCMCPar.m0 = inline('10 * MCMCPar.n');  % Initial size of matrix Z
MCMCPar.pJumpRate_one = 0.20;           % Probability of selecting a jumprate of 1 --> jump between modes
MCMCPar.pCR = 'Yes';                    % Adaptive tuning of crossover values (Yes or No)
MCMCPar.Restart = 'No';                 % Restart run (Yes or No)
MCMCPar.modout = 'Yes';                 % Return model (function) simulations of samples Yes or No)?
MCMCPar.save = 'No';                    % Save output during the run (Yes or No)
MCMCPar.ABC = 'No';                     % Approximate Bayesian Computation or Not?


% Application specific parameter settings
MCMCPar.n = 5;                         % Dimension of the problem (number of parameters to be estimated)
MCMCPar.ndraw = 500000;                  % Maximum number of function evaluations
MCMCPar.T = 1;                          % Each Tth sample is collected in the chains
MCMCPar.prior = 'COV';                  % Latin Hypercube sampling (options, "LHS", "COV" and "PRIOR")
MCMCPar.BoundHandling = 'None';         % Boundary handling (options, "Reflect", "Bound", "Fold", and "None");
MCMCPar.BoundHandling = 'Bound';      % Boundary handling (options, "Reflect", "Bound", "Fold", and "None");

MCMCPar.lik = 4;                        % Define the likelihood function --> log-density from model

% Define modelName
ModelName = 'lktwopool_modelwoc_q2';

% Provide information to do initial sampling ("COV")
MCMCPar.mu = zeros(1,MCMCPar.n);        % Provide mean of initial sample
MCMCPar.cov = 2 * eye(MCMCPar.n);       % Initial covariance

% Define the specific properties of the banana function
Extra.cov  = eye(MCMCPar.n); Extra.cov(1,1) = 100;      % Target covariance
Extra.invC = inv(Extra.cov);                            % Inverse of target covariance
Extra.b = 0.1;                                          % For the function

ParRange.minn = zeros(1,MCMCPar.n)+1.e-3; ParRange.maxn = ParRange.minn+1.e2;

% Run the DREAM_ZS algorithm   
[Sequences,~,Z,~,~] = dream_zs(MCMCPar,ModelName,Extra,ParRange);
% Create a single matrix with values sampled by chains
ParSet = genparset(Sequences,MCMCPar);

eld=floor(size(Z,1)/4);
id=(size(Z,1)-eld:size(Z,1));

q10f=Z(id,4)./Z(id,2);
q10s=Z(id,5)./Z(id,3);
q10b=Extra.obs_csh_th./Extra.obs_csh_tl;
flab=Extra.f1_0.*Z(id,1);
k1c=Z(id,2).*Extra.k1_0;
k2c=Z(id,3).*Extra.k2_0;
k1w=Z(id,4).*Extra.k1_0;
k2w=Z(id,5).*Extra.k2_0;
for jj = 1 : numel(id)
    xj=Z(id(jj),1:5);
    [cumresp1,cumresp2]=twopool_modelwoc_i2(xj,Extra);
    if(jj==1)
        cres11=zeros(numel(id),numel(cumresp1));
        cres22=cres11;
    end
    cres11(jj,:)=cumresp1;
    cres22(jj,:)=cumresp2;
end
cres1=prctile(cres11,(0.1:0.2:99.9),1);
cres2=prctile(cres22,(0.1:0.2:99.9),1);
if(do_plot)
fig=1;
ax=multipanel(fig,3,2,[0.05,0.075],[0.4,0.25],[0.05,0.075]);
set_curAX(fig,ax(1));
histogram(Z(id,1).*Extra.f1_0,50);
put_tag(fig,ax(1),[0.05,0.8],'f_1',14);
set_curAX(fig,ax(2));
histogram(Z(id,2).*Extra.k1_0,50);
put_tag(fig,ax(2),[0.05,0.8],'k_1 (day^-^1) at 10^\circC',18);

set_curAX(fig,ax(3));
histogram(Z(id,3).*Extra.k2_0,50);
put_tag(fig,ax(3),[0.05,0.8],'k_2 (day^-^1) at 10^\circC',18);

set_curAX(fig,ax(4));
histogram(Z(id,4).*Extra.k1_0,50);
put_tag(fig,ax(4),[0.05,0.8],'k_1 (day^-^1) at 20^\circC',18);

set_curAX(fig,ax(5));
histogram(Z(id,5).*Extra.k2_0,50);
put_tag(fig,ax(5),[0.05,0.8],'k_2 (day^-^1) at 20^\circC',18);

set_curAX(fig,ax(6));
histogram(Z(id,6),50);
put_tag(fig,ax(6),[0.05,0.8],'log likelihood',18);

set(ax,'FontSize',14);
fig=2;
ax=multipanel(fig,1,2,[0.05,0.075],[0.4,0.85],[0.05,0.075]);
set_curAX(fig,ax(1));
histogram(q10f,50);
put_tag(fig,ax(1),[0.05,0.85],'Active pool Q_1_0',18);
set_curAX(fig,ax(2));
histogram(q10s,50);
put_tag(fig,ax(2),[0.05,0.85],'Slow pool Q_1_0',18);
set(ax,'FontSize',14);
end
fprintf('q10b=%f (%f) %f %f\n',mean(q10b),std(q10b),max(q10b),min(q10b));
fprintf('q10f=%f (%f) %f %f\n',mean(q10f),std(q10f),max(q10f),min(q10f));
fprintf('q10s=%f (%f) %f %f\n',mean(q10s),std(q10s),max(q10s),min(q10s));
q10b_pct=prctile(q10b,(0:100));

end

