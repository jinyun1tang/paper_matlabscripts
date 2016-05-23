function [gpp, ar, hr,  cdwt, cfire, cprod,som_hr,lit_hr]=getCbudget(indir,stem,year)
%return the fluxes (annual basis) for carbon budget
%DWT_CLOSS: land use loss
%cfire: COL_FIRE_CLOSS

wt=get_monw();window=12;

var='GPP';
dat1=get_var_nfiles(indir,stem,year,var);
gpp=slidew_mean(dat1,window,wt);clear dat1;

var='AR';
dat1=get_var_nfiles(indir,stem,year,var);
ar=slidew_mean(dat1,window,wt);clear dat1;

var='HR';
dat1=get_var_nfiles(indir,stem,year,var);
hr=slidew_mean(dat1,window,wt);clear dat1;

var='DWT_CLOSS';
dat1=get_var_nfiles(indir,stem,year,var);
cdwt=slidew_mean(dat1,window,wt);clear dat1;

var='COL_FIRE_CLOSS';
dat1=get_var_nfiles(indir,stem,year,var);
cfire=slidew_mean(dat1,window,wt);clear dat1;

var='PRODUCT_CLOSS';
dat1=get_var_nfiles(indir,stem,year,var);
cprod=slidew_mean(dat1,window,wt);clear dat1;

var='SOILC_HR';
dat1=get_var_nfiles(indir,stem,year,var);
som_hr=slidew_mean(dat1,window,wt);clear dat1;

var='LITTERC_HR';
dat1=get_var_nfiles(indir,stem,year,var);
lit_hr=slidew_mean(dat1,window,wt);clear dat1;
end