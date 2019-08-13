close all;clear all;clc;

Extra.id_f1 =1;
Extra.id_f2 =2;
Extra.id_k1 =3;
Extra.id_k2 =4;
Extra.id_k3 =5;
Extra.id_f12=6;
Extra.id_f13=7;
Extra.id_f21=8;
Extra.id_f31=9;
Extra.id_f32=10;
Extra.id_Ctot=11;
var_names={'f1','f2','k1','k2','k3','f12','f13','f21','f31','f32'};
x=ones(1,10);


Extra.f1_0=10.65e-2;
Extra.f2_0=19.90e-2;
Extra.k1_0=8.84e-3;
Extra.k2_0=2.57e-4;
Extra.k3_0=1.38e-5;

Extra.f12_0=0.3;
Extra.f13_0=0.2;
Extra.f21_0=0.2;
Extra.f31_0=0.1;
Extra.f32_0=0.4;
Extra.t=(1:1:900);
Extra.dt=1.;
Extra.Ctot=1.0;


Extra.obs_csh=threepool_modelwoc(x,Extra).*(ones(size(Extra.t))+...
    0.01.*randn(size(Extra.t)));
n=10;
x0=rand(1,n)+0.5;
Extra.id_k1 =1;
Extra.id_k2 =2;
Extra.id_k3 =3;
% Recommended parameter settings
MCMCPar.seq = 13;                        % Number of Markov chains / sequences (for high dimensional and highly nonlinear problems, larger values work beter!!)
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

ParRange.minn=zeros(1,n);
ParRange.maxn=zeros(1,n)+10;
% Application specific parameter settings
MCMCPar.n = n;                         % Dimension of the problem (number of parameters to be estimated)
MCMCPar.ndraw = 60000;                  % Maximum number of function evaluations
MCMCPar.T = 1;                          % Each Tth sample is collected in the chains
MCMCPar.prior = 'COV';                  % Latin Hypercube sampling (options, "LHS", "COV" and "PRIOR")
MCMCPar.BoundHandling = 'Bound';         % Boundary handling (options, "Reflect", "Bound", "Fold", and "None");
MCMCPar.lik = 4;                        % Define the likelihood function --> log-density from model

% Define modelName
ModelName = 'lkthreepool_modelwoc';

% Provide information to do initial sampling ("COV")
MCMCPar.mu = zeros(1,MCMCPar.n)+0.5;        % Provide mean of initial sample
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
ax=multipanel(fig,4,3,[0.05,0.05],[0.25,0.175],[0.05,0.075]);
for j = 1 : n
    set_curAX(fig,ax(j));
    histogram(Z(end-eld:end,j),50);title(var_names{j},'FontSize',14);
end
set_curAX(fig,ax(n+1));
histogram(Z(end-eld:end,n+1),50);title('logp','FontSize',14);


