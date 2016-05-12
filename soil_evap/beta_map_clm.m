close all;
clear all;
clc;
%relative change of beta vector 
ncfile1='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/SoilEvap/soil_beta_pch_chbet_beta_bare_soi.nc';
ncfile2='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/SoilEvap/soil_beta_pch_chbet_bare_soi_new.nc';
ncf_map='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/DiffBound/map_info.nc';
pft_lunit=netcdf('/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_itype_lunit');
lon_id = netcdf('/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_ixy');
lat_id = netcdf('/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_jxy');
id2=find(pft_lunit==1);
%read map info
area=netcdf(ncf_map,'var','area');
lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
mam=[3,4,5];
jja=[6,7,8];
son=[9,10,11];
djf=[12,1,2];
%id_season(:,1)=[mam,mam+12,mam+24,mam+36,mam+48];
%id_season(:,2)=[jja,jja+12,jja+24,jja+36,jja+48];
%id_season(:,3)=[son,son+12,son+24,son+36,son+48];
%id_season(:,4)=[djf,djf+12,djf+24,djf+36,djf+48];
id_season(:,1)=[mam,mam+12,mam+24,mam+36,mam+48,djf,djf+12,djf+24,djf+36,djf+48];
id_season(:,2)=[jja,jja+12,jja+24,jja+36,jja+48,son,son+12,son+24,son+36,son+48];
lon=circshift(lon,dshft);

fig=figure(1);
set(fig,'unit','normalized','position',[0.1,0.14,0.5,0.7]);
ax=multipanel(fig,2,2,[0.07,0.07],[0.4,0.4],[0.06,0.05]);
scr=zeros(144,96);
for k = 1 : length(id2)        
    scr(lon_id(id2(k)),lat_id(id2(k)))=1.;
end
id1=find(scr==0.0);
scr(id1)=0./0.;
cm=colormap(flipud(othercolor('RdYlBu_11b')));
for j = 1 : 2
    set(fig,'CurrentAxes',ax(j));
    %read variable
    var='SOILWCONDC1';
    condc=netcdf(ncfile2,'var',var);
    id=find(condc>1d20);condc(id)=0./0.;
    condc1=mean(condc(:,:,id_season(:,j)),3);
    var='SOILWCONDC2';
    condc=netcdf(ncfile2,'var',var);dat=netcdf(ncfile1,'var','SOILWCONDC3');
    id=find(condc>1d20);condc(id)=0./0.;condc=condc./dat;
    condc2=mean(condc(:,:,id_season(:,j)),3);


    condc1=condc1.*scr;
    condc2=condc2.*scr;
    condc1=double(circshift(condc1,dshft));
    condc2=double(circshift(condc2,dshft));
    
    m_proj('miller','lat',82);
    m_coast('color','k');hold on;
    colormap(cm);
    [c,h1]=m_contourf(lon,lat,condc1');set(h1,'LineColor','none');
    
    if(j>=2)
        m_grid('linestyle','none','box','fancy','tickdir','out','xticklabel','','yticklabel','','FontSize',14);
    else
        hc=colorbar('position',[0.47 0.52 0.03 0.4]);
        set(hc,'FontSize',14);
        m_grid('linestyle','none','box','fancy','tickdir','out','xticklabel','','FontSize',14);
    end
    
    set(fig,'CurrentAxes',ax(j+2));
    m_proj('miller','lat',82);
    m_coast('color','k');hold on;
    colormap(cm(1:54,:));
    [c,h]=m_contourf(lon,lat,(condc2'-condc1').*100./condc1',(-90:20:90));set(h,'LineColor','none');
    %colorbar;
    if(j>=2)
        m_grid('linestyle','none','box','fancy','tickdir','out','yticklabel','','FontSize',12);
    else
        hc=colorbar('position',[0.47 0.07 0.03 0.4]);
        set(hc,'FontSize',14);
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
    end    
end
put_tag(fig,ax(1),[0.3,0.2],'(a)\beta: Winter half year',14);
put_tag(fig,ax(3),[0.05,0.2],'(c)$$(\frac{\Delta\beta}{\beta})100$$: Winter half year',14);
put_tag(fig,ax(2),[0.3,0.2],'(b)\beta: Summer half year',14);
put_tag(fig,ax(4),[0.05,0.2],'(d)$$(\frac{\Delta\beta}{\beta})100$$: Summer half year',14);
put_tag(fig,ax(3),[1.175,0.5],'%',14);