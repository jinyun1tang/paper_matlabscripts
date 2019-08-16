close all;
clear all;

[obs,cres1,cres2,~,q10f_pct,q10s_pct]=resomsubincub_exp2p('obs100',1);
 
load('Qin_topsoil.mat');
load('Qin_subsoil.mat');

figh=figure(6);
ax=multipanel(figh,2,2,[0.1,0.1],[0.4,0.35],[0.05,0.075]);

set_curAX(figh,ax(2));

h10c=errorbar(Qinsub10C(:,1),Qinsub10C(:,2).*100,Qinsub10C(:,3).*100,'LineWidth',2);
hold on;
h20c=errorbar(Qinsub20C(:,1),Qinsub20C(:,2).*100,Qinsub20C(:,3).*100,'LineWidth',2);


h1=plot(obs.days10C,cres1'.*100,'k');

plot(obs.days20C,cres2'.*100,'k');

set_curAX(figh,ax(3));
boxplot([q10f_pct',q10s_pct'],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(3),'TickLabelInterpreter','tex');

[obs,cres1,cres2,~,q10f_pct,q10s_pct]=resomsubincub_exp2p('obs75',1);
 
load('Qin_topsoil.mat');
load('Qin_subsoil.mat');

%figure;
%errorbar(Qinsub10C(:,1),Qinsub10C(:,2),Qinsub10C(:,3),'LineWidth',2);
%hold on;
%errorbar(Qinsub20C(:,1),Qinsub20C(:,2),Qinsub20C(:,3),'LineWidth',2);
set(0,'CurrentFigure',figh);
set_curAX(figh,ax(2));
h2=plot(obs.days10C,cres1'.*100,'g');

plot(obs.days20C,cres2'.*100,'g');

legend([h10c,h20c,h1(1),h2(1)],{'10\circC data','20\circC data','Inversion 1','Inversion 2'},'FontSize',16,'location','best');

xlabel('Day','FontSize',16);
ylabel('% Carbon respired','FontSize',16);
set_curAX(figh,ax(4));
boxplot([q10f_pct',q10s_pct'],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(4),'TickLabelInterpreter','tex');


Ms=1800;

incubator=get_incubation(Ms,'middle');
set_curAX(figh,ax(1));

h10c=errorbar(Qinsub10C(:,1),Qinsub10C(:,2).*100,Qinsub10C(:,3).*100,'LineWidth',2);
hold on;
h20c=errorbar(Qinsub20C(:,1),Qinsub20C(:,2).*100,Qinsub20C(:,3).*100,'LineWidth',2);

h3=plot(incubator.cumresp_T10C.*100./incubator.Ctot,'b','LineWidth',2);
hold on;
plot(incubator.cumresp_T20C.*100./incubator.Ctot,'b','LineWidth',2);

legend([h10c,h20c,h3(1)],{'10\circC data','20\circC data','RESOM Sim'},'FontSize',16,'location','best');

xlabel('Day','FontSize',16);
ylabel('% Carbon respired','FontSize',16);
put_tag(figh,ax(1),[0.05,0.85],'a',18);
put_tag(figh,ax(2),[0.05,0.85],'b',18);
put_tag(figh,ax(3),[0.05,0.85],'c',18);
put_tag(figh,ax(4),[0.05,0.85],'d',18);
set(ax,'FontSize',16);