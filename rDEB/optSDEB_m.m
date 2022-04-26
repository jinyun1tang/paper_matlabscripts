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
load('parcomp_opt1.mat');
par=parcomp;
nls=1000;
%Run the model
[t3,y3]=euler_driver_composite(y0c,[0,tend],nls);
%Define the observations
global obs;
obs.t2=t3(2:end)';
%obs.yco2=y3(2:end,par.vid.CO2);
obs.yB=y3(2:end,par.vid.BD);
%Define the observations
obs.B0=y0c(2);
obs.S0=y0c(1);

load('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB/growth_data_CO2/co2_nontreat.mat');
obs.t1=ts;
obs.yco2=dd;
obs.std=ds;



val=400;
ns=100;
options = optimset('MaxFunEvals',300*5);
xs=zeros(ns,8);
fs=zeros(ns,1);
fsmin=0;
flags=zeros(ns,1);
x0=[0.1350, 0.2188, 0.465, 0.33, 0.0364, 0.0017,0.1];
xl=[1.e-2,1.e-2,1.e-2,1.e-1,1.e-1,1.e-4,1.e-4,1.e-2];
xu=[1,10,0.6,0.8,0.9,0.1,0.1,0.9];
for jj = 1 : ns
    x0=xl+rand(1,8).*(xu-xl);
    [x,fval,exitflag] = fminsearchbnd(@jcost_sdeb,x0,xl,xu,options);
    xs(jj,:)=x;
    fs(jj)=fval;
    if (exitflag==1 || fval < val)
        flags(jj)=1;
    end
    
    if(jj==1)
        fsmin=fval;
        xm=x0;
    else
        if(fsmin>fval)
            xm=x;
            fsmin=fval;            
        end
    end
    fprintf('jj=%d\n',jj);   
end
%Compute & plot the optimal simulation.


%save('parsdeb.mat', 'parsdeb','xs','xm');
%val=400;
figure;
plot(t3,y3(:,parcomp.vid.CO2),'k','LineWidth',2);
hold on;
errorbar(obs.t1,obs.yco2,obs.std);
xlabel('Hour','FontSize',18);
ylabel('Cumulative CO_2 (mgC/L)','FontSize',18);
set(gca,'FontSize',18);

nl1=sum(fs<val & flags);
ParSet=zeros(8,nl1);
kk=1;
ns=100;
for jj = 1 : ns
    if(flags(jj) && fs(jj)<val)
        par.kap0=xs(jj,1);
        par.KS=xs(jj,2);
        par.amax=xs(jj,3);
        par.YRV=xs(jj,4);
        par.YSR=xs(jj,5);
        par.mV=xs(jj,6);
        par.gmm=xs(jj,7);
        par.vid.S=1;
        par.vid.BV=2;
        par.vid.BR=3;
        par.vid.CO2=4;
        par.vid.BD=5;

        ParSet(:,kk)=xs(jj,:);
        kk=kk+1;
        y01=[y0c(1),y0c(2)*xs(jj,8),y0c(2)*(1-xs(jj,8)),0,0];
        ns1=1000;
        [t2,y2]=euler_driver_sdeb(y01,[0,tend],ns1);
        plot(t2,y2(:,par.vid.CO2),'LineWidth',2);

        hold on;
    end
end

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

y0s=[y0c(1),y0c(2)*xm(8),y0c(2)*(1-xm(8)),0,0];
ns1=1000;
[t2,y2]=euler_driver_sdeb(y0s,[0,tend],ns1);
plot(t2,y2(:,par.vid.CO2),'r','LineWidth',2);

save('parsdeb_opt1.mat','parsdeb','y0s','ParSet');


