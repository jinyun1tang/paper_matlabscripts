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
ana_type='corr';
varname='PREC';
switch varname

    case 'TBOT'
        axlim=[-7,7]; 
        units='TBOT (K)';        
        outfile_pdf='QIAN_vs_CRU_TBOT';
        
    case 'FDS'
        axlim=[-60,60];
        units='FDS (W m^-^2)';
        outfile_pdf='QIAN_vs_CRU_FDS';
    case 'WIND'
        axlim=[-3,3]; 
        units ='WIND (m s^-^1)'; 
        outfile_pdf='QIAN_vs_CRU_WIND';
    case 'PREC'
        axlim=[-5,5];
        units='PREC (mm day^-^1)';
        outfile_pdf='QIAN_vs_CRU_PREC';

end

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
if(strcmp(ana_type,'corr')==0)
    qiancru_dif=dat_qian-dat_cru;

    qiancru_dif_djf=zeros(sz1,sz2);
    qiancru_dif_mam=zeros(sz1,sz2);
    qiancru_dif_jja=zeros(sz1,sz2);
    qiancru_dif_son=zeros(sz1,sz2);

    %define the seasonal weight

    %get the seasonal mean of the difference

    [w_djf,w_mam, w_jja, w_son]=get_seasonal_weight();
end



switch ana_type
    case 'mean'
        for j1 = 1 : sz1
            for j2 = 1 : sz2                  
                qiancru_dif_djf(j1,j2)=mean(slidew_mean(qiancru_dif(j1,j2,:),12,w_djf));                  
                qiancru_dif_mam(j1,j2)=mean(slidew_mean(qiancru_dif(j1,j2,:),12,w_mam));                   
                qiancru_dif_jja(j1,j2)=mean(slidew_mean(qiancru_dif(j1,j2,:),12,w_jja));                 
                qiancru_dif_son(j1,j2)=mean(slidew_mean(qiancru_dif(j1,j2,:),12,w_son));                    
            end                        
        end       
        outfile_pdf=sprintf('%s_mean.pdf',outfile_pdf);
    case 'stdvsm'    
        axlim=[0,1];   
        unit_loc=strsplit(units,'(');    
        units=unit_loc{1};
        for j1 = 1 : sz1
            for j2 = 1 : sz2
            
                dt_tmp = slidew_mean(qiancru_dif(j1,j2,:),12,w_djf);      
                qiancru_dif_djf(j1,j2)=std(dt_tmp)./(std(dt_tmp)+mean(dt_tmp));
        
                dt_tmp = slidew_mean(qiancru_dif(j1,j2,:),12,w_mam);
                qiancru_dif_mam(j1,j2)=std(dt_tmp)./(std(dt_tmp)+mean(dt_tmp));
        
                dt_tmp=slidew_mean(qiancru_dif(j1,j2,:),12,w_jja);
                qiancru_dif_jja(j1,j2)=std(dt_tmp)./(std(dt_tmp)+mean(dt_tmp));
        
                dt_tmp = slidew_mean(qiancru_dif(j1,j2,:),12,w_son);     
                qiancru_dif_son(j1,j2)=std(dt_tmp)./(std(dt_tmp)+mean(dt_tmp));      
            end        
        end 
        outfile_pdf=sprintf('%s_rstd.pdf',outfile_pdf);    
    case 'corr'
        qian_meansea= zeros(sz1,sz2,12);
        cru_meansea = zeros(sz1,sz2,12);
        gpcp_meansea= zeros(sz1,sz2,12);

        for j1 = 1 : sz1
            for j2 = 1 : sz2
                dat=squeeze(dat_qian(j1,j2,:));          dat1=reshape(dat,[numel(dat)/12,12]);qian_meansea(j1,j2,:)=mean(dat1-repmat(mean(dat1,2),[1,12]),1);
                dat=squeeze(dat_cru(j1,j2,:));           dat1=reshape(dat,[numel(dat)/12,12]);cru_meansea(j1,j2,:)=mean(dat1-repmat(mean(dat1,2),[1,12]),1);     
            end
        end       
        coef_qian_cru=corr_coefm3d(qian_meansea,cru_meansea);        
        outfile_pdf=sprintf('%s_corr.pdf',outfile_pdf);        
end

%prepare for plotting the output
ncf_map=[mdir,'area_info.nc'];

area=netcdf(ncf_map,'var','area');
lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
lon=circshift(lon,dshft);
if(strcmp(ana_type,'corr')==0)
    qiancru_dif_djf=double(circshift(qiancru_dif_djf,dshft));
    qiancru_dif_mam=double(circshift(qiancru_dif_mam,dshft));
    qiancru_dif_jja=double(circshift(qiancru_dif_jja,dshft));
    qiancru_dif_son=double(circshift(qiancru_dif_son,dshft));


    fig=figure(1);

    set(fig,'unit','normalized','position',[0.1,0.14,0.8,0.8],'color','w');
    ax=multipanel(fig,2,2,[0.06,0.1],[0.35,0.4],[0.05,0.05]);
    cm=flipud(othercolor('RdBu11'));
    for j = 1 : 4
        set(fig,'CurrentAxes',ax(j));
        m_proj('miller','lat',82);
        m_coast('color','k');hold on;
        if(strcmp(ana_type,'mean'))    
            colormap(cm);
        else
            colormap(cm(33:end,:));
        end
        if(j==1)
            [c,h]=m_contourf(lon,lat,qiancru_dif_mam');set(h,'Color','none');        
            m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
        elseif(j==2)
            [c,h]=m_contourf(lon,lat,qiancru_dif_jja');set(h,'Color','none');          
            m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','YTicklabel','','FontSize',12);
        elseif(j==4)
            [c,h]=m_contourf(lon,lat,qiancru_dif_djf');set(h,'Color','none');        
            m_grid('linestyle','none','box','fancy','tickdir','out','YTicklabel','','FontSize',12);
        else
            [c,h]=m_contourf(lon,lat,qiancru_dif_son');set(h,'Color','none');            
            m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
        end
    %caxis([-1.5,1.5]);
    end
    ax1=gca;
    pos=get(gca,'pos');
    hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)*1.11 pos(2)+pos(4)*0.5 0.03 pos(4).*1.2],'Fontsize',14);

%set(hc,'xaxislocation','right');
    caxis(gca,axlim);
    put_tag(fig,ax(1),[0.05,0.15],'(a) MAM',14);
    put_tag(fig,ax(2),[0.05,0.15],'(b) JJA',14);
    put_tag(fig,ax(3),[0.05,0.15],'(c) DJF',14);
    put_tag(fig,ax(4),[0.05,0.15],'(d) SON',14);
    xlabel(hc,['    ',units],'FontSize',14);    
else
    coef_qian_cru=double(circshift(coef_qian_cru,dshft));    
    fig=figure(1);
    set(fig,'unit','normalized','position',[0.1,0.14,0.6,0.6],'color','w');    
    cm=flipud(othercolor('RdBu11'));
    m_proj('miller','lat',82);
            
    m_coast('color','k');hold on;
                
    colormap(cm);   
            
    [c,h]=m_contourf(lon,lat,squeeze(coef_qian_cru'),(-0.9:0.05:0.9));
            
    set(h,'color','none');%colorbar;

    m_grid('linestyle','none','box','on','FontSize',14);      
    colorbar('FontSize',14); caxis([-0.91,0.91]);
    title(varname,'FontSize',14);
end

export_fig(outfile_pdf)