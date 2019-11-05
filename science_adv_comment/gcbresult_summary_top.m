close all;
clear all;
qrange=70;
iofile1=sprintf('q%05d%s',qrange,'top_summary_o100.mat');
iofile2=sprintf('q%05d%s',qrange,'top_summary_o75.mat');

%iofile1=sprintf('qinf%s','top_summary_o100.mat');
%iofile2=sprintf('qinf%s','top_summary_o75.mat');

[obs,cres1,cres2,~,q10f,q10s,flab,k1c,k2c,k1w,k2w]=gcbresomsubincub_exp2p('obs100top',1,qrange);
 
load('Qin_topsoil.mat');
load('Qin_subsoil.mat');

figh=figure(6);
ax=multipanel(figh,2,2,[0.1,0.1],[0.4,0.35],[0.05,0.075]);

set_curAX(figh,ax(2));

h10c=errorbar(Qintop10C(:,1),Qintop10C(:,2).*100,Qintop10C(:,3).*100,'.');
hold on;
h20c=errorbar(Qintop20C(:,1),Qintop20C(:,2).*100,Qintop20C(:,3).*100,'.');

h1=plot(obs.days10C,cres1'.*100,'k','LineWidth',2);

plot(obs.days20C,cres2'.*100,'k','LineWidth',2);

set_curAX(figh,ax(3));
boxplot([q10f,q10s],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(3),'TickLabelInterpreter','tex');



top_o100.obs=obs;
top_o100.cres1=cres1;
top_o100.cres2=cres2;
top_o100.q10f=q10f;
top_o100.q10s=q10s;
top_o100.flab=flab;
top_o100.k1c=k1c;
top_o100.k2c=k2c;
top_o100.k1w=k1w;
top_o100.k2w=k2w;
save(iofile1,'top_o100');

[obs,cres1,cres2,~,q10f,q10s,flab,k1c,k2c,k1w,k2w]=gcbresomsubincub_exp2p('obs75top',1,qrange);
 
load('Qin_topsoil.mat');
load('Qin_subsoil.mat');

%figure;
%errorbar(Qintop10C(:,1),Qintop10C(:,2),Qintop10C(:,3),'LineWidth',2);
%hold on;
%errorbar(Qintop20C(:,1),Qintop20C(:,2),Qintop20C(:,3),'LineWidth',2);
set(0,'CurrentFigure',figh);
set_curAX(figh,ax(2));
h2=plot(obs.days10C,cres1'.*100,'g','LineWidth',2);

plot(obs.days20C,cres2'.*100,'g','LineWidth',2);

legend([h10c,h20c,h1(1),h2(1)],{'10\circC data','20\circC data','Inversion 1','Inversion 2'},'FontSize',16,'location','best');

xlabel('Day','FontSize',16);
ylabel('% Carbon respired','FontSize',16);
set_curAX(figh,ax(4));
boxplot([q10f,q10s],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(4),'TickLabelInterpreter','tex');


Ms=575;

incubator=get_incubation(Ms,'upper');
set_curAX(figh,ax(1));

h10c=errorbar(Qintop10C(:,1),Qintop10C(:,2).*100,Qintop10C(:,3).*100,'.');
hold on;
h20c=errorbar(Qintop20C(:,1),Qintop20C(:,2).*100,Qintop20C(:,3).*100,'.');

h3=plot(incubator.cumresp_T10C.*100./incubator.Ctot,'b','LineWidth',2);
hold on;
plot(incubator.cumresp_T20C.*100./incubator.Ctot,'b','LineWidth',2);

legend([h10c,h20c,h3(1)],{'10\circC data','20\circC data','RESOM Sim'},'FontSize',16,'location','best');

xlabel('Day','FontSize',16);
ylabel('% Carbon respired','FontSize',16);
put_tag(figh,ax(1),[0.05,0.85],'A',24);
put_tag(figh,ax(2),[0.05,0.85],'B',24);
put_tag(figh,ax(3),[0.05,0.85],'C',24);
put_tag(figh,ax(4),[0.05,0.85],'D',24);
set(ax,'FontSize',16);



top_o75.obs=obs;
top_o75.cres1=cres1;
top_o75.cres2=cres2;
top_o75.q10f=q10f;
top_o75.q10s=q10s;
top_o75.flab=flab;
top_o75.k1c=k1c;
top_o75.k2c=k2c;
top_o75.k1w=k1w;
top_o75.k2w=k2w;
save(iofile2,'top_o75');