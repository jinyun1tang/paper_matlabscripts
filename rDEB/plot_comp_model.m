close all;
clear all;
load('parcomp.mat');
load('growth_data_CO2/co2_nontreat.mat');
global obs;
load('growth_data_CO2/co2_nontreat.mat');
obs.t1=ts;
obs.yco2=dd;
obs.std=ds;

global par;
tend=500;
par=parcomp;
[t2,y2]=ode23s(@mic_dyngrowth_composite,[0,tend],y0);


plot(t2,y2(:,parcomp.vid.CO2),'LineWidth',2);
hold on;
errorbar(obs.t1,obs.yco2,obs.std,'LineWidth',2);
xlabel('Hour','FontSize',18);
ylabel('Cumulative CO_2 (mgC/L)','FontSize',18);
ylim([0,30]);
set(gca,'FontSize',18);

legend('Composite model','Measurements','Location','Best');