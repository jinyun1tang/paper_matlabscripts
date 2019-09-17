close all;

%topsoil
Ms=575;
incubator=get_incubation(Ms,'upper');

matfldir='./one_bug_model/mat_files/Incubation';

iofile=[matfldir,'/resomsyn_obstop.mat'];

obs.days10C=(2:numel(incubator.cumresp_T10C))-1;
obs.obs10C=incubator.cumresp_T10C(2:end)./incubator.Ctot;
obs.err10C=obs.obs10C.*0.01;

obs.days20C=obs.days10C;
obs.obs20C=incubator.cumresp_T20C(2:end)./incubator.Ctot;
obs.err20C=obs.obs20C.*0.01;
save(iofile,'obs');


%subsoil
Ms=1800;

incubator=get_incubation(Ms,'middle');

obs.days10C=(2:numel(incubator.cumresp_T10C))-1;
obs.obs10C=incubator.cumresp_T10C(2:end)./incubator.Ctot;
obs.err10C=obs.obs10C.*0.01;

obs.days20C=obs.days10C;
obs.obs20C=incubator.cumresp_T20C(2:end)./incubator.Ctot;
obs.err20C=obs.obs20C.*0.01;

iofile=[matfldir,'/resomsyn_obs100.mat'];

save(iofile,'obs');