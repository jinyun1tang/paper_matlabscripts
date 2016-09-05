close all;
clear all;
clc;

do_rcp=1;
loadit=1;
if(do_rcp)
    mother_dir='/Volumes/OS/Users/JinyunTang/data_mirror/RCP45';
    child_dirs={'betr_clm_derive',...    %CLM,  MNL
    'betr_cent_derive',...               %CENT, NUL
    'betr_clm3_derive',...               %CLM3, PNL
    'betr_clm3_cent_derive',...          %CLM3C,PNLIC
    'betr_clmo_derive'};               %CMLO, PNLO};
    stem='carbon_flux.RCP45.2001-2300.nc';
    tdays=get_tdays(2001, 2300);    
else    
    mother_dir='/Volumes/data/1850-2000';
    child_dirs={'betr_clm_derive',...    %CLM,  MNL
    'betr_cent_derive',...               %CENT, NUL
    'betr_clm3_derive',...               %CLM3, PNL
    'betr_clm3_cent_derive',...          %CLM3C,PNLIC
    'betr_clmo_derive',...               %CMLO, PNLO
    'default_derive'};
    stem='carbon_flux.1850-2000.nc';
    tdays=get_tdays(1850, 2000);
end

var_nee='NEE';
var_nep='NEP';

var_fire_closs='COL_FIRE_CLOSS';
var_dwt_closs='DWT_CLOSS';
var_prod_closs='PRODUCT_CLOSS';

area=netcdf('area_2000.nc','var','area');


area_sum_m2=get_area_sum(area);


tsecs=tdays.*86400;

g2Pg=1d-15;

if(loadit)
    if(do_rcp)
        load('rcp45.2001-2300.mat');
    else
        load('hist.1850-2000.mat');
    end

else
j=1;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

data=netcdf(ncf,'var',var_nee);nee_glb_ts_mnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_nep);nep_glb_ts_mnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_fire_closs);cfire_glb_ts_mnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_dwt_closs);cdwt_glb_ts_mnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_prod_closs);cprod_glb_ts_mnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

j=2;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

data=netcdf(ncf,'var',var_nee);nee_glb_ts_nul=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_nep);nep_glb_ts_nul=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_fire_closs);cfire_glb_ts_nul=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_dwt_closs);cdwt_glb_ts_nul=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_prod_closs);cprod_glb_ts_nul=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

j=3;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

data=netcdf(ncf,'var',var_nee);nee_glb_ts_pnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_nep);nep_glb_ts_pnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_fire_closs);cfire_glb_ts_pnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_dwt_closs);cdwt_glb_ts_pnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_prod_closs);cprod_glb_ts_pnl=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

j=4;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

data=netcdf(ncf,'var',var_nee);nee_glb_ts_pnlic=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_nep);nep_glb_ts_pnlic=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_fire_closs);cfire_glb_ts_pnlic=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_dwt_closs);cdwt_glb_ts_pnlic=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_prod_closs);cprod_glb_ts_pnlic=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

j=5;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

data=netcdf(ncf,'var',var_nee);nee_glb_ts_pnlo=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_nep);nep_glb_ts_pnlo=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_fire_closs);cfire_glb_ts_pnlo=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_dwt_closs);cdwt_glb_ts_pnlo=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_prod_closs);cprod_glb_ts_pnlo=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

if(~do_rcp)
j=6;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

data=netcdf(ncf,'var',var_nee);nee_glb_ts_def=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_nep);nep_glb_ts_def=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_fire_closs);cfire_glb_ts_def=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_dwt_closs);cdwt_glb_ts_def=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_prod_closs);cprod_glb_ts_def=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;
end
end
purple=[0.5 0 0.5];
subplot(3,2,1);
plot(cumsum(nee_glb_ts_mnl));
hold on;
plot(cumsum(nee_glb_ts_nul),'g');
plot(cumsum(nee_glb_ts_pnl),'r');
plot(cumsum(nee_glb_ts_pnlic),'c');
plot(cumsum(nee_glb_ts_pnlo),'k');
if(~do_rcp)
    plot(cumsum(nee_glb_ts_def),'color',purple);
end
title('NEE');
subplot(3,2,2);
plot(cumsum(nep_glb_ts_mnl));
hold on;
plot(cumsum(nep_glb_ts_nul),'g');
plot(cumsum(nep_glb_ts_pnl),'r');
plot(cumsum(nep_glb_ts_pnlic),'c');
plot(cumsum(nep_glb_ts_pnlo),'k');
if(~do_rcp)
plot(cumsum(nep_glb_ts_def),'color',purple);
end
title('NEP');

subplot(3,2,3);
plot(cumsum(cfire_glb_ts_mnl));
hold on;
plot(cumsum(cfire_glb_ts_nul),'g');
plot(cumsum(cfire_glb_ts_pnl),'r');
plot(cumsum(cfire_glb_ts_pnlic),'c');
plot(cumsum(cfire_glb_ts_pnlo),'k');
if(~do_rcp)
plot(cumsum(cfire_glb_ts_def),'color',purple);
end
title('Fire C loss');

subplot(3,2,4);
plot(cumsum(cdwt_glb_ts_mnl));
hold on;
plot(cumsum(cdwt_glb_ts_nul),'g');
plot(cumsum(cdwt_glb_ts_pnl),'r');
plot(cumsum(cdwt_glb_ts_pnlic),'c');
plot(cumsum(cdwt_glb_ts_pnlo),'k');
if(~do_rcp)
plot(cumsum(cdwt_glb_ts_def),'color',purple);
end
title('DWT C loss');


subplot(3,2,5);
plot(cumsum(cprod_glb_ts_mnl));
hold on;
plot(cumsum(cprod_glb_ts_nul),'g');
plot(cumsum(cprod_glb_ts_pnl),'r');
plot(cumsum(cprod_glb_ts_pnlic),'c');
plot(cumsum(cprod_glb_ts_pnlo),'k');
if(~do_rcp)
plot(cumsum(cprod_glb_ts_def),'color',purple);
end
title('PROD C loss');


if(do_rcp)
    save('rcp45.2001-2300.mat',...
        'nee_glb_ts_mnl','nee_glb_ts_nul','nee_glb_ts_pnl','nee_glb_ts_pnlic','nee_glb_ts_pnlo',...
        'nep_glb_ts_mnl','nep_glb_ts_nul','nep_glb_ts_pnl','nep_glb_ts_pnlic','nep_glb_ts_pnlo',...
        'cfire_glb_ts_mnl','cfire_glb_ts_nul','cfire_glb_ts_pnl','cfire_glb_ts_pnlic','cfire_glb_ts_pnlo',...
        'cdwt_glb_ts_mnl','cdwt_glb_ts_nul','cdwt_glb_ts_pnl','cdwt_glb_ts_pnlic','cdwt_glb_ts_pnlo',...
        'cprod_glb_ts_mnl','cprod_glb_ts_nul','cprod_glb_ts_pnl','cprod_glb_ts_pnlic','cprod_glb_ts_pnlo')  
else
       
    save('hist.1850-2000.mat',...
        'nee_glb_ts_mnl','nee_glb_ts_nul','nee_glb_ts_pnl','nee_glb_ts_pnlic','nee_glb_ts_pnlo','nee_glb_ts_def',...
        'nep_glb_ts_mnl','nep_glb_ts_nul','nep_glb_ts_pnl','nep_glb_ts_pnlic','nep_glb_ts_pnlo','nep_glb_ts_def',...
        'cfire_glb_ts_mnl','cfire_glb_ts_nul','cfire_glb_ts_pnl','cfire_glb_ts_pnlic','cfire_glb_ts_pnlo','cfire_glb_ts_def',...
        'cdwt_glb_ts_mnl','cdwt_glb_ts_nul','cdwt_glb_ts_pnl','cdwt_glb_ts_pnlic','cdwt_glb_ts_pnlo','cdwt_glb_ts_def',...
        'cprod_glb_ts_mnl','cprod_glb_ts_nul','cprod_glb_ts_pnl','cprod_glb_ts_pnlic','cprod_glb_ts_pnlo','cprod_glb_ts_def')    
end


