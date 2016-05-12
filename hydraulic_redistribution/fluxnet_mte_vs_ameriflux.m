
close all;
clear all;





%plot_opt='meanval';
load('/Users/jinyuntang/work/data_collection/FLUXNET_MTE/fluxnet_mte.mat');
%time days since 1582-10-14 00:00:00

cday=[diff(fluxnet_mte.time);31];%number of days for each data point

year0=1982;

%use the 10 year mean for comparison
year1=1991;
year2=2000;

id1=(year1-year0)*12+1;
id2=(year2-year0+1)*12;

lonp=305-360;    
latp=-2.356021;      
[iloc_fluxnet_mte,jloc_fluxnet_mte]=find_siteloc(fluxnet_mte.lon,fluxnet_mte.lat,lonp,latp);
lh_dat=squeeze(fluxnet_mte.LH_mean(iloc_fluxnet_mte,jloc_fluxnet_mte,id1:id2)).*1d6./86400;

plot(reshape(lh_dat,[12,numel(lh_dat)/12]));



load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/LBA_Tapajos_KM67_Mature_Forest.mat');
hold on;
plot(lht,'o');


load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/LBA_Tapajos_KM83_Logged_Forest.mat');
hold on;
plot(lht,'ro');
