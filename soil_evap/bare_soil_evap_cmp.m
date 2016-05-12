close all;
clear all;
clc;
ncf1='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch_bare_soi.nc';
ncf2='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_bare_soi_new.nc';
ncf3='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch_beta_bare_soi_new.nc';
%ncf3='/Users/jinyuntang/work//data_collection/clm_output/SoilEvap/qflx_pchbet_bare_soi_lit_new.nc';
ncf4='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_beta_bare_soi.nc';

ncf_map='/Users/jinyuntang/work/data_collection/clm_output/DiffBound/map_info.nc';
pft_lunit=netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_itype_lunit');
lon_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_ixy');
lat_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_jxy');
id2=find(pft_lunit==1);
%read map info

tsum=86400;
area=netcdf(ncf_map,'var','area');
lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
lon=circshift(lon,dshft);
wt=[31,28,31,30,31,30,31,31,30,31,30,31]';
wt=repmat(wt,[5,1]);
scr=zeros(144,96);
for k = 1 : length(id2)        
    scr(lon_id(id2(k)),lat_id(id2(k)))=1.;
end
id1=find(scr==0.0);
scr(id1)=0./0.;
area(id1)=0.0;
clear id1;
var='QSOIL';
id=(1:60);

fig=figure(1);
set(fig,'unit','normalized','position',[0.1,0.14,0.3,0.4]);
ax=multipanel(fig,2,2,[0.1,0.1],[0.4,0.4],[0.05,0.05]);
mam=[3,4,5];
jja=[6,7,8];
son=[9,10,11];
djf=[12,1,2];
id_season(:,1)=[mam,mam+12,mam+24,mam+36,mam+48];
id_season(:,2)=[jja,jja+12,jja+24,jja+36,jja+48];
id_season(:,3)=[son,son+12,son+24,son+36,son+48];
id_season(:,4)=[djf,djf+12,djf+24,djf+36,djf+48];
days_season(1)=31+30+31;
days_season(2)=30+31+31;
days_season(3)=30+31+30;
days_season(4)=31+31+28;
cm=colormap(flipud(othercolor('RdYlBu_11b')));
cm=colormap(jet);
area=area';

for j = 1 : 4
    set(fig,'CurrentAxes',ax(j));
    %qsoi_ch=get_clm_data(ncf1, var, id_season(:,j),wt,scr, dshft);
    qsoi_chbet=get_clm_data(ncf3, var, id_season(:,j),wt(id_season(:,j)),scr, dshft);
    qsoi_ch_beta=get_clm_data(ncf2, var, id_season(:,j),wt(id_season(:,j)),scr, dshft);
    %qsoi_chbet_beta=get_clm_data(ncf4, var,id,wt,scr, dshft);
    
    %colormap(cm(1:32,:));
    df=qsoi_chbet'-qsoi_ch_beta';
    %df=-df;
    if(j==1)
        df1=df.*days_season(j)./365;
    else
        df1=df1+df.*days_season(j)./365;
    end    
    id_n=find(isnan(df)==0);    
    sum(df(id_n).*area(id_n))./sum(area(id_n)).*tsum
    
    m_proj('miller','lat',82);
    m_coast('color','k');hold on;
    [c,h]=m_contourf(lon,lat,df.*tsum,(-0.4:0.1:0.4));set(h,'Color','none');
    if(j==1)
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
    elseif(j==2)
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','YTicklabel','','FontSize',12);
    elseif(j==4)
        m_grid('linestyle','none','box','fancy','tickdir','out','YTicklabel','','FontSize',12);
    else
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
    end
  
end
put_tag(fig,ax(1),[0.4,0.2],'(a) MAM',14);
put_tag(fig,ax(2),[0.4,0.2],'(b) JJA',14);
put_tag(fig,ax(3),[0.4,0.2],'(c) SON',14);
put_tag(fig,ax(4),[0.4,0.2],'(d) DJF',14);

%pos=get(ax(2),'pos');
hc=colorbar('location','eastoutside','position',[0.5 0.3 0.03 0.5]);
set(hc,'FontSize',14);
put_tag(fig,ax(3),[1.05,1.92],'\DeltaE_s_o_i',12);
put_tag(fig,ax(3),[1.01,1.85],'(mm day^-^1)',12);

fig2=figure(2);

ax=subplot(1,1,1);
colormap(cm(1:32,:));
m_proj('miller','lat',82);
m_coast('color','k');hold on;
[c,h]=m_contourf(lon,lat,df1.*tsum);set(h,'Color','none');colorbar;
m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);put_tag(fig2,ax,[1.04,1.1],'\DeltaE_s_o_i (mm day^-^1)',12);
id_n=find(isnan(df1)==0);    
sum(df1(id_n).*area(id_n))./sum(area(id_n)).*tsum
close all