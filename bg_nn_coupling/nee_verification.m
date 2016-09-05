close all;
clear all;
clc;

%alm calculates nee as following

%this%nee_col(c) =                &
%    -this%nep_col(c)           + &
%     this%fire_closs_col(c)    + &
%     this%dwt_closs_col(c)     + &
%     this%product_closs_col(c) + &
%     this%hrv_xsmrpool_to_atm_col(c)

%nep is calculated as
%this%nep_col(c) = &
%     this%gpp_col(c) - &
%     this%er_col(c)

%nbp is calculated as
%this%nbp_col(c) =             &
%     this%nep_col(c)        - &
%     this%fire_closs_col(c) - &
%     this%dwt_closs_col(c)  - &
%     this%product_closs_col(c)


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



var_nee='NEE';
var_nep='NEP';
var_fire_closs='COL_FIRE_CLOSS';
var_dwt_closs='DWT_CLOSS';
var_prod_closs='PRODUCT_CLOSS';

year=[1850,2000];

j=1;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    

nee_hist=get_var_nfiles(indir,stem,year,var_nee);
nep_hist=get_var_nfiles(indir,stem,year,var_nep);
cfire_hist=get_var_nfiles(indir,stem,year,var_fire_closs);
cdwtl_hist=get_var_nfiles(indir,stem,year,var_dwt_closs);
cprodl_hist=get_var_nfiles(indir,stem,year,var_prod_closs);
chrvl_hist=nee_hist+nep_hist-cfire_hist-cdwtl_hist-cprodl_hist;


year=[2001,2300];
j=3;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
nee_fut=get_var_nfiles(indir,stem,year,var_nee);
nep_fut=get_var_nfiles(indir,stem,year,var_nep);
cfire_fut=get_var_nfiles(indir,stem,year,var_fire_closs);
cdwtl_fut=get_var_nfiles(indir,stem,year,var_dwt_closs);
cprodl_fut=get_var_nfiles(indir,stem,year,var_prod_closs);
chrvl_fut=nee_fut+nep_fut-cfire_fut-cdwtl_fut-cprodl_fut;



