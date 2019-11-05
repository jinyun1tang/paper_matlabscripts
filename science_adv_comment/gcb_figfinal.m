function gcb_figfinal()

figh=1;
ax=multipanel(figh,2,2,[0.075,0.05],[0.42,0.4],[0.05,0.075]);

%% do topsoil
load('Qin_topsoil.mat');
set_curAX(figh,ax(1));

h10c=errorbar(Qintop10C(:,1),Qintop10C(:,2).*100,Qintop10C(:,3).*100,'r.');
hold on;
h20c=errorbar(Qintop20C(:,1),Qintop20C(:,2).*100,Qintop20C(:,3).*100,'b.');
% q4
load('q00004top_summary_o100.mat');

[q10f_q4,q10s_q4,tl,cres1,cres2]=get_sims(top_o100);

set_curAX(figh,ax(1));
h1=plot(tl,cres1,'r--','LineWidth',2);
plot(tl,cres2,'r--','LineWidth',2);

load('q00010top_summary_o100.mat');

[q10f_q10,q10s_q10,tl,cres1,cres2]=get_sims(top_o100);

h1=plot(tl,cres1,'g--','LineWidth',2);
plot(tl,cres2,'g--','LineWidth',2);

load('q00020top_summary_o100.mat');
[q10f_q20,q10s_q20,tl,cres1,cres2]=get_sims(top_o100);

h1=plot(tl,cres1,'g--','LineWidth',2);
plot(tl,cres2,'g--','LineWidth',2);

load('q00040top_summary_o100.mat');
[q10f_q40,q10s_q40,tl,cres1,cres2]=get_sims(top_o100);

h1=plot(tl,cres1,'g--','LineWidth',2);
plot(tl,cres2,'g--','LineWidth',2);

load('q00050top_summary_o100.mat');
[q10f_q50,q10s_q50,tl,cres1,cres2]=get_sims(top_o100);

h1=plot(tl,cres1,'g--','LineWidth',2);
plot(tl,cres2,'g--','LineWidth',2);

load('q00100top_summary_o100.mat');
[q10f_q100,q10s_q100,tl,cres1,cres2]=get_sims(top_o100);

h1=plot(tl,cres1,'g--','LineWidth',2);
plot(tl,cres2,'g--','LineWidth',2);

%% subsoil
set_curAX(figh,ax(2));
load('Qin_subsoil.mat');
h10c=errorbar(Qinsub10C(:,1),Qinsub10C(:,2).*100,Qinsub10C(:,3).*100,'r.');
hold on;
h20c=errorbar(Qinsub20C(:,1),Qinsub20C(:,2).*100,Qinsub20C(:,3).*100,'b.');

end

function [q10f,q10s,tl,cres1,cres2]=get_sims(top_o100)

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

for jj = 1 : ns
    xj=[top_o100.flab(jj),top_o100.k1c(jj),top_o100.k2c(jj),...
        top_o100.k1w(jj),top_o100.k2w(jj)];
    [cumresp1,cumresp2]=twopool_modelwoc_f2(xj,Extra);
    cres11(jj,:)=cumresp1.*100;
    cres22(jj,:)=cumresp2.*100;    
end

cres1=prctile(cres11,(0.1:0.2:99.9),1);
cres2=prctile(cres22,(0.1:0.2:99.9),1);
tl=Extra.tl;
end