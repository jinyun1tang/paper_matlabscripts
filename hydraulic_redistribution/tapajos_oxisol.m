close all;
clear all;
clc;
do_err=0;

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/';

qvege=netcdf([mdir,'oxisol/QVEGE_fixed_clay.nc'],'var','QVEGE');
qvegt=netcdf([mdir,'oxisol/QVEGT_fixed_clay.nc'],'var','QVEGT');
qsoil=netcdf([mdir,'oxisol/QSOIL_fixed_clay.nc'],'var','QSOIL');


soilw10v=netcdf([mdir,'oxisol/SOILWATER_10CM_fixed_clay.nc'],'var','SOILWATER_10CM');


et_v=qvege+qvegt+qsoil;



qvegeb=netcdf([mdir,'oxisol/QVEGE_fixed_clay_baresoil.nc'],'var','QVEGE');
qvegtb=netcdf([mdir,'oxisol/QVEGT_fixed_clay_baresoil.nc'],'var','QVEGT');
qsoilb=netcdf([mdir,'oxisol/QSOIL_fixed_clay_baresoil.nc'],'var','QSOIL');
soilw10b=netcdf([mdir,'oxisol/SOILWATER_10CM_fixed_clay_baresoil.nc'],'var','SOILWATER_10CM');

et_b=qvegeb+qvegtb+qsoilb;



qvegedf=netcdf([mdir,'tapajos_clmdef/tapajos_clmdef.clm2.h0.51-60.nc'],'var','QVEGE');
qvegtdf=netcdf([mdir,'tapajos_clmdef/tapajos_clmdef.clm2.h0.51-60.nc'],'var','QVEGT');
qsoildf=netcdf([mdir,'tapajos_clmdef/tapajos_clmdef.clm2.h0.51-60.nc'],'var','QSOIL');
et_df=qvegedf+qvegtdf+qsoildf;
soilw10df=netcdf([mdir,'tapajos_clmdef/tapajos_clmdef.clm2.h0.51-60.nc'],'var','SOILWATER_10CM');

subplot(2,1,1);
if(do_err)
    errorbar((1:365),mean(reshape(et_v,[365,10]),2),std(reshape(et_v,[365,10]),0,2));

    hold on;

    errorbar((1:365),mean(reshape(et_b,[365,10]),2),std(reshape(et_b,[365,10]),0,2),'r');

    errorbar((1:365),mean(reshape(et_df,[365,10]),2),std(reshape(et_df,[365,10]),0,2),'k');

else    
    plot((1:365),mean(reshape(et_v,[365,10]),2));
    hold on;

    plot((1:365),mean(reshape(et_b,[365,10]),2),'r');

    plot((1:365),mean(reshape(et_df,[365,10]),2),'k');    
end


xlim([0,366]);


subplot(2,1,2);

errorbar((1:365),mean(reshape(et_v-et_b,[365,10]),2),std(reshape(et_v-et_b,[365,10]),0,2));

xlim([0,366]);


figure;
subplot(1,2,1);
errorbar((1:365),mean(reshape(et_v-et_df,[365,10]),2),std(reshape(et_v-et_df,[365,10]),0,2));
xlim([0,366]);
subplot(1,2,2);
hist((et_v-et_df),100);
figure;

plot(soilw10v);
hold on;
plot(soilw10b,'r.');
plot(soilw10df,'k.');



