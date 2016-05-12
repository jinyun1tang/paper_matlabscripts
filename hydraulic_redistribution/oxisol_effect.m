close all;
clear all;
clc;
%DESCRIPTION
%test the diffusion in the simulated rhd effect due to different numerical
%implementation
%here tests whether the inclusion of hd has reduced the ET bias

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

fmat='ET_oxisol_original_LHC.mat';

load([mdir,fmat]);
sz=size(QSOIL);
qet_oxi=zeros(sz(2),sz(3),sz(1));
for kk =1  : sz(1)
    qet_oxi(:,:,kk)=squeeze(QSOIL(kk,:,:)+QVEGE(kk,:,:)+QVEGT(kk,:,:));
end

qet_oxi=qet_oxi.*86400;
%reference
chdir='clm45evapdef';
%chdir='clm45evapcosby4';

ncf1=[mdir,chdir,'/TET_clm45evapdef.nc'];
ncf2=[mdir,chdir,'/TET_clm45evapdef.nc'];
ncf3=[mdir,chdir,'/TET_clm45evapdef.nc'];

ncf_map=[mdir,'area_info.nc'];
qsoil=netcdf(ncf1,'var','QSOIL');
qvegt=netcdf(ncf2,'var','QVEGT');
qvege=netcdf(ncf3,'var','QVEGE');
id=find(abs(qsoil)>1d3);
qsoil(id)=0./0.;
qet_ref=(qsoil+qvegt+qvege).*86400;





etdif_hdr=qet_oxi-qet_ref;
id=find(abs(etdif_hdr)<1.d-6);
etdif_hdr(id)=0./0.;
%get the seasonal mean of the difference
w_djf=[31,28,0,0,0,0,0,0,0,0,0,31]./(31+28+31);
w_mam=[0,0,31,30,31,0,0,0,0,0,0,0]./(31+31+30);
w_jja=[0,0,0,0,0,30,31,31,0,0,0,0]./(31+31+30);
w_son=[0,0,0,0,0,0,0,0,30,31,30,0]./(31+30+30);

sz1=size(etdif_hdr,1);
sz2=size(etdif_hdr,2);
etdif_hdr_djf=zeros(sz1,sz2);
etdif_hdr_mam=zeros(sz1,sz2);
etdif_hdr_jja=zeros(sz1,sz2);
etdif_hdr_son=zeros(sz1,sz2);

for j1 = 1 : sz1
    for j2 = 1 : sz2
        etdif_hdr_djf(j1,j2)=mean(slidew_mean(etdif_hdr(j1,j2,:),12,w_djf));
        etdif_hdr_mam(j1,j2)=mean(slidew_mean(etdif_hdr(j1,j2,:),12,w_mam));
        etdif_hdr_jja(j1,j2)=mean(slidew_mean(etdif_hdr(j1,j2,:),12,w_jja));
        etdif_hdr_son(j1,j2)=mean(slidew_mean(etdif_hdr(j1,j2,:),12,w_son));        
    end
end

area=netcdf(ncf_map,'var','area');
lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
lon=circshift(lon,dshft);

etdif_hdr_djf=double(circshift(etdif_hdr_djf,dshft));
etdif_hdr_mam=double(circshift(etdif_hdr_mam,dshft));
etdif_hdr_jja=double(circshift(etdif_hdr_jja,dshft));
etdif_hdr_son=double(circshift(etdif_hdr_son,dshft));


fig=figure(1);

set(fig,'unit','normalized','position',[0.1,0.14,0.6,0.6],'color','w');
ax=multipanel(fig,4,1,[0.1,0.1],[0.78,0.18],[0.05,0.04]);
fontsz=14;
cm=flipud(othercolor('RdBu11'));
for j = 1 : 4
    set(fig,'CurrentAxes',ax(j));
    m_proj('miller','lat',[-25 25],'long',[-180 180]);

    m_coast('color','k');hold on;
    colormap(cm(1:end,:));
    if(j==1)
        [c,h]=m_contourf(lon,lat,etdif_hdr_mam');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',fontsz);
    elseif(j==2)
        [c,h]=m_contourf(lon,lat,etdif_hdr_jja');set(h,'Color','none');          
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',fontsz);
    elseif(j==4)
        [c,h]=m_contourf(lon,lat,etdif_hdr_djf');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',fontsz);
    else
        [c,h]=m_contourf(lon,lat,etdif_hdr_son');set(h,'Color','none');            
        m_grid('linestyle','none','box','fancy','tickdir','out','xticklabel','','FontSize',fontsz);
    end
    caxis([-0.15,0.15]);
end

put_tag(fig,ax(1),[0.4,0.2],'(a) MAM',14);
put_tag(fig,ax(2),[0.4,0.2],'(b) JJA',14);
put_tag(fig,ax(3),[0.4,0.2],'(c) SON',14);
put_tag(fig,ax(4),[0.4,0.2],'(d) DJF',14);

%pos=get(ax(2),'pos');
hc=colorbar('location','eastoutside','position',[0.913 0.3 0.03 0.5]);
set(hc,'FontSize',14);
put_tag(fig,ax(2),[1.0,-1.5],'\DeltaET (mm day^-^1)',fontsz);
