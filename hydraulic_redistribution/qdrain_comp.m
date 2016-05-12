close all;
clear all;



ncf_drain_cru='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/cruclm45def/QDRAI.cruclm45def.51-60.nc';
ncf_drain_qan='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45evapdef/QDRAI.clm45evapdef.51-60.nc';


mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
varname1='QDRAI';

lonp=240;
latp=38.84211;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

prec_ser_qan=(get_clm_sitedat(ncf_drain_qan,iloc,jloc,varname1)).*86400;

prec_ser_cru=(get_clm_sitedat(ncf_drain_cru,iloc,jloc,varname1)).*86400;


%tapajos
lonp=305;
latp=-2.356021;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

prec_tap_qan=(get_clm_sitedat(ncf_drain_qan,iloc,jloc,varname1)).*86400;
prec_tap_cru=(get_clm_sitedat(ncf_drain_cru,iloc,jloc,varname1)).*86400;


subplot(2,1,1);
plot(prec_ser_qan);
hold on;
plot(prec_ser_cru,'r');


subplot(2,1,2);
plot(prec_tap_qan);
hold on;
plot(prec_tap_cru,'r');

