%Clear the work space
clear all;
close all;
addpath('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB');
%Define parameters for the composite model
load('parcomp_opt.mat');
par=parcomp;
%Define the range of substrates
S0=(3.e-4:1.e-2:5.e0);
S1=S0.*par.KS;
%Plot the composite model
[umax1,mq1,u1,q1]=mic_growth_composite(S1,par);
ax(1)=subplot(3,1,1);plot(S0,u1,'-','LineWidth',2);
ax(2)=subplot(3,1,2);plot(S0,q1,'-','LineWidth',2);
ax(3)=subplot(3,1,3);plot(u1,q1,'-','LineWidth',2);
set(ax,'FontSize',16);

%Define parameters for the standard DEB (sDEB) model
load('parsdeb_opt.mat');
par=parsdeb;
S2=S0.*par.KS;
[umax2,mq2,u2,q2,YG2]=mic_growth_sdeb(S2,par);
%Plot for the standard DEB model
figure;
ax(1)=subplot(3,1,1);plot(S0,u2,'-','LineWidth',2);
ax(2)=subplot(3,1,2);plot(S0,q2,'-','LineWidth',2);
ax(3)=subplot(3,1,3);plot(u2,q2,'-','LineWidth',2);
title('sdeb');
set(ax,'FontSize',16);

%Define parameters for the revised DEB (rDEB) model
load('parrdeb_opt.mat');
par=parrdeb;
S3=S0.*par.KS;
[umax3,mq3,u3,q3,YG1]=mic_growth_rdeb(S3,par);
%Plot for the revised DEB model
figure;
ax(1)=subplot(3,1,1);plot(S0,u3,'-','LineWidth',2);
ax(2)=subplot(3,1,2);plot(S0,q3,'-','LineWidth',2);
ax(3)=subplot(3,1,3);plot(u3,q3,'-','LineWidth',2);
title('rdeb')
set(ax,'FontSize',16);
%Compare the substrate use efficiency
figure;
subplot(2,1,1);
semilogx(u1(u1>0),u1(u1>0)./q1(u1>0),'LineWidth',2);
hold on;
semilogx(u2(u2>0),u2(u2>0)./q2(u2>0),'LineWidth',2);
semilogx(u3(u3>0),u3(u3>0)./q3(u3>0),'LineWidth',2);
set(gca,'FontSize',16);
xlabel('Growth rate (h^-^1)','FontSize',16);
ylabel('SUE','FontSize',16);
ylim([-0.2,1]);
legend('Composite model','sDEB model','rDEB model','Location','Best');
subplot(2,1,2);
plot(u2,YG2,'LineWidth',2);
hold on;
plot(u3,YG1,'LineWidth',2);
set(gca,'FontSize',16)

fprintf('comp: umax=%f,mq=%f,mq/umax=%f\n',umax1,mq1,mq1/umax1);
fprintf('sDEB: umax=%f,mq=%f,mq/umax=%f\n',umax2,mq2,mq2/umax2);
fprintf('rDEB: umax=%f,mq=%f,mq/umax=%f\n',umax3,mq3,mq3/umax3);

