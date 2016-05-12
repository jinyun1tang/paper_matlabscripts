%Compare the climatology between QIAN and CRU dataset
%the climatology is based on 10 year average from 51 to 60 of a 60 year
%simulations

close all;
clear all;
clc;

mdir ='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

qianclm=[mdir,'climatology/qian.climatology.51-60.nc'];
cruclm=[mdir,'climatology/cru.climatology.51-60.nc'];
%the data contains 
%FLDS, atmospheric longwave radiation'
%FSDS, atmospheric incident solar radiation'
%RAIN, rainfall
%SNOW, snowfall
%TBOT, atmospheric air temperature
%WIND, magnitude of wind speed

%prepare for plotting the output
ncf_map=[mdir,'area_info.nc'];

area=netcdf(ncf_map,'var','area');
lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
lon=circshift(lon,dshft);


    
fig=figure(1);

set(fig,'unit','normalized','position',[0.1,0.14,0.6,0.6],'color','w');    
    
ax=multipanel(fig,2,2,[0.06,0.1],[0.35,0.4],[0.05,0.05]);
    
cm=flipud(othercolor('RdBu11'));
    
varnames={'TBOT','FDS','WIND','PREC'};
tags={'(a)','(b)','(c)','(d)'};
for k = 1 : 4
    varname=varnames{k};


    switch varname
        case 'FDS'    
            dat_qian=netcdf(qianclm,'var','FLDS');    
            dat = netcdf(qianclm,'var','FSDS');    
            dat_qian = dat_qian + dat;       
            dat_cru=netcdf(cruclm,'var','FLDS');    
            dat = netcdf(cruclm,'var','FSDS');    
            dat_cru=dat_cru + dat;    
        case 'PREC'  
            dat_qian=netcdf(qianclm,'var','RAIN');
            dat = netcdf(qianclm,'var','SNOW');
            dat_qian = dat_qian + dat;       
            dat_cru=netcdf(cruclm,'var','RAIN');    
            dat = netcdf(cruclm,'var','SNOW');   
            dat_cru=dat_cru + dat;
            dat_qian=dat_qian.*dayseconds();       
            dat_cru=dat_cru.*dayseconds();            
        otherwise                
            dat_qian=netcdf(qianclm,'var',varname);    
            dat_cru=netcdf(cruclm,'var',varname);
    end
    %removing spval values
    dat_qian=rm_nan(dat_qian);

    
    sz1=size(dat_qian,1);
    sz2=size(dat_qian,2);
        
    qian_meansea= zeros(sz1,sz2,12);    
    cru_meansea = zeros(sz1,sz2,12);           
    for j1 = 1 : sz1    
        for j2 = 1 : sz2        
            dat=squeeze(dat_qian(j1,j2,:));          dat1=reshape(dat,[numel(dat)/12,12]);qian_meansea(j1,j2,:)=mean(dat1-repmat(mean(dat1,2),[1,12]),1);            
            dat=squeeze(dat_cru(j1,j2,:));           dat1=reshape(dat,[numel(dat)/12,12]);cru_meansea(j1,j2,:)=mean(dat1-repmat(mean(dat1,2),[1,12]),1);                 
        end        
    end
    
    coef_qian_cru=corr_coefm3d(qian_meansea,cru_meansea);   
      
    coef_qian_cru=double(circshift(coef_qian_cru,dshft));    

    set(fig,'CurrentAxes',ax(k));
    m_proj('miller','lat',82);
            
    m_coast('color','k');hold on;
                
    colormap(cm);   
        
    [c,h]=m_contourf(lon,lat,squeeze(coef_qian_cru'),(-0.9:0.05:0.9));        
    switch k
        case 1
      
            m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
        case 2        
            m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','YTicklabel','','FontSize',12);
        case 4     
            m_grid('linestyle','none','box','fancy','tickdir','out','YTicklabel','','FontSize',12);
        otherwise           
            m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
    end

            
    set(h,'color','none');%colorbar;
   

    title(varname,'FontSize',14);
    put_tag(fig,ax(k),[.025,.1],tags{k},14);
end

ax1=gca;

pos=get(gca,'pos');

hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)*1.11 pos(2)+pos(4)*0.5 0.03 pos(4).*1.2],'Fontsize',14);
%export_fig(outfile_pdf)