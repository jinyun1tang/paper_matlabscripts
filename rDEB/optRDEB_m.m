%Fit the SDEB model with respect to the composite model
%Author: Jinyun Tang (jinyuntang@lbl.gov)
%Prepare the work space
clear all;
close all;
addpath('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB');
addpath(genpath('/Users/jinyuntang/work/github/matlab_tools'));
tend=500;
%Define parameters for the revised DEB (rDEB) model
global par;
%#####################################################################
%Load parameters and initial condition for the composite model
load('parcomp.mat');
par=parcomp;

%Run the model
[t3,y3]=ode23s(@mic_dyngrowth_composite,[0,tend],y0);
%Define the observations
global obs;
obs.t1=t3(2:end);
obs.yco2=y3(2:end,par.vid.CO2);
obs.yB=y3(2:end,par.vid.BD);
ns=200;
options = optimset('MaxFunEvals',300*5);
xs=zeros(ns,11);
fs=zeros(ns,1);
fsmin=0;
x0=[0.4, 0.4, 0.4, 0.4,3, 0.1, 0.0364, 0.2,0.17,0.01,0.1,0.1];
xm=x0;

xl=[1.e-1,1.e-1,1.e-1,1.e-1,1.e-1,1.e-4,1.e-4,1.e-4,1.e-4,1.e-2,1.e-2];
xu=[0.9,0.9,0.9,0.9,8,0.9,0.4,0.5,0.1,0.95,0.95];
for jj = 1 : ns
    x0=xl+rand(1,11).*(xu-xl);
    [x,fval] = fminsearchbnd(@jcost_rdeb,x0,xl,xu,options);
    xs(jj,:)=x;
    fs(jj)=fval;
    if(jj==1)
        fsmin=fval;
    else
        if(fsmin>fval)
            xm=x;
            fsmin=fval;            
        end
    end
    fprintf('jj=%d\n',jj);   
end
%Compute & plot the optimal simulation.

parrdeb.YRV=xm(1);
parrdeb.YRN=xm(2);
parrdeb.YSR=xm(3);
parrdeb.fN=xm(4);
parrdeb.KS=xm(5);
parrdeb.amax=xm(6);
parrdeb.mV=xm(7);
parrdeb.kapmax=xm(8);
parrdeb.gmm=xm(9);
parrdeb.tauN=24;
parrdeb.alpha=0.003;
parrdeb.KR=1.;
parrdeb.KR0=0.13;
parrdeb.phiV=0.1*1;
parrdeb.phiN=0.05*1;
parrdeb.phiR=0.05*1;
parrdeb.vid.S=1;
parrdeb.vid.BV=2;
parrdeb.vid.BR=3;
parrdeb.vid.BN=4;
parrdeb.vid.CO2=5;
parrdeb.vid.BD=6;
par=parrdeb;


y01=[y0(1),y0(2)*xm(10), y0(2)*(1-xm(10))*xm(11), y0(2)*(1.-xm(10))*(1.-xm(11)),0,0];

[t2,y2]=ode23s(@mic_dyngrowth_rDEB,[0,tend],y01);

figure;
plot(t3./24,y3(:,parcomp.vid.CO2),'r','LineWidth',2);
hold on;
plot(t2./24,y2(:,parrdeb.vid.CO2),'b','LineWidth',2);
%fprintf('kap0=%f\namax=%f\nYRV=%f\nYSR=%f\nmV=%f\ngm=%f\nfV=%f\n',x');

figure;
plot(t2,y2(:,parrdeb.vid.BD),'b','LineWidth',2);
hold on;
plot(t3,y3(:,parcomp.vid.BD),'r','LineWidth',2);

save('parrdeb.mat', 'parrdeb','y01','xs','fs');