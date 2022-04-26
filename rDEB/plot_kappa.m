close all;
clear all;

x=(0.05:0.01:10);


plot(x,x.*(1./(1+x)),'LineWidth',2);
hold on;
plot(x,x.*(1./(1+x)).^2,'r','LineWidth',2);

xlabel('Volume based non-structural biomass density x_V_N','FontSize',18);
ylabel('Normalized specific reserve mobilization rate \kappa/\kappa_0','FontSize',18);
set(gca,'FontSize',18);
legend('\delta=1.0','\delta=2.5');