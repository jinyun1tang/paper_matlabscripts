close all;
clear all;
load('Qin_topsoil.mat');
figh=1;
ax=multipanel(figh,3,2,[0.1,0.05],[0.42,0.25],[0.02,0.075]);

%% topsoil
%without bound on q10
load('qinftop_summary_o100.mat');

Extra.id_f1=1;
Extra.id_k1_tl=2;
Extra.id_k2_tl=3;
Extra.id_k1_th=4;
Extra.id_k2_th=5;

Extra.ctot=1.0;

Extra.f1_0=1.;
Extra.k1_0=1.;
Extra.k2_0=1.;
Extra.tl=(1:330);
Extra.th=(1:330);

ns=numel(top_o100.flab);
nt=numel(Extra.tl);
cres11=zeros(ns,nt);
cres22=zeros(ns,nt);
q10f_inf=top_o100.k1w./top_o100.k1c;
q10s_inf=top_o100.k2w./top_o100.k2c;

for jj = 1 : ns
    xj=[top_o100.flab(jj),top_o100.k1c(jj),top_o100.k2c(jj),...
        top_o100.k1w(jj),top_o100.k2w(jj)];
    [cumresp1,cumresp2]=twopool_modelwoc_f2(xj,Extra);
    cres11(jj,:)=cumresp1.*100;
    cres22(jj,:)=cumresp2.*100;    
end

cres1=prctile(cres11,(0.1:0.2:99.9),1);
cres2=prctile(cres22,(0.1:0.2:99.9),1);

set_curAX(figh,ax(1));

h10c=errorbar(Qintop10C(:,1),Qintop10C(:,2).*100,Qintop10C(:,3).*100,'r.');
hold on;
h20c=errorbar(Qintop20C(:,1),Qintop20C(:,2).*100,Qintop20C(:,3).*100,'b.');

h1=plot(Extra.tl,cres1,'k-','LineWidth',2);
plot(Extra.tl,cres2,'k-','LineWidth',2);
clear top_o100;
%%
%q10 bound to 100

load('q00004top_summary_o100.mat');


cres11=zeros(ns,nt);
cres22=zeros(ns,nt);
q10f_q4=top_o100.k1w./top_o100.k1c;
q10s_q4=top_o100.k2w./top_o100.k2c;
fprintf('-------------------------\n');
fprintf('Topsoil');
fprintf('Q10 no upper bound\n');
fprintf('q10f: mean=%f, std=%f, max=%f, min=%f\n',mean(q10f_inf),std(q10f_inf),...
    max(q10f_inf),min(q10f_inf));
fprintf('q10s: mean=%f, std=%f, max=%f, min=%f\n',mean(q10s_inf),std(q10s_inf),...
    max(q10s_inf),min(q10s_inf));
fprintf('Q10 upper bound 4\n');
fprintf('q10f: mean=%f, std=%f, max=%f, min=%f\n',mean(q10f_q4),std(q10f_q4),...
    max(q10f_q4),min(q10f_q4));
fprintf('q10s: mean=%f, std=%f, max=%f, min=%f\n',mean(q10s_q4),std(q10s_q4),...
    max(q10s_q4),min(q10s_q4));

for jj = 1 : ns
    xj=[top_o100.flab(jj),top_o100.k1c(jj),top_o100.k2c(jj),...
        top_o100.k1w(jj),top_o100.k2w(jj)];
    [cumresp1,cumresp2]=twopool_modelwoc_f2(xj,Extra);
    cres11(jj,:)=cumresp1.*100;
    cres22(jj,:)=cumresp2.*100;    
end

cres1=prctile(cres11,(0.1:0.2:99.9),1);
cres2=prctile(cres22,(0.1:0.2:99.9),1);
h2=plot(Extra.tl,cres1,'g--','LineWidth',2);
plot(Extra.tl,cres2,'g--','LineWidth',2);

legend([h10c,h20c,h1(1),h2(1)],{'10\circC data','20\circC data','Inversion 1: Q_{10}>0','Inversion 2: 0<Q_{10}\leq4'},'FontSize',16,'location','best');


set_curAX(figh,ax(3));
boxplot([q10f_inf,q10s_inf],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(3),'TickLabelInterpreter','tex');

set_curAX(figh,ax(5));
boxplot([q10f_q4,q10s_q4],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(5),'TickLabelInterpreter','tex');
clear top_o100;
%% subsoi
%without bound on q10

set_curAX(figh,ax(2));
load('Qin_subsoil.mat');
h10c=errorbar(Qinsub10C(:,1),Qinsub10C(:,2).*100,Qinsub10C(:,3).*100,'r.');
hold on;
h20c=errorbar(Qinsub20C(:,1),Qinsub20C(:,2).*100,Qinsub20C(:,3).*100,'b.');
%% q10 without bound
load('qinfbot_summary_o100.mat');
q10f_inf=bot_o100.k1w./bot_o100.k1c;
q10s_inf=bot_o100.k2w./bot_o100.k2c;

for jj = 1 : ns
    xj=[bot_o100.flab(jj),bot_o100.k1c(jj),bot_o100.k2c(jj),...
        bot_o100.k1w(jj),bot_o100.k2w(jj)];
    [cumresp1,cumresp2]=twopool_modelwoc_f2(xj,Extra);
    cres11(jj,:)=cumresp1.*100;
    cres22(jj,:)=cumresp2.*100;    
end

cres1=prctile(cres11,(0.1:0.2:99.9),1);
cres2=prctile(cres22,(0.1:0.2:99.9),1);

plot(Extra.tl,cres1,'k-','LineWidth',2);
plot(Extra.tl,cres2,'k-','LineWidth',2);
clear bot_o100;
%%
load('q00004bot_summary_o100.mat');

q10f_q4=bot_o100.k1w./bot_o100.k1c;
q10s_q4=bot_o100.k2w./bot_o100.k2c;

for jj = 1 : ns
    xj=[bot_o100.flab(jj),bot_o100.k1c(jj),bot_o100.k2c(jj),...
        bot_o100.k1w(jj),bot_o100.k2w(jj)];
    [cumresp1,cumresp2]=twopool_modelwoc_f2(xj,Extra);
    cres11(jj,:)=cumresp1.*100;
    cres22(jj,:)=cumresp2.*100;    
end

cres1=prctile(cres11,(0.1:0.2:99.9),1);
cres2=prctile(cres22,(0.1:0.2:99.9),1);

plot(Extra.tl,cres1,'g--','LineWidth',2);
plot(Extra.tl,cres2,'g--','LineWidth',2);
fprintf('-------------------------\n');
fprintf('Subsoil');
fprintf('Q10 no upper bound\n');
fprintf('q10f: mean=%f, std=%f, max=%f, min=%f\n',mean(q10f_inf),std(q10f_inf),...
    max(q10f_inf),min(q10f_inf));
fprintf('q10s: mean=%f, std=%f, max=%f, min=%f\n',mean(q10s_inf),std(q10s_inf),...
    max(q10s_inf),min(q10s_inf));
fprintf('Q10 upper bound 4\n');
fprintf('q10f: mean=%f, std=%f, max=%f, min=%f\n',mean(q10f_q4),std(q10f_q4),...
    max(q10f_q4),min(q10f_q4));
fprintf('q10s: mean=%f, std=%f, max=%f, min=%f\n',mean(q10s_q4),std(q10s_q4),...
    max(q10s_q4),min(q10s_q4));


set_curAX(figh,ax(4));
boxplot([q10f_inf,q10s_inf],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(4),'TickLabelInterpreter','tex');

set_curAX(figh,ax(6));
boxplot([q10f_q4,q10s_q4],'Notch','on','Labels',{'Active pool Q_{10}','Slow pool Q_{10}'})
set(ax(6),'TickLabelInterpreter','tex');

set(ax(5:6),'Ylim',[1,5]);
set(ax,'FontSize',16);


set(ax(1:2),'Ylim',[0,15]);
put_tag(figh,ax(1),[0.05,0.85],'a',24);
put_tag(figh,ax(2),[0.05,0.85],'b',24);
put_tag(figh,ax(3),[0.05,0.85],'c  Inversion 1: Q_{10}>0',24);
put_tag(figh,ax(4),[0.05,0.85],'d  Inversion 1: Q_{10}>0',24);
put_tag(figh,ax(5),[0.05,0.85],'e  Inversion 2: 0<O_{10}\leq4',24);
put_tag(figh,ax(6),[0.05,0.85],'f  Inversion 2: 0<Q_{10}\leq4',24);

set_curAX(figh,ax(1));title('Topsoil','FontSize',16);xlabel('Day','FontSize',16);
set_curAX(figh,ax(2));title('Subsoil','FontSize',16);
