close all;
clear all;
clc;
do_err=0;

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/';

qvege=netcdf([mdir,'oxisol/QVEGE_fixed_clay.nc'],'var','QVEGE');
qvegt=netcdf([mdir,'oxisol/QVEGT_fixed_clay.nc'],'var','QVEGT');
qsoil=netcdf([mdir,'oxisol/QSOIL_fixed_clay.nc'],'var','QSOIL');


soilw10v=netcdf([mdir,'oxisol/SOILWATER_10CM_fixed_clay.nc'],'var','SOILWATER_10CM');


et_v=ts_day2mon(qvege+qvegt+qsoil).*2.501d6;



qvegeb=netcdf([mdir,'oxisol/QVEGE_fixed_clay_baresoil.nc'],'var','QVEGE');
qvegtb=netcdf([mdir,'oxisol/QVEGT_fixed_clay_baresoil.nc'],'var','QVEGT');
qsoilb=netcdf([mdir,'oxisol/QSOIL_fixed_clay_baresoil.nc'],'var','QSOIL');
soilw10b=netcdf([mdir,'oxisol/SOILWATER_10CM_fixed_clay_baresoil.nc'],'var','SOILWATER_10CM');

et_b=ts_day2mon(qvegeb+qvegtb+qsoilb).*2.501d6;



qvegedf=netcdf([mdir,'tapajos_clmdef/tapajos_clmdef.clm2.h0.51-60.nc'],'var','QVEGE');
qvegtdf=netcdf([mdir,'tapajos_clmdef/tapajos_clmdef.clm2.h0.51-60.nc'],'var','QVEGT');
qsoildf=netcdf([mdir,'tapajos_clmdef/tapajos_clmdef.clm2.h0.51-60.nc'],'var','QSOIL');
et_df=ts_day2mon(qvegedf+qvegtdf+qsoildf).*2.501d6;

soilw10df=netcdf([mdir,'tapajos_clmdef/tapajos_clmdef.clm2.h0.51-60.nc'],'var','SOILWATER_10CM');

varname='EFLX_LH_TOT';



iloc=123;
jloc=47;    
chdir='clm45evapdef_bs';
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];

eflx_def=get_clm_sitedat(ncf1,iloc,jloc,varname);

nyr=length(eflx_def)/12;

eflx_def_yr=mean(reshape(eflx_def,[12,nyr]),2);    
    

load('ET_test2.mat');
et_oxi=squeeze(QSOIL(iloc,jloc,601:720)+QVEGE(iloc,jloc,601:720)+QVEGT(iloc,jloc,601:720)).*2.501d6;
load('ET_test3.mat');
et_oxib=squeeze(QSOIL(iloc,jloc,601:720)+QVEGE(iloc,jloc,601:720)+QVEGT(iloc,jloc,601:720)).*2.501d6;

fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.6,.6]);
%subplot(2,1,1);
if(do_err)
    errorbar((1:12),mean(reshape(et_v,[12,10]),2),std(reshape(et_v,[12,10]),0,2));

    hold on;

    errorbar((1:12),mean(reshape(et_b,[12,10]),2),std(reshape(et_b,[12,10]),0,2),'r');

    errorbar((1:12),mean(reshape(et_oxi,[12,10]),2),std(reshape(et_ox,[12,10]),0,2),'k');

else    
    h_plot(1)=plot((1:12),mean(reshape(et_v,[12,10]),2),'r','LineWidth',2);
    hold on;

    h_plot(2)=plot((1:12),mean(reshape(et_b,[12,10]),2),'r--','LineWidth',2);

    h_plot(3)=plot((1:12),mean(reshape(et_oxi,[12,10]),2),'k','LineWidth',2);    

    h_plot(4)=plot((1:12),mean(reshape(et_oxib,[12,10]),2),'k--','LineWidth',2);    
    
    
    h_plot(5)=plot((1:12),mean(reshape(et_df,[12,10]),2),'b','LineWidth',2);
end

h_plot(6)=plot((1:12),eflx_def_yr,'b--','LineWidth',2);
load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/LBA_Tapajos_KM67_Mature_Forest.mat');
   
boxplot(lht','medianstyle','target');  

h_plot(7) = plot(median_nan(lht,2),'g-o','LineWidth',2); 


xlim([0,13]);
ylim([40,160]);
legend(h_plot,'CLM4.5-OXISOL-70%CLAY','CLM4.5-OXISOL-70%CLAY-BSOI','CLM4.5-OXISOL','CLM4.5-OXISOL-BSOI','CLM4.5','CLM4.5-BSOI','AmeriFlux');
xlabel('Month','FontSize',14);
ylabel('Latent heat (W m^-^2)','FontSize',14);

set(gca,'FontSize',14,'XTick',(1:12));
title('Oxisol effect at Tapajos Forest site','FontSize',14);
set(gcf,'color','w');
return;



