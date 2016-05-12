close all;
clear all;
clc;

ncf0='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/I1850-2000bgcvrt60N_control/gpp2000_ctrlvcent.nc';
ncf1='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/I1980-2000petrubvrcent_test/gpp2000.nc';

varname='GPP';
gpp1=netcdf(ncf0,'var',varname);
gpp2=netcdf(ncf1,'var',varname);

