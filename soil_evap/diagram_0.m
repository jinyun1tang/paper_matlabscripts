close all;
clear all;
clc;

fontsz=18;
linewd=2;
x=(0:100).*0.9/100;
y=-1000.*(x-0.385).*(x-0.39)+30;
x0=[0.05,0.12,(0.385+0.39)./2];
y1=x0.*0;



plot(x,y,'LineWidth',linewd);
hold on;
plot(x,y.*0,'k');
ylim([min(y),max(y)+20]);
xlim([0,0.9]);
plot(x0,y1,'ro','MarkerSize',14,'MarkerFaceColor','r');
plot(0.7,0.,'kd','MarkerSize',14,'MarkerFaceColor','k');
set(gca,'YTick',0);

set(gca,'XTick',0);
set(gca,'FontSize',fontsz);
%text(0.6,min(y),'$\theta_2$','Interpreter','LaTex');
ylm=get(gca,'Ylim');
text(0.05,-40,'$\theta_{w2}$','Interpreter','LaTex','FontSize',fontsz);
text(0.7,-40,'$\theta_{w1,1}$','Interpreter','LaTex','FontSize',fontsz);
text(0.12,40,'$\theta_{w1,2}$','Interpreter','LaTex','FontSize',fontsz);
text(0.3875,-40,'$\theta_{c}$','Interpreter','LaTex','FontSize',fontsz);


ylabel('$\frac{dln(-P)}{d\theta}$','FontSize',fontsz,'Interpreter','LaTex');
xlabel('$\theta$','FontSize',fontsz,'Interpreter','LaTex');
