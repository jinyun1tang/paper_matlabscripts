close all;
clear all;
clc;

%compute the zhang curve
%zhang's curve
p=(200:3500);
forest=(1+2*1410./p)./(1+2.*1410./p+p./1410).*p;
grass=(1+0.5*1100./p)./(1+0.5*1100./p+p./1100).*p;

ncf1_soi='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch_bare_soi.nc';
ncf2_soi='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_bare_soi.nc';
ncf3_soi='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch_beta_bare_soi.nc';
ncf4_soi='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_beta_bare_soi.nc';

ncf1_for='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch_forest_soi.nc';
ncf2_for='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_forest_soi.nc';
ncf3_for='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch_beta_forest_soi.nc';
ncf4_for='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_beta_forest_soi.nc';

ncf1_grs='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch_grass_soi.nc';
ncf2_grs='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_grass_soi.nc';
ncf3_grs='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch_beta_grass_soi.nc';
ncf4_grs='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_beta_grass_soi.nc';

tsum=86400.*365.0;
load('../diffuse_boundary/prec_pft.mat');
prec_pft=prec_pft.*tsum;
pft=netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_itype_veg');
pft_lunit=netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_itype_lunit');

lon_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_ixy');
lat_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_jxy');
ipft=13;
pft_id=find(pft==ipft);

pct=get_pft(ipft);

scr=zeros(144,96);
prec=zeros(144,96);
for j = 1 : length(pft_id)
    if(pct(lon_id(pft_id(j)),lat_id(pft_id(j)))>50)
        scr(lon_id(pft_id(j)),lat_id(pft_id(j)))=1.;
        prec(lon_id(pft_id(j)),lat_id(pft_id(j)))=prec_pft(pft_id(j));
    end
end
%scr(1:90,:)=0.;
%scr(130:144,:)=0.;
prec=prec.*scr;
id=(1:60);
var='QSOIL';
wt=[31,28,31,30,31,30,31,31,30,31,30,31]';
wt=repmat(wt,[5,1]);

qsoi_ch=get_clm_data(ncf1_soi, var, id, wt,scr);
qsoi_chbet=get_clm_data(ncf2_soi, var, id, wt,scr);
qsoi_ch_beta=get_clm_data(ncf3_soi, var, id, wt,scr);
qsoi_chbet_beta=get_clm_data(ncf4_soi, var, id,wt, scr);

qfor_ch=get_clm_data(ncf1_for, var, id, wt,scr);
qfor_chbet=get_clm_data(ncf2_for, var, id, wt,scr);
qfor_ch_beta=get_clm_data(ncf3_for, var, id, wt,scr);
qfor_chbet_beta=get_clm_data(ncf4_for, var, id,wt, scr);

qgrs_ch=get_clm_data(ncf1_grs, var, id, wt,scr);
qgrs_chbet=get_clm_data(ncf2_grs, var, id, wt,scr);
qgrs_ch_beta=get_clm_data(ncf3_grs, var, id, wt,scr);
qgrs_chbet_beta=get_clm_data(ncf4_grs, var, id,wt, scr);

id1=find(prec>0);

fig=1;
figure(fig);
set(fig,'unit','normalized','position',[0.2,0.2,0.5,0.7]);
ax=multipanel(fig,2,2,[0.12,0.1],[0.4,0.4],[0.05,0.075]);
set(fig,'CurrentAxes',ax(1));
h(1)=plot(p,forest,'k','linewidth',2);hold on;
h(2)=plot(p,grass,'k--','linewidth',2);
h(3)=plot(prec(id1),qsoi_ch_beta(id1).*tsum,'rx','MarkerSize',4);
h(4)=plot(prec(id1),qsoi_chbet_beta(id1).*tsum,'kx','MarkerSize',4);
h(5)=plot(prec(id1),qsoi_ch(id1).*tsum,'x','MarkerSize',4);
h(6)=plot(prec(id1),qsoi_chbet(id1).*tsum,'gx','MarkerSize',4);
set(ax(1),'FontSize',14,'XTick',(0:1000:5000),'YTick',(0:1000:5000),'Xlim',[0,5000],'Ylim',[0,5000]);
xlabel('Precipitation (mm yr^-^1)','FontSize',14);
ylabel('Evapotranspiration (mm yr^-^1)','FontSize',14);
line([200,5000],[200,5000]);

set(fig,'CurrentAxes',ax(2));
h(1)=plot(p,forest,'k','linewidth',2);hold on;
h(2)=plot(p,grass,'k--','linewidth',2);
h(3)=plot(prec(id1),qfor_ch_beta(id1).*tsum,'rx','MarkerSize',4);
h(4)=plot(prec(id1),qfor_chbet_beta(id1).*tsum,'kx','MarkerSize',4);
h(5)=plot(prec(id1),qfor_ch(id1).*tsum,'x','MarkerSize',4);
h(6)=plot(prec(id1),qfor_chbet(id1).*tsum,'gx','MarkerSize',4);
set(ax(2),'FontSize',14,'XTick',(0:1000:5000),'YTick',(0:1000:5000),'Xlim',[0,5000],'Ylim',[0,5000]);
xlabel('Precipitation (mm yr^-^1)','FontSize',14);
ylabel('Evapotranspiration (mm yr^-^1)','FontSize',14);
line([200,5000],[200,5000]);

set(fig,'CurrentAxes',ax(3));
h(1)=plot(p,forest,'k','linewidth',2);hold on;
h(2)=plot(p,grass,'k--','linewidth',2);
h(3)=plot(prec(id1),qgrs_ch_beta(id1).*tsum,'rx','MarkerSize',4);
h(4)=plot(prec(id1),qgrs_chbet_beta(id1).*tsum,'kx','MarkerSize',4);
h(5)=plot(prec(id1),qgrs_ch(id1).*tsum,'x','MarkerSize',4);
h(6)=plot(prec(id1),qgrs_chbet(id1).*tsum,'gx','MarkerSize',4);
set(ax(3),'FontSize',14,'XTick',(0:1000:5000),'YTick',(0:1000:5000),'Xlim',[0,5000],'Ylim',[0,5000]);
xlabel('Precipitation (mm yr^-^1)','FontSize',14);
ylabel('Evapotranspiration (mm yr^-^1)','FontSize',14);
line([200,5000],[200,5000]);

lh=legend(h,'Forest','Grass','CH-\beta','CHBET-\beta','CH','CHBET');
set(lh,'FontSize',14);
delete(ax(4));
set(lh,'position',[0.7,0.1,0.15,0.2]);