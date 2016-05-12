close all;
clear all;
clc;
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
varname='TLAI';
fontsz=14;
%amazon somewhere
lonp=297.5;
latp=-2.842105;
cc={'b','k'};
sites={'sierra','tapajos'};
for j = 1 : length(sites)
    site=sites{j};
if(strcmp(site,'sierra'))
    lonp=240;
    latp=38.84211;
    load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/Blodgett_Forest.mat');
elseif(strcmp(site,'tapajos'))
%tapajos
    lonp=305;
    latp=-2.356021;
    load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/LBA_Tapajos_KM67_Mature_Forest.mat');
end
ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

w=[31,28,31,30,31,30,31,31,30,31,30,31]./365;
window=12;
chdir='clm45evaphdr_ref';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
eflx_hd=get_clm_sitedat(ncf1,iloc,jloc,varname);
nyr=length(eflx_hd)/12;
eflx_hd_yr=mean(reshape(eflx_hd,[12,nyr]),2);
eflx_std_yr=std(reshape(eflx_hd,[12,nyr]),[],2);

h=errorbar((1:12),eflx_hd_yr,eflx_std_yr,'LineWidth',2);
set(h,'color',cc{j});
hold on;
end
xlabel('Month','FontSize',14);
ylabel('Total projected leaf area index','FontSize',14); 
set(gca,'FontSize',14,'xlim',[0,13]);
legend('Blodgett Forest','Tapajos Forest');