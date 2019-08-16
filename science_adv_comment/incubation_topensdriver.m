anchorfilename='/Users/jinyuntang/work/github/one_bug_model/license.txt';
folder = fileparts(anchorfilename); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));
Ms=575;

gname=ensrun_incubationtop(Ms);

incubator_middle=plot_topensincubation(gname,Ms);

figure;
semilogy(incubator_middle.cumresp_T10C./incubator_middle.Ctot,'b');
hold on;
semilogy(incubator_middle.cumresp_T20C./incubator_middle.Ctot,'r');