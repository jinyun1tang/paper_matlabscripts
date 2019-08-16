function plot_topincubation(gname,Ms)
close all;
author_print();
load('Qin_topsoil.mat');
load('Qin_subsoil.mat');

%%
ofile1=['one_bug_model/mat_files/transtTone_box_deb_IncubT_Ms',num2str(Ms(1)),'_',gname,'_opt1_Tincub283.15_dayincub330.mat'];
load(ofile1);
incubator.cumresp_T10C=interp1(TOUT_ctl,YOUT_ctl(:,vid.co2)-YOUT_ctl(1,vid.co2),(0:Incubator.days));
ofile2=['one_bug_model/mat_files/transtTone_box_deb_IncubT_Ms',num2str(Ms(1)),'_',gname,'_opt1_Tincub293.15_dayincub330.mat'];
load(ofile2);
incubator.cumresp_T20C=interp1(TOUT_ctl,YOUT_ctl(:,vid.co2)-YOUT_ctl(1,vid.co2),(0:Incubator.days));
incubator.Ctot=sum(ModelPar.xf([vid.som,vid.doc,vid.micc,vid.micb,vid.ee]));
incubator.days=Incubator.days;

incubator.name=['Ms',num2str(Ms(1)),'_days',num2str(Incubator.days)];
incubator.dats=Qintop10C(:,1);
fig=1;
ax=multipanel(fig,2,2,[0.1,0.1],[0.4,0.4],[0.05,0.05]);
set_curAX(fig,ax(1));
plot(incubator.cumresp_T10C./incubator.Ctot,'b');
hold on;
plot(incubator.cumresp_T20C./incubator.Ctot,'r');
errorbar(Qintop10C(:,1),Qintop10C(:,2),Qintop10C(:,3),'LineWidth',2);
errorbar(Qintop20C(:,1),Qintop20C(:,2),Qintop20C(:,3),'LineWidth',2);

title(['Ms',num2str(Ms(1)),'-330']);
matfldir='./one_bug_model/mat_files/Incubation';

system(['mkdir -p ', matfldir]);

iofile=[matfldir,'/Incubator_',incubator.name,'.mat'];
save(iofile,'incubator');
%%
clear incubator Incubator YOUT_ctl;

ofile1=['one_bug_model/mat_files/transtTone_box_deb_IncubT_Ms',num2str(Ms(2)),'_',gname,'_opt1_Tincub283.15_dayincub330.mat'];
load(ofile1);
incubator.cumresp_T10C=interp1(TOUT_ctl,YOUT_ctl(:,vid.co2)-YOUT_ctl(1,vid.co2),(0:Incubator.days));
ofile2=['one_bug_model/mat_files/transtTone_box_deb_IncubT_Ms',num2str(Ms(2)),'_',gname,'_opt1_Tincub293.15_dayincub330.mat'];
load(ofile2);
incubator.cumresp_T20C=interp1(TOUT_ctl,YOUT_ctl(:,vid.co2)-YOUT_ctl(1,vid.co2),(0:Incubator.days));
incubator.Ctot=sum(ModelPar.xf([vid.som,vid.doc,vid.micc,vid.micb,vid.ee]));
incubator.days=Incubator.days;
incubator.dats=Qintop10C(:,1);
incubator.name=['Ms',num2str(Ms(2)),'_days',num2str(Incubator.days)];
set_curAX(fig,ax(2));
plot(incubator.cumresp_T10C./incubator.Ctot,'b');
hold on;
plot(incubator.cumresp_T20C./incubator.Ctot,'r');
errorbar(Qintop10C(:,1),Qintop10C(:,2),Qintop10C(:,3),'LineWidth',2);
errorbar(Qintop20C(:,1),Qintop20C(:,2),Qintop20C(:,3),'LineWidth',2);
title(['Ms',num2str(Ms(2)),'-330']);
matfldir='./one_bug_model/mat_files/Incubation';

iofile=[matfldir,'/Incubator_',incubator.name,'.mat'];
save(iofile,'incubator');


%%
ofile1=['one_bug_model/mat_files/transtTone_box_deb_IncubT_Ms',num2str(Ms(3)),'_',gname,'_opt1_Tincub283.15_dayincub330.mat'];
load(ofile1);
incubator.cumresp_T10C=interp1(TOUT_ctl,YOUT_ctl(:,vid.co2)-YOUT_ctl(1,vid.co2),(0:Incubator.days));
ofile2=['one_bug_model/mat_files/transtTone_box_deb_IncubT_Ms',num2str(Ms(3)),'_',gname,'_opt1_Tincub293.15_dayincub330.mat'];
load(ofile2);
incubator.cumresp_T20C=interp1(TOUT_ctl,YOUT_ctl(:,vid.co2)-YOUT_ctl(1,vid.co2),(0:Incubator.days));
incubator.Ctot=sum(ModelPar.xf([vid.som,vid.doc,vid.micc,vid.micb,vid.ee]));
incubator.days=Incubator.days;
incubator.dats=Qintop10C(:,1);
incubator.name=['Ms',num2str(Ms(3)),'_days',num2str(Incubator.days)];
set_curAX(fig,ax(3));
plot(incubator.cumresp_T10C./incubator.Ctot,'b');
hold on;
plot(incubator.cumresp_T20C./incubator.Ctot,'r');
title(['Ms',num2str(Ms(3)),'-330']);
matfldir='./one_bug_model/mat_files/Incubation';
errorbar(Qintop10C(:,1),Qintop10C(:,2),Qintop10C(:,3),'LineWidth',2);
errorbar(Qintop20C(:,1),Qintop20C(:,2),Qintop20C(:,3),'LineWidth',2);
system(['mkdir -p ', matfldir]);

iofile=[matfldir,'/Incubator_',incubator.name,'.mat'];
save(iofile,'incubator');
%%
clear incubator Incubator YOUT_ctl;

%close all;
ofile1=['one_bug_model/mat_files/transtTone_box_deb_IncubT_Ms',num2str(Ms(4)),'_',gname,'_opt1_Tincub283.15_dayincub330.mat'];
load(ofile1);
incubator.cumresp_T10C=interp1(TOUT_ctl,YOUT_ctl(:,vid.co2)-YOUT_ctl(1,vid.co2),(0:Incubator.days));
ofile2=['one_bug_model/mat_files/transtTone_box_deb_IncubT_Ms',num2str(Ms(4)),'_',gname,'_opt1_Tincub293.15_dayincub330.mat'];
load(ofile2);
incubator.cumresp_T20C=interp1(TOUT_ctl,YOUT_ctl(:,vid.co2)-YOUT_ctl(1,vid.co2),(0:Incubator.days));
incubator.Ctot=sum(ModelPar.xf([vid.som,vid.doc,vid.micc,vid.micb,vid.ee]));
incubator.days=Incubator.days;
incubator.dats=Qintop10C(:,1);
incubator.name=['Ms',num2str(Ms(4)),'_days',num2str(Incubator.days)];
set_curAX(fig,ax(4));
plot(incubator.cumresp_T10C./incubator.Ctot,'b');
hold on;
plot(incubator.cumresp_T20C./incubator.Ctot,'r');
title(['Ms',num2str(Ms(4)),'-330']);
matfldir='./one_bug_model/mat_files/Incubation';
errorbar(Qintop10C(:,1),Qintop10C(:,2),Qintop10C(:,3),'LineWidth',2);
errorbar(Qintop20C(:,1),Qintop20C(:,2),Qintop20C(:,3),'LineWidth',2);
system(['mkdir -p ', matfldir]);
iofile=[matfldir,'/Incubator_',incubator.name,'.mat'];
save(iofile,'incubator');
end