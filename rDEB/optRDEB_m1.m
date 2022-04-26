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
load('parcomp_opt.mat');
par=parcomp;

%Run the model
[t3,y3]=ode23s(@mic_dyngrowth_composite,[0,tend],y0);
%Define the observations
global obs;
obs.t2=t3(2:end);
obs.yB=y3(2:end,par.vid.BD);
obs.B0=y0(2);
obs.S0=y0(1);

load('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB/growth_data_CO2/co2_nontreat.mat');
obs.t1=ts;
obs.yco2=dd;
obs.yco2=y3(2:end,par.vid.CO2);
obs.std=ds;


load('parrdeb_dreamzs.mat');
xl=ParRange.minn;
xu=ParRange.maxn;


fsmin=0;
x10=y0r(2)./y0(2);
x11=y0r(3)./(y0(2)*(1-x10));
x0=[parrdeb.YRV,...
parrdeb.YRN,...
parrdeb.YSR,...
parrdeb.fN,...
parrdeb.KS,...
parrdeb.amax,...
parrdeb.mV,...
parrdeb.kapmax,...
parrdeb.gmm,...
x10,...
x11,...
parrdeb.tauN];

options = optimset('MaxFunEvals',300*5);
nl=size(ParSet,1);
nsl=10;
xs=zeros(nsl,12);
fs=zeros(nsl,1);
xm=x0;
for jj = 1 : nsl
    k=randi(100);
    x0=ParSet(nl-k+1,1:12);
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
    fprintf('jj=%d,fval=%f\n',jj,fval);   
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
parrdeb.tauN=xm(12);
parrdeb.alpha=0.003;
parrdeb.KR=1.;
parrdeb.phiV=0.1;
parrdeb.KR0=4.7e-13*12/3600*(1-parrdeb.phiV)/parrdeb.phiV*xm(8);
parrdeb.dN=1.15;
parrdeb.dR=0.8;
parrdeb.vid.S=1;
parrdeb.vid.BV=2;
parrdeb.vid.BR=3;
parrdeb.vid.BN=4;
parrdeb.vid.CO2=5;
parrdeb.vid.BD=6;
par=parrdeb;


y0r=[y0(1),y0(2)*xm(10), y0(2)*(1-xm(10))*xm(11), y0(2)*(1.-xm(10))*(1.-xm(11)),0,0];

[t2,y2]=ode23s(@mic_dyngrowth_rDEB,[0,tend],y0r);

figure;
plot(t3./24,y3(:,parcomp.vid.CO2),'r','LineWidth',2);
hold on;
plot(t2./24,y2(:,parrdeb.vid.CO2),'b','LineWidth',2);
%fprintf('kap0=%f\namax=%f\nYRV=%f\nYSR=%f\nmV=%f\ngm=%f\nfV=%f\n',x');

figure;
plot(t2,y2(:,parrdeb.vid.BD),'b','LineWidth',2);
hold on;
plot(t3,y3(:,parcomp.vid.BD),'r','LineWidth',2);

save('parrdeb_opt.mat', 'parrdeb','y0r','xs','fs');