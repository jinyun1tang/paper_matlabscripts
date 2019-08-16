function gname=ensrun_incubationtop(Ms)
author_print();


gname='topTref290_Ems10000_Esc55000_Yld0.27';

ofile1=sprintf('one_bug_model/mat_files/transtTone_box_deb_trantT_Ms%s_%s_opt1.mat',num2str(Ms),gname);

load(ofile1);
eval('xf=xf_upper;');
ModelPar.xf=xf;
Incubator.days=330;
Incubator.xfloc='upper';
ModelPar.name='top';
%incubate at 15 C
Incubator.T=10+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

%incubate at 25
Incubator.T=20+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

eval('xf=xf_middle;');
ModelPar.xf=xf;
Incubator.days=330;
%incubate at 15 C
Incubator.xfloc='middle';

Incubator.T=10+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

%incubate at 25
Incubator.T=20+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

eval('xf=xf_down;');
ModelPar.xf=xf;
Incubator.days=330;
Incubator.xfloc='down';
%incubate at 15 C
Incubator.T=10+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

%incubate at 25
Incubator.T=20+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

eval('xf=xf_last;');
ModelPar.xf=xf;
Incubator.days=330;
Incubator.xfloc='last';
%incubate at 15 C
Incubator.T=10+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

%incubate at 25
Incubator.T=20+273.15;
one_box_deb_constT_incubator_driver(ModelPar, Incubator);

end
