close all;
clear all;
clc;
%DESCRIPTION
%test the diffusion in the simulated rhd effect due to different numerical
%implementation
%here tests whether the inclusion of hd has reduced the ET bias

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';


%reference
chdir='clm45hdr_maxlai_ref';
%chdir='clm45evapcosby4';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
ncf2=[mdir,chdir,'/','QVEGT','.',chdir,'.51-60.nc'];
ncf3=[mdir,chdir,'/','QVEGE','.',chdir,'.51-60.nc'];
ncf_map=[mdir,'area_info.nc'];
qsoil=netcdf(ncf1,'var','QSOIL');
qvegt=netcdf(ncf2,'var','QVEGT');
qvege=netcdf(ncf3,'var','QVEGE');
id=find(abs(qsoil)>1d3);
qsoil(id)=0./0.;
qet_ref=(qsoil+qvegt+qvege).*86400;

qet_ref_ave=mean(qet_ref,3);
%[c,h]=contourf(qet_ref_ave');set(h,'color','none');colorbar;
chdir='clm45evaphdr_seq_maxlai';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
ncf2=[mdir,chdir,'/','QVEGT','.',chdir,'.51-60.nc'];
ncf3=[mdir,chdir,'/','QVEGE','.',chdir,'.51-60.nc'];

qsoil=netcdf(ncf1,'var','QSOIL');
qvegt=netcdf(ncf2,'var','QVEGT');
qvege=netcdf(ncf3,'var','QVEGE');
id=find(abs(qsoil)>1d3);
qsoil(id)=0./0.;
qetbs_ref=(qsoil+qvegt+qvege).*86400;


etdif_hdr=qetbs_ref-qet_ref;
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

set(fig,'unit','normalized','position',[0.1,0.14,0.8,0.9],'color','w');
ax=multipanel(fig,2,2,[0.1,0.1],[0.4,0.38],[0.05,0.05]);
fontsz=14;
cm=(othercolor('BuDRd_18'));
for j = 1 : 4
    set(fig,'CurrentAxes',ax(j));
    m_proj('miller','lat',82);
    m_coast('color','k','linewidth',2);hold on;
    colormap(cm(30:end,:));
    if(j==1)
        [c,h]=m_contourf(lon,lat,etdif_hdr_mam');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',fontsz);
    elseif(j==2)
        [c,h]=m_contourf(lon,lat,etdif_hdr_jja');set(h,'Color','none');          
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','YTicklabel','','FontSize',fontsz);
    elseif(j==4)
        [c,h]=m_contourf(lon,lat,etdif_hdr_djf');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','YTicklabel','','FontSize',fontsz);
    else
        [c,h]=m_contourf(lon,lat,etdif_hdr_son');set(h,'Color','none');            
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',fontsz);
    end

end
caxis([-0.5,3.5]);
pos=get(ax(1),'pos');
hc=colorbar('location','northoutside','position',[pos(1)+pos(3)*0.25 pos(2)+pos(4)*1.05 pos(3)*1.7 0.03],'Fontsize',20);

put_tag(fig,ax(1),[0.4,0.2],'(a) MAM',20);
put_tag(fig,ax(2),[0.4,0.2],'(b) JJA',20);
put_tag(fig,ax(3),[0.4,0.2],'(c) SON',20);
put_tag(fig,ax(4),[0.4,0.2],'(d) DJF',20);


put_tag(fig,ax(2),[0.85,1.1],'\DeltaET (mm day^-^1)',fontsz);
export_fig('Figure_RHD_seq_minus_ref.pdf');






