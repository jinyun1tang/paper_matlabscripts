function gcb_fig1final()

figh=1;
ax=multipanel(figh,2,2,[0.075,0.075],[0.42,0.4],[0.05,0.075]);
clc=load_color7();
%% do topsoil
load('Qin_topsoil.mat');
set_curAX(figh,ax(1));

h10c=errorbar(Qintop10C(:,1),Qintop10C(:,2).*100,Qintop10C(:,3).*100,'r.','MarkerSize',12);
h10c.CapSize = 12;
hold on;
h20c=errorbar(Qintop20C(:,1),Qintop20C(:,2).*100,Qintop20C(:,3).*100,'b.','MarkerSize',12);
h20c.CapSize = 12;
fprintf('Topsoil\n');
% q4
load('q00004top_summary_o100.mat');

[q10f_q4,q10s_q4,tl,cres1,cres2]=get_sims(top_o100,'IQ 4');

set_curAX(figh,ax(1));
h1=plot(tl,cres1,'--','LineWidth',2,'color',clc(1,:));
plot(tl,cres2,'--','LineWidth',2,'color',clc(1,:));

load('q00010top_summary_o100.mat');

[q10f_q10,q10s_q10,tl,cres1,cres2]=get_sims(top_o100,'IQ 10');

h2=plot(tl,cres1,'g--','LineWidth',2,'color',clc(2,:));
plot(tl,cres2,'g--','LineWidth',2,'color',clc(2,:));

load('q00020top_summary_o100.mat');
[q10f_q20,q10s_q20,tl,cres1,cres2]=get_sims(top_o100,'IQ 20');

h3=plot(tl,cres1,'b--','LineWidth',2,'color',clc(3,:));
plot(tl,cres2,'b--','LineWidth',2,'color',clc(3,:));

load('q00040top_summary_o100.mat');
[q10f_q40,q10s_q40,tl,cres1,cres2]=get_sims(top_o100,'IQ 40');

h4=plot(tl,cres1,'c--','LineWidth',2,'color',clc(4,:));
plot(tl,cres2,'c--','LineWidth',2,'color',clc(4,:));

load('q00050top_summary_o100.mat');
[q10f_q50,q10s_q50,tl,cres1,cres2]=get_sims(top_o100,'IQ 50');

h5=plot(tl,cres1,'m--','LineWidth',2,'color',clc(5,:));
plot(tl,cres2,'m--','LineWidth',2,'color',clc(5,:));

load('q00070top_summary_o100.mat');
[q10f_q70,q10s_q70,tl,cres1,cres2]=get_sims(top_o100, 'IQ 70');

h6=plot(tl,cres1,'y--','LineWidth',2,'color',clc(6,:));
plot(tl,cres2,'y--','LineWidth',2,'color',clc(6,:));

load('q00100top_summary_o100.mat');
[q10f_q100,q10s_q100,tl,cres1,cres2]=get_sims(top_o100,'IQ 100');

h7=plot(tl,cres1,'k--','LineWidth',2,'color',clc(7,:));
plot(tl,cres2,'k--','LineWidth',2,'color',clc(7,:));
xlabel('Days','FontSize',16);
ylabel('% Carbon respired','FontSize',16);
set_curAX(figh,ax(3));
by=[-2.8019  102.2866];
bx=[0.5000   14.5000];
rectangle('Position', [bx(1),by(1),(bx(2)-bx(1))/2,(by(2)-by(1))], 'EdgeColor',[.5 .5 .5], 'FaceColor', [.91,.91,.91])
hold on;
boxplot([q10f_q4,q10f_q10,q10f_q20,q10f_q40,q10f_q50,q10f_q70,q10f_q100,...
    q10s_q4,q10s_q10,q10s_q20,q10s_q40,q10s_q50,q10s_q70,q10s_q100],'Notch','on',...
    'Labels',{'IQ4','IQ10','IQ20','IQ40','IQ50','IQ70','IQ100',...
    'IQ4','IQ10','IQ20','IQ40','IQ50','IQ70','IQ100'});
set(ax,'FontSize',16);
legend([h10c,h20c,h1(1),h2(1),h3(1),h4(1),h5(1),h6(1),h7(1)],...
    {'Observations @ 10\circC','Observations @ 20\circC','IQ4','IQ10','IQ20','IQ40','IQ50','IQ70','IQ100'});
%% subsoil
set_curAX(figh,ax(2));
load('Qin_subsoil.mat');
h10c=errorbar(Qinsub10C(:,1),Qinsub10C(:,2).*100,Qinsub10C(:,3).*100,'r.','MarkerSize',12);
h10c.CapSize=12;
hold on;
h20c=errorbar(Qinsub20C(:,1),Qinsub20C(:,2).*100,Qinsub20C(:,3).*100,'b.','MarkerSize',12);
h20c.CapSize=12;
fprintf('Subsoil\n');
% q4
load('q00004bot_summary_o100.mat');

[q10f_q4,q10s_q4,tl,cres1,cres2]=get_sims(bot_o100, 'IQ 4');

h1=plot(tl,cres1,'--','LineWidth',2,'color',clc(1,:));
plot(tl,cres2,'--','LineWidth',2,'color',clc(1,:));

load('q00010bot_summary_o100.mat');

[q10f_q10,q10s_q10,tl,cres1,cres2]=get_sims(bot_o100,'IQ 10');

h1=plot(tl,cres1,'g--','LineWidth',2,'color',clc(2,:));
plot(tl,cres2,'g--','LineWidth',2,'color',clc(2,:));

load('q00020bot_summary_o100.mat');
[q10f_q20,q10s_q20,tl,cres1,cres2]=get_sims(bot_o100,'IQ 20');

h1=plot(tl,cres1,'b--','LineWidth',2,'color',clc(3,:));
plot(tl,cres2,'b--','LineWidth',2,'color',clc(3,:));

load('q00040bot_summary_o100.mat');
[q10f_q40,q10s_q40,tl,cres1,cres2]=get_sims(bot_o100,'IQ 40');

h1=plot(tl,cres1,'c--','LineWidth',2,'color',clc(4,:));
plot(tl,cres2,'c--','LineWidth',2,'color',clc(4,:));

load('q00050bot_summary_o100.mat');
[q10f_q50,q10s_q50,tl,cres1,cres2]=get_sims(bot_o100,'IQ 50');

h1=plot(tl,cres1,'m--','LineWidth',2,'color',clc(5,:));
plot(tl,cres2,'m--','LineWidth',2,'color',clc(5,:));

load('q00070bot_summary_o100.mat');
[q10f_q70,q10s_q70,tl,cres1,cres2]=get_sims(bot_o100,'IQ 70');

h1=plot(tl,cres1,'y--','LineWidth',2,'color',clc(6,:));
plot(tl,cres2,'y--','LineWidth',2,'color',clc(6,:));

load('q00100bot_summary_o100.mat');
[q10f_q100,q10s_q100,tl,cres1,cres2]=get_sims(bot_o100,'IQ 100');

h1=plot(tl,cres1,'k--','LineWidth',2,'color',clc(7,:));
plot(tl,cres2,'k--','LineWidth',2,'color',clc(7,:));
xlabel('Days','FontSize',16);

set_curAX(figh,ax(4));
set(ax(4),'ylim',[-2.8019  102.2866]);
by=[-2.8019  102.2866];
bx=[0.5000   14.5000];
rectangle('Position', [bx(1),by(1),(bx(2)-bx(1))/2,(by(2)-by(1))], 'EdgeColor',[.5 .5 .5], 'FaceColor', [.91,.91,.91])
hold on;
boxplot([q10f_q4,q10f_q10,q10f_q20,q10f_q40,q10f_q50,q10f_q70,q10f_q100,...
    q10s_q4,q10s_q10,q10s_q20,q10s_q40,q10s_q50,q10s_q70,q10s_q100],'Notch','on',...
    'Labels',{'IQ4','IQ10','IQ20','IQ40','IQ50','IQ70','IQ100',...
    'IQ4','IQ10','IQ20','IQ40','IQ50','IQ70','IQ100'});
set(ax,'FontSize',16);
set(ax(1:2),'Ylim',[0,14]);
set(ax(4),'ylim',[-2.8019  102.2866]);


put_tag(figh,ax(1),[0.05,0.85],'a',24);
put_tag(figh,ax(2),[0.05,0.85],'b',24);
put_tag(figh,ax(3),[0.05,0.85],'c',24);
put_tag(figh,ax(4),[0.05,0.85],'d',24);
put_tag(figh,ax(3),[0.1,0.6],'Active pool Q_{10}',24);
put_tag(figh,ax(3),[0.6,0.6],'Slow pool Q_{10}',24);
put_tag(figh,ax(4),[0.1,0.6],'Active pool Q_{10}',24);
put_tag(figh,ax(4),[0.6,0.6],'Slow pool Q_{10}',24);

set_curAX(figh,ax(1));title('Topsoil','FontSize',26);
set_curAX(figh,ax(2));title('Subsoil','FontSize',26);
end

function [q10f,q10s,tl,cres1,cres2]=get_sims(top_o100,head)

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
q10f=top_o100.k1w./top_o100.k1c;
q10s=top_o100.k2w./top_o100.k2c;

fprintf('------------------------------------\n');
fprintf('%s\n',head);
fprintf('Active pool: mean=%f,std=%f,max=%f,min=%f\n',mean(q10f),std(q10f),max(q10f),min(q10f));
fprintf('Slow pool: mean=%f,std=%f,max=%f,min=%f\n',mean(q10s),std(q10s),max(q10s),min(q10s));

for jj = 1 : ns
    xj=[top_o100.flab(jj),top_o100.k1c(jj),top_o100.k2c(jj),...
        top_o100.k1w(jj),top_o100.k2w(jj)];
    [cumresp1,cumresp2]=twopool_modelwoc_f2(xj,Extra);
    cres11(jj,:)=cumresp1.*100;
    cres22(jj,:)=cumresp2.*100;    
end

cres1=prctile(cres11,(0.1:2:99.9),1);
cres2=prctile(cres22,(0.1:2:99.9),1);
tl=Extra.tl;
end