close all;
clear all;
addpath('/Users/jinyuntang/work/github/matlab_tools/');
addpath('/Users/jinyuntang/work/github/matlab_tools/export_fig');
fig=figure(1);
u=(0:0.05:10);
%Composite model
%set maximum growth rate to 10 times of maintenance respiration.
m0=1;
plot(u,u./(u+m0),'LineWidth',2);
hold on;
k0=10*m0;
Ys=u./(u+m0).*(1-u./k0);
plot(u,Ys,'LineWidth',2);
fN=0.2;YRN=0.6;
Yr1=u./(u+m0).*((1-fN)./(1-YRN*fN)-u./((1-YRN*fN)*k0));
fN=0.6;
Yr2=u./(u+m0).*((1-fN)./(1-YRN*fN)-u./((1-YRN*fN)*k0));
plot(u,Yr1,'LineWidth',2);
plot(u,Yr2,'LineWidth',2);
ylim([0,1]);
legend('Composite model','sDEB model','rDEB model: f_N_r=0.2',...
    'rDEB model: f_N_r=0.6','location','best');
%lgd=legend('Composite: \mu_m_a_x=10m_q','Composite: \mu_m_a_x=20m_q',...
%    'sDEB: \mu_m_a_x=\kappa_0=10m_V_s_D_E_B','sDEB: \mu_m_a_x=\kappa_0=20m_V_s_D_E_B',...
%    'Location','Best');
%lgd.FontSize=14;
xlabel('\mu/m_V','FontSize',14);
ylabel('Y_a_p_p/Y_m_a_x','FontSize',14);
set(gca,'FontSize',14);
set(gcf,'color','w');
