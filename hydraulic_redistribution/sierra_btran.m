close all;
clear all;
clc;
varname='BTRAN';
btran_depz39=netcdf('/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd_depz_3.9/BTRAN_hddepz.nc','var',varname);
btran_15=netcdf('/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd_btran1.5/btran_1.5.nc','var',varname);
btranwc=netcdf('/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd_wc0.5/btran_wc0.5.nc','var',varname);

plot(btran_depz39,'b-d');
hold on;
plot(btran_15,'r-o');
plot(btranwc,'k-d');
xlim([1,12]);
