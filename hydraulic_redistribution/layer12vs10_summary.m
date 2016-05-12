close all;
clear all;
clc;

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra';
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos';

sdir={'sierra_clmdef_depl12rh','sierra_maxlai_hd','sierra_clmdef'};%,'sierra_clmdef_deprt2_nohd','sierra_clmdef_depl12rh','sierra_clmdef_depl12'};

sdir={'tapajos_clmdef','tapajos_lai_hd','tapajos_maxlai_deeprz',...
'tapajos_maxlai_hd','tapajos_maxlai_hd_deeprz','tapajos_seq_maxlai'};
colr={'x','r','b','k','cd','-.'};
subplot(3,1,1);
for jj = 1 : length(sdir)
    ncf=[mdir,'/',sdir{jj},'/',sdir{jj},'.clm2.h0.51-60.nc'];
    et_soil=netcdf(ncf,'var','QSOIL');
    et_vege=netcdf(ncf,'var','QVEGE');
    et_vegt=netcdf(ncf,'var','QVEGT');
    et=et_soil+et_vege+et_vegt;
    time=netcdf(ncf,'var','time');
    
    et_mon=clmts_day2mon(et);
    plot(mean(et_mon,2).*86400,colr{jj});hold on;
    
end

subplot(3,1,2);
for jj = 1 : length(sdir)
    ncf=[mdir,'/',sdir{jj},'/',sdir{jj},'.clm2.h0.51-60.nc'];
    vsoim=netcdf(ncf,'var','H2OSOI');

    time=netcdf(ncf,'var','time');
    plot(time,vsoim(5,:),colr{jj});hold on;
end


subplot(3,1,3);
for jj = 1 : length(sdir)
    ncf=[mdir,'/',sdir{jj},'/',sdir{jj},'.clm2.h0.51-60.nc'];
    zwt=netcdf(ncf,'var','ZWT');

    time=netcdf(ncf,'var','time');
    plot(time,zwt,colr{jj});hold on;

end