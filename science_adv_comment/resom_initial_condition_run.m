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
ModelPar.Ms=500; ModelPar.Tref=290; ModelPar.Ems=25e3;
ModelPar.Esc=25d3; ModelPar.opt=1; ModelPar.Yld_x=0.38;
one_box_deb_transientT_driver(ModelPar);


ModelPar.Ms=1250; ModelPar.Tref=290; ModelPar.Ems=25e3; 
ModelPar.Esc=25d3; ModelPar.opt=1; ModelPar.Yld_x=0.38;
one_box_deb_transientT_driver(ModelPar);


ModelPar.Ms=1800; ModelPar.Tref=290; ModelPar.Ems=25e3; 
ModelPar.Esc=25d3; ModelPar.opt=1; ModelPar.Yld_x=0.38;
one_box_deb_transientT_driver(ModelPar);


ModelPar.Ms=3000; ModelPar.Tref=290; ModelPar.Ems=25e3; 
ModelPar.Esc=25d3; ModelPar.opt=1; ModelPar.Yld_x=0.38;
one_box_deb_transientT_driver(ModelPar);