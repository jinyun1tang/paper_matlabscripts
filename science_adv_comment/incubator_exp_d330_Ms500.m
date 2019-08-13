close all;
clear all;
clc;

mfolder='/Users/jinyuntang/work/github/paper_matlabscripts/science_adv_comment/one_bug_model/mat_files/Incubation';
ofile=[mfolder,'/Incubator_Ms500_days330.mat'];
load(ofile);
Extra.id_f1=1;
Extra.id_k1_tl=2;
Extra.id_k2_tl=3;
Extra.id_k1_th=4;
Extra.id_k2_th=5;
Extra.err_std=0.04;
Extra.ctot=incubator.Ctot;
Extra.t=sample_days();

Extra.f1_0=5.76e-2;
Extra.k1_0=8.68e-3;
Extra.k2_0=0.74e-4;
%generate synthetic measurements
Extra.obs_csh_tl=incubator.cumresp_T10C(Extra.t+1).*(ones(size(Extra.t))+...
    Extra.err_std.*randn(size(Extra.t)));

Extra.obs_csh_th=incubator.cumresp_T20C(Extra.t+1).*(ones(size(Extra.t))+...
    Extra.err_std.*randn(size(Extra.t)));

load_module('DREAM_ZS');
x0=ones(1,5);

% Recommended parameter settings
MCMCPar.seq = 6;                        % Number of Markov chains / sequences (for high dimensional and highly nonlinear problems, larger values work beter!!)
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
MCMCPar.ndraw = 50000;                  % Maximum number of function evaluations
MCMCPar.T = 1;                          % Each Tth sample is collected in the chains
MCMCPar.prior = 'COV';                  % Latin Hypercube sampling (options, "LHS", "COV" and "PRIOR")
MCMCPar.BoundHandling = 'Bound';         % Boundary handling (options, "Reflect", "Bound", "Fold", and "None");
MCMCPar.lik = 4;                        % Define the likelihood function --> log-density from model
ParRange.minn=zeros(1,MCMCPar.n);
ParRange.maxn=zeros(1,MCMCPar.n)+20;

% Define modelName
ModelName = 'lktwopool_modelwoc_i2';

% Provide information to do initial sampling ("COV")
MCMCPar.mu = zeros(1,MCMCPar.n);        % Provide mean of initial sample
MCMCPar.cov = 2 * eye(MCMCPar.n);       % Initial covariance

% Define the specific properties of the banana function
Extra.cov  = eye(MCMCPar.n); Extra.cov(1,1) = 100;      % Target covariance
Extra.invC = inv(Extra.cov);                            % Inverse of target covariance
Extra.b = 0.1;                                          % For the function

% Run the DREAM_ZS algorithm   
[Sequences,X,Z,output,fx] = dream_zs(MCMCPar,ModelName,Extra,ParRange);
% Create a single matrix with values sampled by chains
ParSet = genparset(Sequences,MCMCPar);

eld=floor(size(Z,1)/3);
fig=1;
fontsz=14;

xf=zeros(1,3);
ax=multipanel(fig,2,3,[0.05,0.075],[0.25,0.375],[0.05,0.075]);
set_curAX(fig,ax(1));
histogram(Z(end-eld:end,Extra.id_f1).*Extra.f1_0,50);title('f1','FontSize',14);
mn=mean(Z(end-eld:end,Extra.id_f1));sgm=std(Z(end-eld:end,Extra.id_f1));
tag=['f_1=',num2str(mn.*Extra.f1_0,'%.2f'),'\pm',num2str(sgm.*Extra.f1_0,'%.2f')];
put_tag(fig,ax(1),[0.5,0.8],tag,fontsz);
xf(1)=mn;

set_curAX(fig,ax(2));
histogram(Z(end-eld:end,Extra.id_k1_tl).*Extra.k1_0,50);title('k_1 (day ^-^1)','FontSize',14);
mn=mean(Z(end-eld:end,Extra.id_k1_tl));sgm=std(Z(end-eld:end,Extra.id_k1_tl));
tag=['k_1=',num2str(mn*Extra.k1_0,'%.2e'),'\pm',num2str(sgm*Extra.f1_0,'%.2e')];
put_tag(fig,ax(2),[0.5,0.8],tag,fontsz);
xf(2)=mn;

set_curAX(fig,ax(3));
histogram(Z(end-eld:end,Extra.id_k2_tl).*Extra.k2_0,50);title('k_2  (day ^-^1)','FontSize',14);
mn=mean(Z(end-eld:end,Extra.id_k2_tl));sgm=std(Z(end-eld:end,Extra.id_k2_tl));
tag=['k_2=',num2str(mn*Extra.k2_0,'%.2e'),'\pm',num2str(sgm*Extra.k2_0,'%.2e')];
put_tag(fig,ax(3),[0.5,0.8],tag,fontsz);
xf(3)=mn;
Extra.id_k1=2;
Extra.id_k2=3;
cumresp_tl=twopool_modelwoc(xf,Extra);

set_curAX(fig,ax(4));
histogram(Z(end-eld:end,Extra.id_k1_th).*Extra.k1_0,50);title('k_1  (day ^-^1)','FontSize',14);
mn=mean(Z(end-eld:end,Extra.id_k1_th));sgm=std(Z(end-eld:end,Extra.id_k1_th));
tag=['k_1=',num2str(mn*Extra.k1_0,'%.2e'),'\pm',num2str(sgm*Extra.k1_0,'%.2e')];
put_tag(fig,ax(4),[0.5,0.8],tag,fontsz);
xf(2)=mn;

set_curAX(fig,ax(5));
histogram(Z(end-eld:end,Extra.id_k2_th).*Extra.k2_0,50);title('k_2  (day ^-^1)','FontSize',14);
mn=mean(Z(end-eld:end,Extra.id_k2_th));sgm=std(Z(end-eld:end,Extra.id_k2_th));
tag=['k_2=',num2str(mn*Extra.k2_0,'%.2e'),'\pm',num2str(sgm*Extra.k2_0,'%.2e')];
put_tag(fig,ax(5),[0.5,0.8],tag,fontsz);
xf(3)=mn;

cumresp_th=twopool_modelwoc(xf,Extra);

set_curAX(fig,ax(6));
plot(Extra.t,cumresp_tl.*100./Extra.ctot,'b');
hold on;
erro=Extra.err_std.*randn(size(Extra.t)).*Extra.obs_csh_tl.*100./Extra.ctot;
errorbar(Extra.t,Extra.obs_csh_tl.*100./Extra.ctot,erro,'r.','MarkerSize',6);

plot(Extra.t,cumresp_th.*100./Extra.ctot,'b');

plot(Extra.t,Extra.obs_csh_th.*100./Extra.ctot,'r.','MarkerSize',6);
erro=Extra.err_std.*randn(size(Extra.t)).*Extra.obs_csh_th.*100./Extra.ctot;
errorbar(Extra.t,Extra.obs_csh_th.*100./Extra.ctot,erro,'r.','MarkerSize',6);


h=legend('Two-pool fitting','ReSOM output');
xlabel('Days','FontSize',fontsz);
ylabel('Cumulative respiration (% of inital C)','FontSize',fontsz);
set(ax,'FontSize',fontsz);

