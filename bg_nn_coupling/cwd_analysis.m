close all;
clear all;
clc;

addpath(genpath('~/work/github_rep/matlab_tools/'));

mother_dir='/Users/jinyuntang/work/data_collection/clm_output/bg_nn_coupling';
sub_dirs={...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3adt.2016-04-30',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3.2016-04-30',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3_cent.2016-05-03',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3_clm.2016-05-03',...   
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3adt.2016-05-09',...
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3.2016-05-09',...
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3_cent.2016-05-10',...
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3_clm.2016-05-10'};




var='CWDC';

year=[1850,2000];

j=1;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    

dat1=get_var_nfiles(indir,stem,year,var);

j=2;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    

dat2=get_var_nfiles(indir,stem,year,var);


j=3;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    

dat3=get_var_nfiles(indir,stem,year,var);


j=4;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    

dat4=get_var_nfiles(indir,stem,year,var);
year=[2001,2300];
j=5;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    

dat5=get_var_nfiles(indir,stem,year,var);

j=6;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    

dat6=get_var_nfiles(indir,stem,year,var);


j=7;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    

dat7=get_var_nfiles(indir,stem,year,var);

j=8;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    

dat8=get_var_nfiles(indir,stem,year,var);

