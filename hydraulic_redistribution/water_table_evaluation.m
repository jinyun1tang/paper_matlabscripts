close all;
clear all;
clc;
%compare the simulated water table, which used to indicate ground aquifer
%levels, under the influence of hydraulic redistribution
mdir ='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';


chdir={'clm45evapdef','clm45hdr_maxlai_ref','cruclm45def','cruclm45hd_maxlai_ref'};


j0=3;
if(j0==1)
    outfile_pdf1='qian_hd_induced_deltazwt.pdf';
    outfile_pdf2='qian_reference_zwt.pdf';
    outfile_pdf3='qian_hd_induced_deltazwt_rel.pdf';
    
elseif(j0==3)
    outfile_pdf1='cru_hd_induced_deltazwt.pdf';
    outfile_pdf2='cru_reference_zwt.pdf';    
    outfile_pdf3='cru_hd_induced_deltazwt_rel.pdf';

end
ncf_ref=[mdir,chdir{j0},'/ZWT.',chdir{j0},'.51-60.nc'];

ncf_hd=[mdir,chdir{j0+1},'/ZWT.',chdir{j0+1},'.51-60.nc'];


zwt_ref=netcdf(ncf_ref,'var','ZWT');

zwt_hd=netcdf(ncf_hd,'var','ZWT');



%removing spval values
zwt_hd=rm_nan(zwt_hd);

zwt_dif=zwt_hd-zwt_ref;


sz1=size(zwt_dif,1);
sz2=size(zwt_dif,2);
zwt_dif_djf=zeros(sz1,sz2);
zwt_dif_mam=zeros(sz1,sz2);
zwt_dif_jja=zeros(sz1,sz2);
zwt_dif_son=zeros(sz1,sz2);

%define the seasonal weight
%get the seasonal mean of the difference
[w_djf,w_mam, w_jja, w_son]=get_seasonal_weight();
    
for j1 = 1 : sz1
    
    for j2 = 1 : sz2
    
                    
        zwt_dif_djf(j1,j2)=mean(slidew_mean(zwt_dif(j1,j2,:),12,w_djf));
                       
        zwt_dif_mam(j1,j2)=mean(slidew_mean(zwt_dif(j1,j2,:),12,w_mam));
        
        zwt_dif_jja(j1,j2)=mean(slidew_mean(zwt_dif(j1,j2,:),12,w_jja));
        
        zwt_dif_son(j1,j2)=mean(slidew_mean(zwt_dif(j1,j2,:),12,w_son));        
            
    end
        
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

zwt_dif_djf=double(circshift(zwt_dif_djf,dshft));
zwt_dif_mam=double(circshift(zwt_dif_mam,dshft));
zwt_dif_jja=double(circshift(zwt_dif_jja,dshft));
zwt_dif_son=double(circshift(zwt_dif_son,dshft));


fig=figure(1);

set(fig,'unit','normalized','position',[0.1,0.14,0.8,0.8],'color','w');
ax=multipanel(fig,2,2,[0.06,0.1],[0.35,0.4],[0.05,0.05]);
cm=flipud(othercolor('BuDRd_18'));
for j = 1 : 4
    set(fig,'CurrentAxes',ax(j));
    m_proj('miller','lat',82);
    m_coast('color','k','linewidth',2);hold on;
  
    colormap(cm(25:end,:));
    if(j==1)
        [c,h]=m_contourf(lon,lat,zwt_dif_mam');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
    elseif(j==2)
        [c,h]=m_contourf(lon,lat,zwt_dif_jja');set(h,'Color','none');          
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','YTicklabel','','FontSize',12);
    elseif(j==4)
        [c,h]=m_contourf(lon,lat,zwt_dif_djf');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','YTicklabel','','FontSize',12);
    else
        [c,h]=m_contourf(lon,lat,zwt_dif_son');set(h,'Color','none');            
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
    end
    caxis([-5,20]);
end
ax1=gca;
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)*1.11 pos(2)+pos(4)*0.5 0.03 pos(4).*1.2],'Fontsize',14);


put_tag(fig,ax(1),[0.05,0.15],'(a) MAM',14);
put_tag(fig,ax(2),[0.05,0.15],'(b) JJA',14);
put_tag(fig,ax(3),[0.05,0.15],'(c) DJF',14);
put_tag(fig,ax(4),[0.05,0.15],'(d) SON',14);
xlabel(hc,['    ','\Delta ZWT (m)'],'FontSize',14);
export_fig(outfile_pdf1);
%%%
zwt_ref=rm_nan(zwt_ref);
%plot the mean reference water table

zwt_djf=zeros(sz1,sz2);
zwt_mam=zeros(sz1,sz2);
zwt_jja=zeros(sz1,sz2);
zwt_son=zeros(sz1,sz2);

    
for j1 = 1 : sz1
    
    for j2 = 1 : sz2
    
                    
        zwt_djf(j1,j2)=mean(slidew_mean(zwt_ref(j1,j2,:),12,w_djf));
                       
        zwt_mam(j1,j2)=mean(slidew_mean(zwt_ref(j1,j2,:),12,w_mam));
        
        zwt_jja(j1,j2)=mean(slidew_mean(zwt_ref(j1,j2,:),12,w_jja));
        
        zwt_son(j1,j2)=mean(slidew_mean(zwt_ref(j1,j2,:),12,w_son));        
            
    end
        
end

zwt_djf=double(circshift(zwt_djf,dshft));
zwt_mam=double(circshift(zwt_mam,dshft));
zwt_jja=double(circshift(zwt_jja,dshft));
zwt_son=double(circshift(zwt_son,dshft));

fig=figure(2);

set(fig,'unit','normalized','position',[0.1,0.14,0.8,0.8],'color','w');
ax=multipanel(fig,2,2,[0.06,0.1],[0.35,0.4],[0.05,0.05]);
cm=flipud(othercolor('BuDRd_18'));
for j = 1 : 4
    set(fig,'CurrentAxes',ax(j));
    m_proj('miller','lat',82);
    m_coast('color','k','linewidth',2);hold on;
  
    colormap(cm(33:end,:));
    if(j==1)
        [c,h]=m_contourf(lon,lat,zwt_mam');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
    elseif(j==2)
        [c,h]=m_contourf(lon,lat,zwt_jja');set(h,'Color','none');          
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','YTicklabel','','FontSize',12);
    elseif(j==4)
        [c,h]=m_contourf(lon,lat,zwt_djf');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','YTicklabel','','FontSize',12);
    else
        [c,h]=m_contourf(lon,lat,zwt_son');set(h,'Color','none');            
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
    end
    caxis([0,13]);

end
ax1=gca;
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)*1.11 pos(2)+pos(4)*0.5 0.03 pos(4).*1.2],'Fontsize',14);


put_tag(fig,ax(1),[0.05,0.15],'(a) MAM',14);
put_tag(fig,ax(2),[0.05,0.15],'(b) JJA',14);
put_tag(fig,ax(3),[0.05,0.15],'(c) DJF',14);
put_tag(fig,ax(4),[0.05,0.15],'(d) SON',14);
xlabel(hc,['    ','ZWT (m)'],'FontSize',14);
export_fig(outfile_pdf2);



fig=figure(3);

set(fig,'unit','normalized','position',[0.1,0.14,0.8,0.8],'color','w');
ax=multipanel(fig,2,2,[0.06,0.1],[0.35,0.4],[0.05,0.05]);
cm=flipud(othercolor('BuDRd_18'));
for j = 1 : 4
    set(fig,'CurrentAxes',ax(j));
    m_proj('miller','lat',82);
    m_coast('color','k','linewidth',2);hold on;
  
    colormap(cm(1:end,:));
    if(j==1)
        [c,h]=m_contourf(lon,lat,zwt_dif_mam'./zwt_mam'.*100);set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
    elseif(j==2)
        [c,h]=m_contourf(lon,lat,zwt_dif_jja'./zwt_jja'.*100);set(h,'Color','none');          
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','YTicklabel','','FontSize',12);
    elseif(j==4)
        [c,h]=m_contourf(lon,lat,zwt_dif_djf'./zwt_djf'.*100);set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','YTicklabel','','FontSize',12);
    else
        [c,h]=m_contourf(lon,lat,zwt_dif_son'./zwt_son'.*100);set(h,'Color','none');            
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
    end
    caxis([-100,100]);


end
ax1=gca;
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)*1.11 pos(2)+pos(4)*0.5 0.03 pos(4).*1.2],'Fontsize',14);


put_tag(fig,ax(1),[0.05,0.15],'(a) MAM',14);
put_tag(fig,ax(2),[0.05,0.15],'(b) JJA',14);
put_tag(fig,ax(3),[0.05,0.15],'(c) DJF',14);
put_tag(fig,ax(4),[0.05,0.15],'(d) SON',14);
xlabel(hc,['    ','\delta ZWT (%)'],'FontSize',14);
%export_fig(outfile_pdf3);








