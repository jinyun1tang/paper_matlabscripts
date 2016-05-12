close all;
clear all;
clc;

load('/Users/jinyuntang/work/data_collection/FLUXNET_MTE/fluxnet_mte.mat');

lon05=fluxnet_mte.lon;
lat05=fluxnet_mte.lat;

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
ncf_map=[mdir,'area_info.nc'];
latv=netcdf(ncf_map,'var','lat');
lonv=netcdf(ncf_map,'var','lon');


[LAT05,LON05]=meshgrid(lat05,lon05);

id1=find(lonv>180);
lonv(id1)=lonv(id1)-360;
[LATC,LONC]=meshgrid(latv,lonv);
len=size(fluxnet_mte.LH_mean,3);
lh_mean2clm=zeros(length(lonv),length(latv),len);
lh_std2clm=zeros(length(lonv),length(latv),len);
for k = 1 : len;
    lh_mean=squeeze(fluxnet_mte.LH_mean(:,:,k));
    
    lh_std=squeeze(fluxnet_mte.LH_std(:,:,k));

    id=find(abs(lh_mean)>9.9d3);

    lh_mean(id)=0./0.;
    
    lh_std(id)=0./0.;

    lh_mean2clm(:,:,k)=interp2(LAT05,LON05,lh_mean,LATC,LONC);
    
    lh_std2clm(:,:,k)=interp2(LAT05,LON05,lh_std,LATC,LONC);
end
cday=[diff(fluxnet_mte.time);31];%number of days for each data point
year0=1982;
save('mat/fluxnet_mte_clm.mat','lh_mean2clm','year0','cday','lh_std2clm');
