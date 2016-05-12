close all;
clear all;
clc;

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/';

ncfs={'sierra_clmdef','sierra_maxlai_hd','sierra_maxlai_hd_deeprz'};%,'sierra_clmdef_deeproot'};
%mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/';

%ncfs={'tapajos_clmdef','tapajos_maxlai_hd','tapajos_maxlai_hd_deeprz'};
for yr=50:59;
subplot(2,1,1);
cc={'b-','rx','gd','k-'};
for kk = 1 : length(ncfs)
   
    ncf=[mdir,ncfs{kk},'/',ncfs{kk},'.clm2.h0.00',num2str(yr),'-01-01-00000.nc'];
    h2osoi=netcdf(ncf,'var','H2OSOI');
    plot(h2osoi(2,:),cc{kk});
    hold on;
end
xlim([0,366]);
ylabel('Moisture','FontSize',14);
set(gca,'FontSize',14);
clf;

subplot(2,1,1);
cc={'b-','rx','gd','k-'};
for kk = 1 : length(ncfs)
   
    ncf=[mdir,ncfs{kk},'/',ncfs{kk},'.clm2.h0.00',num2str(yr),'-01-01-00000.nc'];
    h2osoi1=netcdf(ncf,'var','QVEGE');
    h2osoi2=netcdf(ncf,'var','QVEGT');
    h2osoi3=netcdf(ncf,'var','QSOIL');
    
    plot((h2osoi1+h2osoi2+h2osoi3).*86400,cc{kk});
    hold on;
end
xlim([0,366]);
ylabel('ET (mm/day)','FontSize',14);
legend('Default','RHD','RHD+DRT');
set(gca,'FontSize',14);
subplot(2,1,2);
daz=[0,31,28,31,30,31,30,31,31,30,31,30,31];
cdaz=cumsum(daz);
cc={'b-','r-x','g-d','k-'};
for kk = 1 : length(ncfs)
   
    ncf=[mdir,ncfs{kk},'/',ncfs{kk},'.clm2.h0.00',num2str(yr),'-01-01-00000.nc'];
    h2osoi1=netcdf(ncf,'var','QVEGE');
    h2osoi2=netcdf(ncf,'var','QVEGT');
    h2osoi3=netcdf(ncf,'var','QSOIL');
    tet=h2osoi1+h2osoi2+h2osoi3;
    for jj = 1 : 12
        et(jj)=mean(tet((cdaz(jj)+1):cdaz(jj+1)));
    end
    plot(et.*86400,cc{kk});
    hold on;
end

ylabel('ET (mm/day)','FontSize',14);
legend('Default','RHD','RHD+DRT');
set(gca,'FontSize',14);
pause;
end
