close all;
clear all;
ncf_data='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/pchbet_fgev_bare_soi_new.nc';
ncf_map='/Users/jinyuntang/work/data_collection/clm_output/DiffBound/map_info.nc';
%read map info
pft_lunit=netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_itype_lunit');
lon_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_ixy');
lat_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_jxy');
id2=find(pft_lunit==1);
scr=zeros(144,96);
for k = 1 : length(id2)        
    scr(lon_id(id2(k)),lat_id(id2(k)))=1.;
end
id1=find(scr==0.0);
scr(id1)=0./0.;

area=netcdf(ncf_map,'var','area');
lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
figure;
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
lon=circshift(lon,dshft);

mam=[3,4,5];
jja=[6,7,8];
son=[9,10,11];
djf=[12,1,2];
id_season(:,1)=[mam,mam+12,mam+24,mam+36,mam+48];
id_season(:,2)=[jja,jja+12,jja+24,jja+36,jja+48];
id_season(:,3)=[son,son+12,son+24,son+36,son+48];
id_season(:,4)=[djf,djf+12,djf+24,djf+36,djf+48];
%id_season(:,1)=[mam,mam+12,mam+24,mam+36,mam+48,djf,djf+12,djf+24,djf+36,djf+48];
%id_season(:,2)=[jja,jja+12,jja+24,jja+36,jja+48,son,son+12,son+24,son+36,son+48];

fig=figure(1);
set(fig,'unit','normalized','position',[0.1,0.14,0.3,0.4]);
ax=multipanel(fig,2,2,[0.1,0.1],[0.4,0.4],[0.05,0.05]);
area=area';
id=find(area>1d20);
area(id)=0.0;
cm=colormap(flipud(othercolor('RdYlBu_11b')));
for j = 1 : 4
    set(fig,'CurrentAxes',ax(j));
    data=netcdf(ncf_data,'var','FGEV');data=data(:,:,id_season(:,j));qsoit=mean(data,3);qsoit=qsoit.*scr;qsoit=circshift(qsoit,dshft);
    data=netcdf(ncf_data,'var','FGEV_DEEP');data=data(:,:,id_season(:,j));qsoid=mean(data,3);qsoid=circshift(qsoid,dshft);
    id=find(abs(qsoit)>1d10);qsoit(id)=0./0.;
    id=find(abs(qsoid)>1d10);qsoid(id)=0./0.;
    m_proj('miller','lat',82);
    m_coast('color','k');hold on;
    if(j==1)
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
    elseif(j==2)
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','YTicklabel','','FontSize',12);
    elseif(j==4)
        m_grid('linestyle','none','box','fancy','tickdir','out','YTicklabel','','FontSize',12);
    else
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
    end
        
    qsoid=qsoid';
    qsoit=qsoit';
    pct=double(qsoid)./double(qsoit).*100;
    id=find(pct>100);pct(id)=100.;
    id=find(pct<0);pct(id)=0.;
    id=find(~isnan(pct)==1);
    sum(qsoid(id).*area(id))./sum(qsoit(id).*area(id))
    h=m_pcolor(lon,lat,pct);
    set(h,'EdgeColor','none');
%    shading interp;
    
end
put_tag(fig,ax(1),[0.4,0.2],'(a) MAM',14);
put_tag(fig,ax(2),[0.4,0.2],'(b) JJA',14);
put_tag(fig,ax(3),[0.4,0.2],'(c) SON',14);
put_tag(fig,ax(4),[0.4,0.2],'(d) DJF',14);

%pos=get(ax(2),'pos');
hc=colorbar('location','eastoutside','position',[0.5 0.3 0.03 0.5]);
set(hc,'FontSize',14);
put_tag(fig,ax(3),[1.05,1.8],'%',14);
