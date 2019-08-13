function gname=run_incubation(Ms,xloc)
author_print();


gname='Tref290_Ems25000_Esc25000_Yld0.38';

ofile1=sprintf('one_bug_model/mat_files/transtTone_box_deb_trantT_Ms%s_%s_opt1.mat',num2str(Ms(1)),gname);

load(ofile1);
eval(['xf=',xloc,';']);
ModelPar.xf=xf;
Incubator.days=330;
%incubate at 15 C
Incubator.T=10+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

%incubate at 25
Incubator.T=20+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

%do second incubation with different soil mineral protection capacity
ofile2=['one_bug_model/mat_files/transtTone_box_deb_trantT_Ms',num2str(Ms(2)),'_',gname,'_opt1.mat'];

load(ofile2);
eval(['xf=',xloc,';']);
ModelPar.xf=xf;
%incubate at 15 C
Incubator.T=10+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

%incubate at 25
Incubator.T=20+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);


%do second incubation with different soil mineral protection capacity
ofile3=['one_bug_model/mat_files/transtTone_box_deb_trantT_Ms',num2str(Ms(3)),'_',gname,'_opt1.mat'];

load(ofile3);
eval(['xf=',xloc,';']);
ModelPar.xf=xf;
%incubate at 15 C
Incubator.T=10+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

%incubate at 25
Incubator.T=20+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);


%do second incubation with different soil mineral protection capacity
ofile4=['one_bug_model/mat_files/transtTone_box_deb_trantT_Ms',num2str(Ms(4)),'_',gname,'_opt1.mat'];

load(ofile4);
eval(['xf=',xloc,';']);
ModelPar.xf=xf;
%incubate at 15 C
Incubator.T=10+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

%incubate at 25
Incubator.T=20+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

end
