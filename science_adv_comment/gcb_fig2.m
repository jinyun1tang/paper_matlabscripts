close all;
clear all;
load('bot_summary_o100.mat');
load('bot_summary_o75.mat');
load('top_summary_o100.mat');
load('top_summary_o75.mat');
load('Qin_topsoil.mat');
figh=1;
ax=multipanel(figh,3,2,[0.1,0.05],[0.42,0.25],[0.02,0.075]);

set_curAX(figh,ax(1));
h10c=errorbar(Qintop10C(:,1),Qintop10C(:,2).*100,Qintop10C(:,3).*100,'LineWidth',2);
hold on;
h20c=errorbar(Qintop20C(:,1),Qintop20C(:,2).*100,Qintop20C(:,3).*100,'LineWidth',2);


h1=plot(top_o100.obs.days10C,top_o100.cres1'.*100,'k--','LineWidth',2);

plot(top_o100.obs.days20C,top_o100.cres2'.*100,'k--','LineWidth',2);

h2=plot(top_o75.obs.days10C,top_o75.cres1'.*100,'b--','LineWidth',2);

plot(top_o75.obs.days20C,top_o75.cres2'.*100,'b--','LineWidth',2);

set(ax(1),'Ylim',[0,15]);
legend([h10c,h20c,h1(1),h2(1)],{'10\circC data','20\circC data','Inversion 1','Inversion 2'},'FontSize',16,'location','best');

xlabel('Day','FontSize',16);
ylabel('% Carbon respired','FontSize',16);
title('Topsoil','FontSize',16);
set_curAX(figh,ax(3));

boxplot([top_o100.q10f_pct',top_o100.q10s_pct'],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(3),'TickLabelInterpreter','tex','Ylim',[1.5,5]);


set_curAX(figh,ax(5));

boxplot([top_o75.q10f_pct',top_o75.q10s_pct'],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(5),'TickLabelInterpreter','tex','Ylim',[1.5,5]);

set_curAX(figh,ax(2));
load('Qin_subsoil.mat');
h10c=errorbar(Qinsub10C(:,1),Qinsub10C(:,2).*100,Qinsub10C(:,3).*100,'LineWidth',2);
hold on;
h20c=errorbar(Qinsub20C(:,1),Qinsub20C(:,2).*100,Qinsub20C(:,3).*100,'LineWidth',2);
h1=plot(bot_o100.obs.days10C,bot_o100.cres1'.*100,'k--','LineWidth',2);

plot(bot_o100.obs.days20C,bot_o100.cres2'.*100,'k--','LineWidth',2);

h2=plot(bot_o75.obs.days10C,bot_o75.cres1'.*100,'b--','LineWidth',2);

plot(bot_o75.obs.days20C,bot_o75.cres2'.*100,'b--','LineWidth',2);

set(ax(2),'Ylim',[0,15]);

xlabel('Day','FontSize',16);
title('Subsoil','FontSize',16);
set_curAX(figh,ax(4));

boxplot([bot_o100.q10f_pct',bot_o100.q10s_pct'],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(3),'TickLabelInterpreter','tex','Ylim',[1.5,5]);


set_curAX(figh,ax(6));

boxplot([bot_o75.q10f_pct',bot_o75.q10s_pct'],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(6),'TickLabelInterpreter','tex','Ylim',[1.5,5]);
set(ax(3:6),'Ylim',[1,5]);
set(ax,'FontSize',16);


put_tag(figh,ax(1),[0.05,0.85],'a',24);
put_tag(figh,ax(2),[0.05,0.85],'b',24);
put_tag(figh,ax(3),[0.05,0.85],'c 100% Oberr',24);
put_tag(figh,ax(4),[0.05,0.85],'d 100% Oberr',24);
put_tag(figh,ax(5),[0.05,0.85],'e 75% Oberr',24);
put_tag(figh,ax(6),[0.05,0.85],'f 75% Oberr',24);
