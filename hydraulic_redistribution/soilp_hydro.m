close all;
clear all;
clc;
%compare soil hydraulic properties of the topsoil
varname='WATSAT';
varname='BSW';
varname='HKSAT';
varname='SUCSAT';
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

ncf1=[mdir,'def_soihydp.nc'];
ncf2=[mdir,'cosby4_soihydp.nc'];
ncf3=[mdir,'noilhan_soihydp.nc'];
ncf_map=[mdir,'area_info.nc'];

lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
lon=circshift(lon,dshft);

bsw1=netcdf(ncf1,'var',varname);
bsw2=netcdf(ncf2,'var',varname);
bsw3=netcdf(ncf3,'var',varname);
id=find(abs(bsw1)>1d10);
bsw1(id)=0./0.;
bsw2(id)=0./0.;
bsw3(id)=0./0.;
subplot(2,1,1);
cm=flipud(othercolor('RdBu11'));
colormap(cm(10:end,:));
m_proj('miller','lat',82);
m_coast('color','k');hold on;

dat_dif=squeeze(((bsw2(:,:,1)-bsw1(:,:,1)))./bsw1(:,:,1).*100);
dat1_dif=double(circshift(dat_dif,dshft));
dat_dif=squeeze(((bsw3(:,:,1)-bsw1(:,:,1)))./bsw1(:,:,1).*100);
dat2_dif=double(circshift(dat_dif,dshft));

[c,h]=m_contourf(lon,lat,dat1_dif');colorbar;set(h,'color','none');%caxis([-30,30]);
m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
title(['rdif cosby4: ',varname, '(%)'],'FontSize',14);
freezeColors;
cbfreeze;
subplot(2,1,2);
colormap(cm(30:end,:));
m_proj('miller','lat',82);
m_coast('color','k');hold on;
[c,h]=m_contourf(lon,lat,dat2_dif');colorbar;set(h,'color','none');
m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);%caxis([-100,100]);
title(['rdif noilhan: ',varname, '(%)'],'FontSize',14);