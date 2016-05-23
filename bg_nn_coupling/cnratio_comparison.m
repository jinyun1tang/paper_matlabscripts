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

    
cc={'b','g','k','m'};
doload=0;
if(doload)
    load('cnstates.mat');
else
    year=[1850,2000];
var='WOODC';docum=0;
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

var='WOODN';docum=0;
    year=[1850,2000];
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

n11=[dat1;dat3];clear dat1 dat3;
n22=[dat2;dat4];clear dat2 dat4;

var='WOODC';
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


var='WOODN';docum=0;
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

n33=[dat1;dat3];clear dat1 dat3;
n44=[dat2;dat4];clear dat2 dat4;

wt=get_monw();window=12;
c1=slidew_mean(c11,window,wt);clear c11;
c2=slidew_mean(c22,window,wt);clear c22;
c3=slidew_mean(c33,window,wt);clear c33;
c4=slidew_mean(c44,window,wt);clear c44;

n1=slidew_mean(n11,window,wt);clear n11;
n2=slidew_mean(n22,window,wt);clear n22;
n3=slidew_mean(n33,window,wt);clear n33;
n4=slidew_mean(n44,window,wt);clear n44;

save('cnstate.mat','c1','n1','c2','n2','c3','n3','c4','n4');
end

fig=figure;
set(fig,'unit','normalized','position',[.1,.1,.6,.9]);
ax = multipanel(fig,2,2,[.1,.1],[.4,.4],[.075,.05]);
years=(1850:2300);


for k = 1 : 4
    set(fig,'CurrentAxes',ax(k));

    fh(1)=plot(years,c1(:,k)./n1(:,k),cc{1},'LineWidth',2);hold on;    
    fh(2)=plot(years,c2(:,k)./n2(:,k),cc{2},'LineWidth',2);        
    fh(3)=plot(years,c3(:,k)./n3(:,k),cc{3},'LineWidth',2);        
    fh(4)=plot(years,c4(:,k)./n4(:,k),cc{4},'LineWidth',2);        
 
end


legend(fh,'PNL-adapt','PNL','NUL','MNL');