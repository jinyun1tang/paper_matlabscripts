close all;
clear all;
clc;

       
%tapajos    
lonp=305;    
latp=-2.356021;    
load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/LBA_Tapajos_KM67_Mature_Forest.mat');
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
varname='EFLX_LH_TOT';
fontsz=14;
%amazon somewhere
do_bare=1;
ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.6,.6]);
linewidth=2;
    
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);
w=[31,28,31,30,31,30,31,31,30,31,30,31]./365;
window=12;
mlht=nanmean(lht,2);

ncf='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/tapajos_qian_prec_corrected_nohd/EFLX_LH_TOT.tapajos_qian_prec_corrected_nohd.51-60.nc';

dat=netcdf(ncf,'var',varname);   
nyr=length(dat)/12;
lht_correct_hd_yr=mean(reshape(dat,[12,nyr]),2);

h_plot(1)=plot(lht_correct_hd_yr,'-','LineWidth',linewidth);

   
fprintf('prec_correct_nohd\n');

linearfit(lht_correct_hd_yr,mlht,'disp');  
hold on;

ncf='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/tapajos_qian_prec_corrected_baresoi/EFLX_LH_TOT.tapajos_qian_prec_corrected_baresoi.51-60.nc';
dat=netcdf(ncf,'var',varname);   
nyr=length(dat)/12;
lht_correct_hd_yr=mean(reshape(dat,[12,nyr]),2);

h_plot(2)=plot(lht_correct_hd_yr,'--','LineWidth',linewidth);

   



ncf='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/tapajos_qian_prec_corrected/EFLX_LH_TOT.tapajos_qian_prec_corrected.51-60.nc';

dat=netcdf(ncf,'var',varname);   
nyr=length(dat)/12;
lht_correct_hd_yr=mean(reshape(dat,[12,nyr]),2);

h_plot(3)=plot(lht_correct_hd_yr,'r-','LineWidth',linewidth);
linearfit(lht_correct_hd_yr,mlht,'disp');  
fprintf('prec_correct_hd\n');
   
%plot data

hh=plot(lht,'ko','MarkerFaceColor','k');


h_plot(4)=hh(1);


legend(h_plot,'CLM4.5-prec-Adjust','CLM4.5-BSOI-prec-Adjust','CLM4.5RHR-TCI-Adjust','AmeriFlux','location','southeast');

    
ylabel('Latent heat (W m^-^2)','FontSize',fontsz);
set(gca,'Xlim',[0,13],'Fontsize',fontsz);
xlabel('Month','FontSize',fontsz);
title('Effect of precipitation bias adjustment at Tapajos Forest');

set(fig,'color','white');
    