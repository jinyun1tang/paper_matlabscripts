close all;
clear all;
clc;
addpath(genpath('~/work/github_rep/matlab_tools/'));

mother_dir='/Users/jinyuntang/work/data_collection/clm_output/bg_nn_coupling';
sub_dirs={...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3adt.2016-04-30',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3.2016-04-30',...
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3adt.2016-05-09',...
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3.2016-05-09',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3_cent.2016-05-03',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3_clm.2016-05-03',...    
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3_cent.2016-05-10',...
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3_clm.2016-05-10'};

    
cc={'m','r','g','b'};
doload=1;
if(doload)
    load('nitrate.mat');
else
    year=[1850,2000];
var='SMIN_NO3';docum=0;
j=1;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat1=get_var_nfiles(indir,stem,year,var);

j=2;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat2=get_var_nfiles(indir,stem,year,var);

    
year=[2001,2300];

j=3;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat3=get_var_nfiles(indir,stem,year,var);
j=4;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat4=get_var_nfiles(indir,stem,year,var);

c11=[dat1;dat3];clear dat1 dat3;
c22=[dat2;dat4];clear dat2 dat4;



year=[1850,2000];
j=5;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat1=get_var_nfiles(indir,stem,year,var);

j=6;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat2=get_var_nfiles(indir,stem,year,var);

    
year=[2001,2300];

j=7;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat3=get_var_nfiles(indir,stem,year,var);
j=8;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat4=get_var_nfiles(indir,stem,year,var);

c33=[dat1;dat3];clear dat1 dat3;
c44=[dat2;dat4];clear dat2 dat4;



wt=get_monw();window=12;
c1=slidew_mean(c11,window,wt);clear c11;
c2=slidew_mean(c22,window,wt);clear c22;
c3=slidew_mean(c33,window,wt);clear c33;
c4=slidew_mean(c44,window,wt);clear c44;



save('nitrate.mat','c1','c2','c3','c4');
end

fig=figure;
set(fig,'unit','normalized','position',[.1,.1,.6,.9]);
ax = multipanel(fig,2,2,[.1,.1],[.4,.4],[.075,.05]);
years=(1850:2300);


for k = 1 : 4
    set(fig,'CurrentAxes',ax(k));

    fh(1)=plot(years,c1(:,k),cc{1},'LineWidth',2);hold on;    
    fh(2)=plot(years,c2(:,k),cc{2},'LineWidth',2);        
    fh(3)=plot(years,c3(:,k),cc{3},'LineWidth',2);        
    fh(4)=plot(years,c4(:,k),cc{4},'LineWidth',2);        
 
end


txt={'(a)(74.67^\circW,40.6^\circN)','(b)(26.22^\circE,67.7^\circN)',...
    '(c)(50.02^\circW,4.88^\circS)','(d)(51.5^\circW,30.0^\circS)'};
set(ax,'FontSize',14,'Xlim',[1850,2350],'XTick',(1850:100:2350));
set(fig,'Color','w');
for k = 1 : 4        
    set(fig,'CurrentAxes',ax(k));
    xlabel('Year','FontSize',14);
    ylabel('Total soil nitrate (g N m^-^2)','FontSize',14);
    %ylabel('Total vegetation carbon (g C m^-^2)','FontSize',14);
    %ylabel('Total vegetation nitrogen (g N m^-^2)','FontSize',14);    
    put_tag(fig,ax(k),[.05,.95],txt{k},14);
end

legend(fh(4:-1:1),'MNL','NUL','PNL','PNL-adapt');