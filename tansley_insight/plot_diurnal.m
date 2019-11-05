close all;
figh=1;
ax=multipanel(figh,1,2,[0.08,0.1],[0.35,0.8],[0.185,0.085]);
set_curAX(figh,ax(1));
fontsz=28;
linwd=4;
load('okuyama/Okuyama_NO3.mat');
nel=size(Okuyama_NO3,1);
doft=mean(reshape(Okuyama_NO3(:,1),[3,nel/3]),1);
dofno3=reshape(Okuyama_NO3(:,2),[3,nel/3]);
dofno3m=mean(dofno3,1);
dofno3u=(max(dofno3,[],1)-min(dofno3,[],1)).*0.5;
yyaxis left;
errorbar(doft,dofno3m,dofno3u,'LineWidth',linwd);
ylabel('Cucumber NO_3-N absorption (mg m^-^2 LA h^-^1)','FontSize',fontsz);
load('okuyama/okuyama_solR.mat');
yyaxis right;
plot(okuyama_solR(:,1),okuyama_solR(:,2),'-','LineWidth',linwd);
xlim([0,24]);ylim([-0.8,3.2]);
set(ax(1),'FontSize',28,'XTick',(0:6:24));
ylabel('Soloar Radiation (MJ m^-^2 h^-^1)','FontSize',fontsz);
xlabel('Hour of day','FontSize',fontsz);
load('chapin/h2po4_chapin_season.mat');
set_curAX(figh,ax(2));
plot(h2po4_chapin_season(:,1),h2po4_chapin_season(:,2),'-o','LineWidth',linwd);
ylabel('Phosphate Absorption rate (mg Pi g^-^1 DW day^-^1)','FontSize',fontsz); 
xlim([-0.2,7.2]);
load('chapin/chapin_PO4_fig2.mat');
xr=get(ax(2),'xlim');
yr=get(ax(2),'ylim');
X=([chapin_PO4_fig2(9,1),chapin_PO4_fig2(9,1)]-xr(1))./(xr(2)-xr(1));
Y=([0.16,0.11]-yr(1))./(yr(2)-yr(1));

ax2pos=get(ax(2),'position');
X=ax2pos(1)+ax2pos(3).*X;
Y=ax2pos(2)+ax2pos(4).*Y;
annotation('arrow',X,Y,'LineWidth',linwd*2,'HeadWidth',30,'Headlength',30);

set(ax(2),'xticklabel',{'15','30','15','31','15','31','15','30'},'FontSize',fontsz);
put_tag(figh,ax(2),[0.05,-0.075],'June',fontsz);
put_tag(figh,ax(2),[0.27,-0.075],'July',fontsz);
put_tag(figh,ax(2),[0.545,-0.075],'Aug',fontsz);
put_tag(figh,ax(2),[0.81,-0.075],'Sep',fontsz);

put_tag(figh,ax(2),[0.05,0.95],'b',fontsz);
put_tag(figh,ax(1),[0.05,0.95],'a',fontsz);




