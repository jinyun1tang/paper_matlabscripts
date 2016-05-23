function [ndep,nfix,f_nit_n2o,f_den,fno3_hydro_leach,fno3_hydro_srun,nfire, nprod, f_nit]=getNbudget(indir,stem,year)
%return the fluxes (annual basis) for nitrogen budget

wt=get_monw();window=12;

var='NDEP_TO_SMINN';
dat1=get_var_nfiles(indir,stem,year,var);
ndep=slidew_mean(dat1,window,wt);clear dat1;

var='NFIX_TO_SMINN';
dat1=get_var_nfiles(indir,stem,year,var);
nfix=slidew_mean(dat1,window,wt);clear dat1;

var='F_N2O_NIT';
dat1=get_var_nfiles(indir,stem,year,var);
f_nit_n2o=slidew_mean(dat1,window,wt);clear dat1;

var='F_DENIT';
dat1=get_var_nfiles(indir,stem,year,var);
f_den=slidew_mean(dat1,window,wt);clear dat1;

var='SMIN_NO3_LEACHED';
dat1=get_var_nfiles(indir,stem,year,var);
fno3_hydro_leach=slidew_mean(dat1,window,wt);clear dat1;

var='SMIN_NO3_RUNOFF';
dat1=get_var_nfiles(indir,stem,year,var);
fno3_hydro_srun=slidew_mean(dat1,window,wt);clear dat1;

var='COL_FIRE_NLOSS';
dat1=get_var_nfiles(indir,stem,year,var);
nfire=slidew_mean(dat1,window,wt);clear dat1;

var='PRODUCT_NLOSS';
dat1=get_var_nfiles(indir,stem,year,var);
nprod=slidew_mean(dat1,window,wt);clear dat1;

var='F_NIT';
dat1=get_var_nfiles(indir,stem,year,var);
f_nit=slidew_mean(dat1,window,wt);clear dat1;

end