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
%obs.yco2=y3(2:end,par.vid.CO2);
obs.yB=y3(2:end,par.vid.BD);
obs.B0=y0(2);
obs.S0=y0(1);

load('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB/growth_data_CO2/co2_nontreat.mat');
obs.t1=ts;
obs.yco2=dd;
obs.std=ds;


load('parsdeb_dreamzs.mat');
xl=ParRange.minn;
xu=ParRange.maxn;
x0=[parsdeb.kap0,...
parsdeb.KS,...
parsdeb.amax,...
parsdeb.YRV,...
parsdeb.YSR,...
parsdeb.mV,...
parsdeb.gmm,...
y0s(2)./y0(2)];

options = optimset('MaxFunEvals',300*5);
nl=size(ParSet,1);
nsl=10;
xs=zeros(nsl,8);
fs=zeros(nsl,1);
xm=x0;
for jj = 1 : nsl
    k=randi(100);
    x0=ParSet(nl-k+1,1:8);
    [x,fval] = fminsearchbnd(@jcost_sdeb,x0,xl,xu,options);
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

parsdeb.kap0=xm(1);
parsdeb.KS=xm(2);
parsdeb.amax=xm(3);
parsdeb.YRV=xm(4);
parsdeb.YSR=xm(5);
parsdeb.mV=xm(6);
parsdeb.gmm=xm(7);
parsdeb.vid.S=1;
parsdeb.vid.BV=2;
parsdeb.vid.BR=3;
parsdeb.vid.CO2=4;
parsdeb.vid.BD=5;
par=parsdeb;


y0s=[obs.S0,obs.B0*xm(8),obs.B0*(1.-xm(8)),0,0];
%[t2,y2]=ode23s(@mic_dyngrowth_sdeb,[0,tend],y0);
ns=1000;
[t2,y2]=euler_driver_sdeb(y0s,[0,tend],ns);


figure;
plot(t3./24,y3(:,parcomp.vid.CO2),'r','LineWidth',2);
hold on;
plot(t2./24,y2(:,parsdeb.vid.CO2),'b','LineWidth',2);
fprintf('kap0=%f\namax=%f\nYRV=%f\nYSR=%f\nmV=%f\ngm=%f\nfV=%f\n',x');

figure;
plot(t2,y2(:,parsdeb.vid.BD),'b','LineWidth',2);
hold on;
plot(t3,y3(:,parcomp.vid.BD),'r','LineWidth',2);

save('parsdeb_opt.mat', 'parsdeb','x','y0s');

