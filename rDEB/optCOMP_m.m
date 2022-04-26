%Fit the composite model with respect to data from non-treated soil in Figure 3 of %ESTRELLA et a. 1993.
%Author: Jinyun Tang (jinyuntang@lbl.gov)
%Prepare the work space
clear all;
close all;
%clc;
addpath('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB');
addpath(genpath('/Users/jinyuntang/work/github/matlab_tools'));
%Define parameters for the revised DEB (rDEB) model
global par;

%#####################################################################

%Define the observations
global obs;
load('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB/growth_data_CO2/co2_nontreat.mat');
obs.t1=ts;
obs.yco2=dd;
obs.std=ds;


%Estimate parameters
ns=100;
x0=[0.7e-2,0.45*0.06e-2,2.,0.55*0.06e-2,0.6,0.8];
options = optimset('MaxFunEvals',300*5);
xs=zeros(ns,6);
fs=zeros(ns,1);
fsmin=0;
xm=x0;
xl=[1.e-9,1.e-9,1.e-9,1.e-9,1.e-9,1.e-9];
xu=[1,0.1,9,0.2,0.9,3];
flags=zeros(ns,1);
for jj = 1 : ns
    x0=rand(1,6).*[1,0.1,10,0.2,0.9,3];
    [x,fval,exitflag] = fminsearchbnd(@jcost_comp,x0,xl,xu,options);
    if (exitflag==1)
        flags(jj)=1;
    end
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

tend=500;
parcomp.umax= xm(1);    
parcomp.mq  = xm(2);
parcomp.KS  = xm(3);     
parcomp.gmm = xm(4); 
parcomp.YG  = xm(5);

%Print the parameters
fprintf('umax=%f per hr\n',xm(1));
fprintf('mq=%f per hr\n',xm(2));
fprintf('KS=%f mgC/L\n',xm(3));
fprintf('gmm=%f per hr\n',xm(4));
fprintf('YG=%f\n',xm(5));
fprintf('B0=%f mgC/L\n',xm(6));
     
parcomp.vid.S=1;
parcomp.vid.B=2;
parcomp.vid.CO2=3;
parcomp.vid.BD=4;
y0=[43.43,xm(6), 0,0];
par=parcomp;
nls=1000;
[t2,y2]=euler_driver_composite(y0,[0,tend],nls);
y0c=y0;
%plot the results
plot(t2,y2(:,parcomp.vid.CO2));
hold on;
errorbar(obs.t1,obs.yco2,obs.std);
xlabel('Hour','FontSize',18);
ylabel('Cumulative CO_2 (mgC/L)','FontSize',18);
set(gca,'FontSize',18);
nl1=sum(fs<2 & flags);
ParSet=zeros(6,nl1);
kk=1;
for jj = 1 : ns
    if(flags(jj) && fs(jj)<2)
        par.umax= xs(jj,1);    
        par.mq  = xs(jj,2);
        par.KS  = xs(jj,3);     
        par.gmm = xs(jj,4); 
        par.YG  = xs(jj,5);
        par.vid.S=1;
        par.vid.B=2;
        par.vid.CO2=3;
        par.vid.BD=4;
        y0=[43.43,xs(jj,6), 0,0];
        ParSet(:,kk)=xs(jj,:);
        kk=kk+1;
        %par=parcomp;
        [t2,y2]=euler_driver_composite(y0,[0,tend],nls);

        plot(t2,y2(:,parcomp.vid.CO2));
        hold on;
    end
end

save('parcomp_opt1.mat','parcomp','y0c','ParSet');


