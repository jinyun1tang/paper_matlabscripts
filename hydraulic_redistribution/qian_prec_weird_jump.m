close all;
clear all;
clc;

ncf_rain='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45evapdef/RAIN.clm45evapdef.51-60.nc';
ncf_snow='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45evapdef/SNOW.clm45evapdef.51-60.nc';

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

ncf_map=[mdir,'area_info.nc'];

lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
lon=circshift(lon,dshft);


rain=netcdf(ncf_rain,'var','RAIN');
snow=netcdf(ncf_snow,'var','SNOW');

prec_108=rain(:,:,108)+snow(:,:,108);
prec_109=rain(:,:,109)+snow(:,:,109);
prec_dif=prec_109-prec_108;

prec_dif=double(circshift(prec_dif,dshft)).*86400;
    
m_proj('miller','lat',82);

m_coast('color','k');hold on;

[c,h]=m_contourf(lon,lat,prec_dif');set(h,'Color','none');  colorbar;caxis([-15,15]);

        
m_grid('linestyle','none','box','fancy','tickdir','out',...
            'FontSize',12);
        
        
        

ncf_ctl='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45evapdef/TWS.clm45evapdef.51-60.nc';

ncf_ctl='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45evapdef/WA.clm45evapdef.51-60.nc';

tws=netcdf(ncf_ctl,'var','WA');


tws_dif=tws(:,:,110)-tws(:,:,107);
tws_dif=double(circshift(tws_dif,dshft)).*1d-3;        
        
figure;
m_proj('miller','lat',82);

m_coast('color','k');hold on;

[c,h]=m_contourf(lon,lat,tws_dif');set(h,'Color','none');  colorbar;caxis([-4,4]);

        
m_grid('linestyle','none','box','fancy','tickdir','out',...
            'FontSize',12);
        
close all;

for j = 1 : size(tws,1);
    for k=1:size(tws,2);
        ts=squeeze(tws(j,k,:)).*1d-3;
        if(any(isnan(ts)))
            continue
        end
        plot(anomaly_ts(ts),'color',rand([3,1]));hold on;
    end
end
        