close all;
clear all;
load('Qin_topsoil.mat');
load('Qin_subsoil.mat');
load('synbot_summary.mat');
load('syntop_summary.mat');


figh=1;
ax=multipanel(figh,2,2,[0.1,0.1],[0.42,0.4],[0.02,0.035]);
set_curAX(figh,ax(1));

Ms=575;

incubator=get_incubation(Ms,'upper');
set_curAX(figh,ax(1));

h10c=errorbar(Qintop10C(:,1),Qintop10C(:,2).*100,Qintop10C(:,3).*100,'LineWidth',2);
hold on;
h20c=errorbar(Qintop20C(:,1),Qintop20C(:,2).*100,Qintop20C(:,3).*100,'LineWidth',2);

h3=plot(incubator.cumresp_T10C.*100./incubator.Ctot,'b--','LineWidth',2);
hold on;
plot(incubator.cumresp_T20C.*100./incubator.Ctot,'r--','LineWidth',2);


title('Topsoil','FontSize',16);
ylabel('% Carbon respired','FontSize',16);


Ms=1800;

incubator=get_incubation(Ms,'middle');
set_curAX(figh,ax(2));

h10c=errorbar(Qinsub10C(:,1),Qinsub10C(:,2).*100,Qinsub10C(:,3).*100,'LineWidth',2);
hold on;
h20c=errorbar(Qinsub20C(:,1),Qinsub20C(:,2).*100,Qinsub20C(:,3).*100,'LineWidth',2);

h3=plot(incubator.cumresp_T10C.*100./incubator.Ctot,'b--','LineWidth',2);
hold on;
h4=plot(incubator.cumresp_T20C.*100./incubator.Ctot,'r--','LineWidth',2);

legend([h10c,h20c,h3(1),h4(1)],{'10\circC data','20\circC data',...
    'RESOM Sim 10\circC','RESOM Sim 20\circC'},'FontSize',16,'location','best');
title('Subsoil','FontSize',16);


set_curAX(figh,ax(3));
h3=plot(log(incubator.cumresp_T10C.*100./incubator.Ctot),'b--','LineWidth',2);
hold on;
h5=plot((2:numel(incubator.cumresp_T10C))-1,log(syntop.cres1'.*100),'k','LineWidth',2);
h4=plot(log(incubator.cumresp_T20C.*100./incubator.Ctot),'r--','LineWidth',2);
h6=plot((2:numel(incubator.cumresp_T10C))-1,log(syntop.cres2'.*100),'k','LineWidth',2);

xlabel('Day','FontSize',16);
ylabel('log(% Carbon respired)','FontSize',16);
set_curAX(figh,ax(4));
plot(log(incubator.cumresp_T10C.*100./incubator.Ctot),'b--','LineWidth',2);
hold on;
h5=plot((2:numel(incubator.cumresp_T10C))-1,log(synbot.cres1'.*100),'k','LineWidth',2);
plot(log(incubator.cumresp_T20C.*100./incubator.Ctot),'r--','LineWidth',2);
h6=plot((2:numel(incubator.cumresp_T10C))-1,log(synbot.cres2'.*100),'k','LineWidth',2);
legend(h6(1),'Two-pool model fit','FontSize',16);
xlabel('Day','FontSize',16);
set(ax(1:2),'XTickLabel','','YLim',[0,14]);
set(ax([2,4]),'YTickLabel','');
put_tag(figh,ax(1),[0.05,0.85],'a',24);
put_tag(figh,ax(2),[0.05,0.85],'b',24);
put_tag(figh,ax(3),[0.05,0.85],'c',24);
put_tag(figh,ax(4),[0.05,0.85],'d',24);
set(ax,'FontSize',16);

