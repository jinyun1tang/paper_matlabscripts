close all;
clear all;
clc;

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';


%reference
chdir='clm45evapcosby4_hdr';

ncf1=[mdir,chdir,'/','EFLX_LH_TOT','.',chdir,'.50-59.nc'];

eflx=netcdf(ncf1,'var','EFLX_LH_TOT');
id=find(abs(eflx)>1d10);
eflx(id)=0./0.;


eflx_ave=mean(eflx,3);
[c,h]=contourf(eflx_ave');set(h,'color','none');colorbar;




ncf='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch_bare_soi.nc';

qsoil=netcdf(ncf,'var','QSOIL');
qvege=netcdf(ncf,'var','QVEGE');
qvegt=netcdf(ncf,'var','QVEGT');
id1=find(abs(qsoil)>1d10);
qsoil(id1)=0./0.;
qet=(qsoil+qvege+qvegt).*86400;
qet_ave=mean(qet,3);

figure;
[c,h]=contourf(qet_ave');set(h,'color','none');colorbar;
title('10-year mean ET from CLM4 (mm H_2O day^-^1)','FontSize',14);