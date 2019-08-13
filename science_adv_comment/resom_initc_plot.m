%
%plot the output from resom simulations used to generate initial conditions 
%for numerical incubation
%jinyuntang@lbl.gov
 
close all;
clear all;
clc;
author_print();
ofile1='one_bug_model/mat_files/transtTone_box_deb_trantT_Ms500_Tref290_Ems5000_Esc25000_Yld0.45_opt1.mat';
ofile2='one_bug_model/mat_files/transtTone_box_deb_trantT_Ms1000_Tref290_Ems5000_Esc25000_Yld0.45_opt1.mat';
ofile3='one_bug_model/mat_files/transtTone_box_deb_trantT_Ms1500_Tref290_Ems5000_Esc25000_Yld0.45_opt1.mat';
ofile4='one_bug_model/mat_files/transtTone_box_deb_trantT_Ms2000_Tref290_Ems5000_Esc25000_Yld0.45_opt1.mat';

load(ofile1);
fig=1;
ax=multipanel(fig,2,2,[0.05,0.05],[0.4,0.4],[0.05,0.05]);
set_curAX(fig,ax(1));
plot(TOUT_ctl,YOUT_ctl(:,vid.som));
title('Som','FontSize',14);
set_curAX(fig,ax(2));
plot(TOUT_ctl,YOUT_ctl(:,vid.doc));
title('Doc','FontSize',14);
set_curAX(fig,ax(3));
plot(TOUT_ctl,sum(YOUT_ctl(:,vid.micc:vid.micb),2));
title('Micb','FontSize',14);
set_curAX(fig,ax(4));
plot(TOUT_ctl,sum(YOUT_ctl(:,vid.ee),2));
title('ExoE','FontSize',14);
title('MS1000','FontSize',14);

load(ofile2);
fig=2;
ax=multipanel(fig,2,2,[0.05,0.05],[0.4,0.4],[0.05,0.05]);
set_curAX(fig,ax(1));
plot(TOUT_ctl,YOUT_ctl(:,vid.som));
title('Som','FontSize',14);
set_curAX(fig,ax(2));
plot(TOUT_ctl,YOUT_ctl(:,vid.doc));
title('Doc','FontSize',14);
set_curAX(fig,ax(3));
title('MS500','FontSize',14);
plot(TOUT_ctl,sum(YOUT_ctl(:,vid.micc:vid.micb),2));
title('Micb','FontSize',14);
set_curAX(fig,ax(4));
plot(TOUT_ctl,sum(YOUT_ctl(:,vid.ee),2));
title('ExoE','FontSize',14);

load(ofile3);
fig=3;
ax=multipanel(fig,2,2,[0.05,0.05],[0.4,0.4],[0.05,0.05]);
set_curAX(fig,ax(1));
plot(TOUT_ctl,YOUT_ctl(:,vid.som));
title('Som','FontSize',14);
set_curAX(fig,ax(2));
plot(TOUT_ctl,YOUT_ctl(:,vid.doc));
title('Doc','FontSize',14);
set_curAX(fig,ax(3));
title('MS500','FontSize',14);
plot(TOUT_ctl,sum(YOUT_ctl(:,vid.micc:vid.micb),2));
title('Micb','FontSize',14);
set_curAX(fig,ax(4));
plot(TOUT_ctl,sum(YOUT_ctl(:,vid.ee),2));
title('ExoE','FontSize',14);

load(ofile4);
fig=4;
ax=multipanel(fig,2,2,[0.05,0.05],[0.4,0.4],[0.05,0.05]);
set_curAX(fig,ax(1));
plot(TOUT_ctl,YOUT_ctl(:,vid.som));
title('Som','FontSize',14);
set_curAX(fig,ax(2));
plot(TOUT_ctl,YOUT_ctl(:,vid.doc));
title('Doc','FontSize',14);
set_curAX(fig,ax(3));
title('MS500','FontSize',14);
plot(TOUT_ctl,sum(YOUT_ctl(:,vid.micc:vid.micb),2));
title('Micb','FontSize',14);
set_curAX(fig,ax(4));
plot(TOUT_ctl,sum(YOUT_ctl(:,vid.ee),2));
title('ExoE','FontSize',14);

