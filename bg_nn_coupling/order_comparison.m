close all;
clear all;
clc;
addpath(genpath('~/work/github_rep/matlab_tools/'));

mother_dir='/Users/jinyuntang/work/data_collection/clm_output/bg_nn_coupling';
sub_dirs={...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3adt.2016-04-30',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3adt_tr.2016-05-01'};

    
cc={'b','g','k','m'};
doload=1;
if(doload)
    load('ordercmp.mat');
else
    year=[1850,2000];
j=1;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[ndep11,nfix11,f_nit_n2o11,f_den11,fno3_hydro11_leach,fno3_hydro11_srun,nfire11,nprod11,f_nit11]=getNbudget(indir,stem,year);

fno3_hydro11=fno3_hydro11_leach+fno3_hydro11_srun;

j=2;    
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[ndep21,nfix21,f_nit_n2o21,f_den21,fno3_hydro21_leach,fno3_hydro21_srun,nfire21,nprod21,f_nit21]=getNbudget(indir,stem,year);
fno3_hydro21=fno3_hydro21_leach+fno3_hydro21_srun;


save('ordercmp.mat','ndep11','nfix11','f_nit_n2o11','f_den11','fno3_hydro11','nfire11','nprod11','fno3_hydro11_leach','fno3_hydro11_srun','f_nit11',...
'ndep21','nfix21','f_nit_n2o21','f_den21','fno3_hydro21','nfire21','nprod21','fno3_hydro21_leach','fno3_hydro21_srun','f_nit21');
end
tyear=3600*24*365;
fig=figure;
set(fig,'unit','normalized','position',[.1,.1,.8,.92]);
ax = multipanel(fig,4,4,[.075,.05],[.18,.185],[.05,.065]);
for jj = 1 : 4
    set(fig,'CurrentAxes',ax(jj));    
    hh(1)=plot((1850:2000),f_nit11(:,jj).*tyear,cc{1},'LineWidth',1.5);      
    hold on;
    hh(2)=plot((1850:2000),f_nit21(:,jj).*tyear,cc{2},'LineWidth',1.5);      


    set(fig,'CurrentAxes',ax(jj+4));
    plot((1850:2000),f_nit_n2o11(:,jj).*tyear,cc{1},'LineWidth',1.5);      
    hold on;
    plot((1850:2000),f_nit_n2o21(:,jj).*tyear,cc{2},'LineWidth',1.5);      

    
    set(fig,'CurrentAxes',ax(jj+8));      
    plot((1850:2000),(f_den11(:,jj)+f_nit_n2o11(:,jj)).*tyear,cc{1},'LineWidth',1.5);    
    hold on;
    plot((1850:2000),(f_den21(:,jj)+f_nit_n2o21(:,jj)).*tyear,cc{2},'LineWidth',1.5);    
   

    id=find(fno3_hydro11(:,jj)<0);
    if(~isempty(id))
        fno3_hydro11(id,jj)=0.;        
    end;
    id=find(fno3_hydro21(:,jj)<0);
    if(~isempty(id))
        fno3_hydro21(id,jj)=0.;
    end
    set(fig,'CurrentAxes',ax(jj+12));       
    plot((1850:2000),fno3_hydro11(:,jj).*tyear,cc{1},'LineWidth',1.5);      
    hold on;
    plot((1850:2000),fno3_hydro21(:,jj).*tyear,cc{2},'LineWidth',1.5);      
     
              
end
set(ax,'FontSize',14);
set(ax(1:12),'XTickLabel','');
set(fig,'CurrentAxes',ax(1));
ylabel('Nitrification (gN m^-^2yr^-^1)'); 
set(fig,'CurrentAxes',ax(5));
ylabel('Aerobic N_2O (gN m^-^2yr^-^1)'); 
set(fig,'CurrentAxes',ax(9));
ylabel('Denitrification (gN m^-^2yr^-^1)'); 
set(fig,'CurrentAxes',ax(13));
ylabel('Hydro loss (gN m^-^2yr^-^1)'); 
set(fig,'Color','w');
for jj = 13:16
    set(fig,'CurrentAxes',ax(jj));
    xlabel('Year');
end
sites={'(a1)','(b1)','(c1)','(d1)',...
    '(a2)','(b2)','(c2)','(d2)',...
    '(a3)','(b3)','(c3)','(d3)',...
    '(a4)','(b4)','(c4)','(d4)'};
for jj = 1 : 16
    put_tag(fig,ax(jj),[.025,.93],sites{jj},14);
end

legend(hh,'PNL-adapt','PNL-adapt-tr');