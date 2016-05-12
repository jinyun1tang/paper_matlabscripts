close all;
clear all;
clc;

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/';

ncfs={'tapajos_clmdef','tapajos_maxlai_hd','tapajos_maxlai_hd_deeprz'};
subplot(2,1,1);
cc={'b-','rx','gd','k-'};
for kk = 1 : length(ncfs)
   
    ncf=[mdir,ncfs{kk},'/',ncfs{kk},'.clm2.h0.0059-01-01-00000.nc'];
    h2osoi=netcdf(ncf,'var','H2OSOI');
    plot(h2osoi(2,:),cc{kk});
    hold on;
end
xlim([0,366]);
ylabel('Moisture','FontSize',14);
set(gca,'FontSize',14);
subplot(2,1,2);


cc={'b-','rx','gd','k-'};
for kk = 1 : length(ncfs)
   
    ncf=[mdir,ncfs{kk},'/',ncfs{kk},'.clm2.h0.0059-01-01-00000.nc'];
    h2osoi=netcdf(ncf,'var','EFLX_LH_TOT');
    plot(h2osoi,cc{kk});
    hold on;
end
xlim([0,366]);
ylabel('Latent Heat(W m^-2)','FontSize',14);
legend('Default','RHD','RHD+DRT');
set(gca,'FontSize',14);