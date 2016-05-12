close all;
clear all;
clc;
%sierra    
lonp=240;

latp=38.84211;
    
    lonp=305;
    latp=-2.356021;
    
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';    

ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

chdir='clm45evaphdr_seq_maxlai';

varname='QSOIL';
ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
QSOIL=get_clm_sitedat(ncf1,iloc,jloc,varname);

varname='QVEGE';
ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
QVEGE=get_clm_sitedat(ncf1,iloc,jloc,varname);

varname='QVEGT';
ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
QVEGT=get_clm_sitedat(ncf1,iloc,jloc,varname);

