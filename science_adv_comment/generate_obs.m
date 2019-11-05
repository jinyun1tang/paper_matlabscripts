close all;
load('Qin_topsoil.mat');
load('Qin_subsoil.mat');

errp=1;

errorbar(Qinsub10C(:,1),Qinsub10C(:,2),Qinsub10C(:,3),'LineWidth',2);
hold on;
errorbar(Qinsub20C(:,1),Qinsub20C(:,2),Qinsub20C(:,3),'LineWidth',2);

day10C=Qinsub10C(:,1)-0.5;
ns=10;
obs.days10C=repmat(day10C,ns,1)+rand(numel(day10C)*ns,1)-0.5;

while(1)
    err10C=repmat(Qinsub10C(:,3),ns,1).*randn(numel(day10C)*ns,1).*errp;

    obs.obs10C=interp1(Qinsub10C(:,1),Qinsub10C(:,2),obs.days10C,'linear','extrap')+err10C;
    obs.err10C=abs(err10C);
    if(min(obs.obs10C)>0)
        break;
    end
end
[newv,id]=sort(obs.days10C);
obs.days10C=newv;
obs.err10C=obs.err10C(id);
obs.obs10C=obs.obs10C(id);
plot(obs.days10C,obs.obs10C,'k-.','MarkerSize',8);


ns=9;
day20C=Qinsub20C(:,1)-0.5;
obs.days20C=repmat(day20C,ns,1)+rand(numel(day20C)*ns,1)-0.5;

while(1)
    err20C=repmat(Qinsub20C(:,3),ns,1).*randn(numel(day20C)*ns,1).*errp;

    obs.obs20C=interp1(Qinsub20C(:,1),Qinsub20C(:,2),obs.days20C,'linear','extrap')+err20C;
    
    obs.err20C=abs(err20C);
    if(min(obs.obs20C)>0)
        break;
    end
end
[newv,id]=sort(obs.days20C);
obs.days20C=newv;
obs.err20C=obs.err20C(id);
obs.obs20C=obs.obs20C(id);

plot(obs.days20C,obs.obs20C,'-.','MarkerSize',8);

matfldir='./one_bug_model/mat_files/Incubation';

iofile=[matfldir,'/Incubator_obs100.mat'];

save(iofile,'obs');


errp=0.75;

errorbar(Qinsub10C(:,1),Qinsub10C(:,2),Qinsub10C(:,3),'LineWidth',2);
hold on;
errorbar(Qinsub20C(:,1),Qinsub20C(:,2),Qinsub20C(:,3),'LineWidth',2);

day10C=Qinsub10C(:,1)-0.5;
ns=10;
obs.days10C=repmat(day10C,ns,1)+rand(numel(day10C)*ns,1)-0.5;

while(1)
    err10C=err10C.*errp;

    obs.obs10C=interp1(Qinsub10C(:,1),Qinsub10C(:,2),obs.days10C,'linear','extrap')+err10C;
    obs.err10C=abs(err10C);
    if(min(obs.obs10C)>0)
        break;
    end
end
[newv,id]=sort(obs.days10C);
obs.days10C=newv;
obs.err10C=obs.err10C(id);
obs.obs10C=obs.obs10C(id);
plot(obs.days10C,obs.obs10C,'k-.','MarkerSize',8);


ns=9;
day20C=Qinsub20C(:,1)-0.5;
obs.days20C=repmat(day20C,ns,1)+rand(numel(day20C)*ns,1)-0.5;
while(1)
    err20C=err20C.*errp;

    obs.obs20C=interp1(Qinsub20C(:,1),Qinsub20C(:,2),obs.days20C,'linear','extrap')+err20C;
    obs.err20C=abs(err20C);
    if(min(obs.obs20C)>0)
        break;
    end
end
[newv,id]=sort(obs.days20C);
obs.days20C=newv;
obs.err20C=obs.err20C(id);
obs.obs20C=obs.obs20C(id);

plot(obs.days20C,obs.obs20C,'-.','MarkerSize',8);

matfldir='./one_bug_model/mat_files/Incubation';

iofile=[matfldir,'/Incubator_obs075.mat'];

save(iofile,'obs');

