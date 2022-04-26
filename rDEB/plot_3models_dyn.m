%clc;
clear all;
close all;
%Driver file for the revised DEB model
%Author: Jinyun Tang (jinyuntang@lbl.gov)
%Prepare the work space
addpath('/Users/jinyuntang/work/github/matlab_tools/');
addpath('/Users/jinyuntang/work/github/matlab_tools/export_fig');
addpath('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB');
addpath('/Users/jinyuntang/work/github/matlab_tools/MCMC/DREAM_ZS');
%Set shared variables
tend=500;
%Define parameters for the revised DEB (rDEB) model
global par;
%load('parrdeb_opt.mat');
load('/Users/jinyuntang/work/github/matlab_tools/MCMC/DREAM_ZS/parrdeb_dreamzs.mat');
par=parrdeb;
%Define initial condition
y0=y0r;
ns=1000;

%Run the simulation
%[t1,y1]=ode23s(@mic_dyngrowth_rDEB,[0,tend],y0);
[t1,y1]=euler_driver_rdeb(y0,[0,tend],ns);

%################################################################
%Driver for the standard DEB model
%load('parsdeb_opt.mat');
load('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB/parsdeb_opt1.mat');
par=parsdeb;

%Define initial condition
y0=y0s;
%Run the model
%[t2,y2]=ode23(@mic_dyngrowth_sdeb,[0,tend],y0);
[t2,y2]=euler_driver_sdeb(y0,[0,tend],ns);

%#####################################################################
%Define parameters for the composite model
%load('parcomp_opt.mat');
load('parcomp_opt1.mat');
par=parcomp;
%Run the model
%plot the results
%[t3,y3]=ode23s(@mic_dyngrowth_composite,[0,tend],y0c);
[t3,y3]=euler_driver_composite(y0c,[0,tend],ns);
global obs;
load('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB/growth_data_CO2/co2_nontreat.mat');
obs.t1=ts;
obs.yco2=dd;
obs.std=ds;


%Plot the results
fig=figure(1);
ax=multipanel(fig,1,3,[0.1,0.1],[0.25,0.8],[0.065,0.1]);
set_curAX(fig,ax(1));
plot(t1./24,y1(:,parrdeb.vid.S),'LineWidth',2);hold on;
plot(t2./24,y2(:,parsdeb.vid.S),'LineWidth',2);
plot(t3./24,y3(:,parcomp.vid.S),'LineWidth',2);
ylabel('Substrate (mg C L^-^1)','FontSize',18);xlabel('Day','FontSize',18);
legend('rDEB model','sDEB model','Composite model','location','best');
ylim([0,50]);
set_curAX(fig,ax(2));
plot(t1./24,y1(:,parrdeb.vid.BV)+y1(:,parrdeb.vid.BN)+y1(:,parrdeb.vid.BR),'LineWidth',2);hold on;
plot(t2./24,y2(:,parsdeb.vid.BV)+y2(:,parsdeb.vid.BR),'LineWidth',2);
plot(t3./24,y3(:,parcomp.vid.B),'LineWidth',2);
ylabel('Microbial Biomass (mg C L^-^1)','FontSize',18);xlabel('Day','FontSize',18);
legend('rDEB model','sDEB model','Composite model','location','best');
set_curAX(fig,ax(3));
plot(t1./24,y1(:,parrdeb.vid.CO2),'LineWidth',2);hold on;
plot(t2./24,y2(:,parsdeb.vid.CO2),'LineWidth',2);
plot(t3./24,y3(:,parcomp.vid.CO2),'LineWidth',2);
errorbar(obs.t1./24,obs.yco2,obs.std,'LineWidth',2,'color','k');
ylabel('Cumulative CO_2 (mg C L^-^1)','FontSize',18);xlabel('Day','FontSize',18);
legend('rDEB model','sDEB model','Composite model','Observations','location','best');
set(ax,'FontSize',18);
ylim([0,30]);
put_tag(fig,ax(1),[.05,0.95],'(a)',24);
put_tag(fig,ax(2),[.05,0.95],'(b)',24);
put_tag(fig,ax(3),[.05,0.95],'(c)',24);
