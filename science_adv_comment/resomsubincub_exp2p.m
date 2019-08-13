close all;
clear all;
clc;


Extra.id_f1=1;
Extra.id_k1=2;
Extra.id_k2=3;
Extra.ctot=1.0;
Extra.t=(0:2:600)+0.5;
x=ones(1,3);

Extra.f1_0=5.76e-2;
Extra.k1_0=8.68e-3;
Extra.k2_0=0.74e-4;
%generate synthetic measurements
Extra.obs_csh=twopool_modelwoc(x,Extra).*(ones(size(Extra.t))+...
    0.01.*randn(size(Extra.t)));

load_module('DREAM_ZS');
x0(Extra.id_f1)=0.2;
x0(Extra.id_k1)=1.3;
x0(Extra.id_k2)=0.8;
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
MCMCPar.n = 3;                         % Dimension of the problem (number of parameters to be estimated)
MCMCPar.ndraw = 50000;                  % Maximum number of function evaluations
MCMCPar.T = 1;                          % Each Tth sample is collected in the chains
MCMCPar.prior = 'COV';                  % Latin Hypercube sampling (options, "LHS", "COV" and "PRIOR")
MCMCPar.BoundHandling = 'None';         % Boundary handling (options, "Reflect", "Bound", "Fold", and "None");
MCMCPar.lik = 4;                        % Define the likelihood function --> log-density from model

% Define modelName
ModelName = 'lktwopool_modelwoc';

% Provide information to do initial sampling ("COV")
MCMCPar.mu = zeros(1,MCMCPar.n);        % Provide mean of initial sample
MCMCPar.cov = 2 * eye(MCMCPar.n);       % Initial covariance

% Define the specific properties of the banana function
Extra.cov  = eye(MCMCPar.n); Extra.cov(1,1) = 100;      % Target covariance
Extra.invC = inv(Extra.cov);                            % Inverse of target covariance
Extra.b = 0.1;                                          % For the function

% Run the DREAM_ZS algorithm   
[Sequences,X,Z,output,fx] = dream_zs(MCMCPar,ModelName,Extra);
% Create a single matrix with values sampled by chains
ParSet = genparset(Sequences,MCMCPar);

eld=floor(size(Z,1)/3);
fig=1;
ax=multipanel(fig,2,2,[0.05,0.05],[0.4,0.375],[0.05,0.075]);
set_curAX(fig,ax(1));
hist(Z(end-eld:end,1),50);title('f1','FontSize',14);
set_curAX(fig,ax(2));
hist(Z(end-eld:end,2),50);title('k_1','FontSize',14);
set_curAX(fig,ax(3));
hist(Z(end-eld:end,3),50);title('k_2','FontSize',14);
set_curAX(fig,ax(4));
hist(Z(end-eld:end,4),50);title('logp','FontSize',14);
