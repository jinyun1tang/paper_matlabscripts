close all;
clear all;

[obs,cres1,cres2,~,q10f_pct,q10s_pct]=resomsubincub_exp2p('OBSSYNTOP',1);
 
figh=figure(6);
ax=multipanel(figh,2,2,[0.1,0.1],[0.4,0.35],[0.05,0.075]);

set_curAX(figh,ax(1));


errorbar(obs.days10C,obs.obs10C.*100,obs.err10C.*100,'LineWidth',2);
hold on;
plot(obs.days20C,cres2'.*100,'k','LineWidth',2);
plot(obs.days10C,obs.obs10C.*100,'k','LineWidth',2);
errorbar(obs.days20C,obs.obs20C.*100,obs.err20C.*100,'LineWidth',2);


set_curAX(figh,ax(3));
boxplot([q10f_pct',q10s_pct'],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(3),'TickLabelInterpreter','tex');


iofile='syntop_summary.mat';
syntop.obs=obs;
syntop.cres1=cres1;
syntop.cres2=cres2;
syntop.q10f_pct=q10f_pct;
syntop.q10s_pct=q10s_pct;
save(iofile,'syntop');

[obs,cres1,cres2,~,q10f_pct,q10s_pct]=resomsubincub_exp2p('OBSSYN100',1);
 

%figure;
%errorbar(Qintop10C(:,1),Qintop10C(:,2),Qintop10C(:,3),'LineWidth',2);
%hold on;
%errorbar(Qintop20C(:,1),Qintop20C(:,2),Qintop20C(:,3),'LineWidth',2);
set(0,'CurrentFigure',figh);
set_curAX(figh,ax(2));

errorbar(obs.days10C,obs.obs10C.*100,obs.err10C.*100,'LineWidth',2);
hold on;

plot(obs.days10C,cres1'.*100,'g','LineWidth',2);

plot(obs.days20C,cres2'.*100,'g','LineWidth',2);

errorbar(obs.days20C,obs.obs20C.*100,obs.err20C.*100,'LineWidth',2);

xlabel('Day','FontSize',16);
ylabel('% Carbon respired','FontSize',16);
set_curAX(figh,ax(4));
boxplot([q10f_pct',q10s_pct'],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(4),'TickLabelInterpreter','tex');


set_curAX(figh,ax(4));



xlabel('Day','FontSize',16);
ylabel('% Carbon respired','FontSize',16);
put_tag(figh,ax(1),[0.05,0.85],'A',24);
put_tag(figh,ax(2),[0.05,0.85],'B',24);
put_tag(figh,ax(3),[0.05,0.85],'C',24);
put_tag(figh,ax(4),[0.05,0.85],'D',24);
set(ax,'FontSize',16);


iofile='synbot_summary.mat';
synbot.obs=obs;
synbot.cres1=cres1;
synbot.cres2=cres2;
synbot.q10f_pct=q10f_pct;
synbot.q10s_pct=q10s_pct;
save(iofile,'synbot');