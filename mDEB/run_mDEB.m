close all;
clear all;
addpath(genpath('/Users/jinyuntang/work/github/matlab_tools'))
global par;
par=setpar();

t=0.0;

y0=zeros(1,par.nvars);
y0(par.vid.C)=1.e3;     %uM, Mx1.e-3, 1.e-6*1.e3mol/m3=1.e-3 mol/m3
y0(par.vid.N)=70;       %uM, 1.e-3 mol/m3
y0(par.vid.xC)=0.1;     %C-reserve density
y0(par.vid.xN)=0.01;    %N-reserve density
y0(par.vid.mV)=100.;    %uM, 1.e-3 mol/m3

tspan=[0,30];
ns=3200;
[t1,y]=euler_driver_mdeb(y0,tspan,ns);

t=(0:0.1:30);

I=(t<=4).*250+(t>4 & t<=24.5).*180.*exp(3.*(cos(2.0.*pi.*(t+0.4))-1))...
    +(t>24.5).*100;

load('C_conc.mat');
load('N_conc.mat');
save('mDEB.mat','t','I','t1','y');
%return;
fig=1;
figure(fig);
axs=zeros(3,1);
axs(1)=subplot(3,1,1);
plot(t,I,'LineWidth',2);xlim([20,30]);
ylabel('PDF ($\mu$E m$^{-2}$ s$^{-1}$)', 'Interpreter', 'latex');

axs(2)=subplot(3,1,2);
plot(t1,(y(:,par.vid.xC)+1).*y(:,par.vid.mV).*1.e-3,'LineWidth',2);
hold on;
plot(C_conc(:,1),C_conc(:,2),'r+','MarkerSize',8);xlim([20,30]);
ylabel('POC concentration (M) $\times 10^{-3}$', 'Interpreter', 'latex');

axs(3)=subplot(3,1,3);
h(1)=plot(t1,(y(:,par.vid.xN)+par.nV_N).*y(:,par.vid.mV).*1.e-2,'LineWidth',2);hold on;
h(2)=plot(N_conc(:,1),N_conc(:,2),'r+','MarkerSize',8);xlim([20,30]);
legend(h,'mDEB model','Measurement');
ylabel('PON concentration (M) $\times 10^{-4}$', 'Interpreter', 'latex');
xlabel('Day');
set(axs,'FontSize',16);
set(axs(1:2), 'XTickLabel', []);
set(axs(3), 'Position', [0.12, 0.08, 0.8, 0.255]);
set(axs(2), 'Position', [0.12, 0.4, 0.8, 0.255]);
set(axs(1), 'Position', [0.12, 0.72, 0.8, 0.255]);
put_tag(fig,axs(1),[.025,.9],'(a)',16);
put_tag(fig,axs(2),[.025,.9],'(b)',16);
put_tag(fig,axs(3),[.025,.9],'(c)',16);
set(fig,'color','w');