close all;
clear all;

% Determine where your m-file's folder is.
anchorfilename='/Users/jinyuntang/work/github/one_bug_model/license.txt';
folder = fileparts(anchorfilename); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));
ModelPar.npp=200;%gC/year
ModelPar.years=50;
ModelPar.Tfrz=275;

ModelPar.name='top';
Ms=[575,600,900,3000];

ModelPar.Ms=Ms(1); ModelPar.Tref=290; ModelPar.Ems=10e3;
ModelPar.Esc=55d3; ModelPar.opt=1; ModelPar.Yld_x=0.27;
one_box_deb_transientT_driver(ModelPar);


ModelPar.Ms=Ms(2); ModelPar.Tref=290; ModelPar.Ems=10e3; 
ModelPar.Esc=55d3; ModelPar.opt=1; ModelPar.Yld_x=0.27;
one_box_deb_transientT_driver(ModelPar);


ModelPar.Ms=Ms(3); ModelPar.Tref=290; ModelPar.Ems=10e3; 
ModelPar.Esc=55d3; ModelPar.opt=1; ModelPar.Yld_x=0.27;
one_box_deb_transientT_driver(ModelPar);


ModelPar.Ms=Ms(4); ModelPar.Tref=290; ModelPar.Ems=10e3; 
ModelPar.Esc=55d3; ModelPar.opt=1; ModelPar.Yld_x=0.27;
one_box_deb_transientT_driver(ModelPar);



gname=run_topincubation(Ms,'xf_middle');

plot_topincubation(gname,Ms);