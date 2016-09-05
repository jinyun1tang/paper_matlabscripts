close all;
clear all;
clc;

mother_dir='/Volumes/data/1850-2000';

child_dirs={'betr_clm_derive',...    %CLM,  MNL
'betr_cent_derive',...               %CENT, NUL
'betr_clm3_derive',...               %CLM3, PNL
'betr_clm3_cent_derive',...          %CLM3C,PNLIC
'betr_clmo_derive',...               %CMLO, PNLO
'default_derive'};

stem='carbon_flux.1850-2000.nc';


var_nep='NEP';
var_hr='HR';
var_npp='NPP';


area=netcdf('area_2000.nc','var','area');


area_sum_m2=get_area_sum(area);


tdays=get_tdays(1850, 2000);

tsecs=tdays.*86400;

g2Pg=1d-15;
j=1;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);


data=netcdf(ncf,'var',var_nep);nep_glb_ts_mnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_npp);npp_glb_ts_mnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_hr);hr_glb_ts_mnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;



j=2;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

data=netcdf(ncf,'var',var_nep);nep_glb_ts_nul=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_npp);npp_glb_ts_nul=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_hr);hr_glb_ts_nul=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;



j=3;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);


data=netcdf(ncf,'var',var_nep);nep_glb_ts_pnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_npp);npp_glb_ts_pnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_hr);hr_glb_ts_pnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;


j=4;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);


data=netcdf(ncf,'var',var_nep);nep_glb_ts_pnlic=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_npp);npp_glb_ts_pnlic=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_hr);hr_glb_ts_pnlic=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;


j=5;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

data=netcdf(ncf,'var',var_nep);nep_glb_ts_pnlo=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_npp);npp_glb_ts_pnlo=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_hr);hr_glb_ts_pnlo=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;



j=6;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);


data=netcdf(ncf,'var',var_nep);nep_glb_ts_def=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_npp);npp_glb_ts_def=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_hr);hr_glb_ts_def=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;



purple=[0.5 0 0.5];
subplot(3,2,1);
plot(cumsum(nep_glb_ts_mnl));
hold on;
plot(cumsum(nep_glb_ts_nul),'g');
plot(cumsum(nep_glb_ts_pnl),'r');
plot(cumsum(nep_glb_ts_pnlic),'c');
plot(cumsum(nep_glb_ts_pnlo),'k');
plot(cumsum(nep_glb_ts_def),'color',purple);
title('NEP');
subplot(3,2,2);
plot(cumsum(npp_glb_ts_mnl));
hold on;
plot(cumsum(npp_glb_ts_nul),'g');
plot(cumsum(npp_glb_ts_pnl),'r');
plot(cumsum(npp_glb_ts_pnlic),'c');
plot(cumsum(npp_glb_ts_pnlo),'k');
plot(cumsum(npp_glb_ts_def),'color',purple);
title('NPP');

subplot(3,2,3);
plot(cumsum(hr_glb_ts_mnl));
hold on;
plot(cumsum(hr_glb_ts_nul),'g');
plot(cumsum(hr_glb_ts_pnl),'r');
plot(cumsum(hr_glb_ts_pnlic),'c');
plot(cumsum(hr_glb_ts_pnlo),'k');
plot(cumsum(hr_glb_ts_def),'color',purple);
title('HR');







