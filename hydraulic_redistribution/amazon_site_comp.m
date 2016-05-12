close all;
clear all;
clc;
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
fontsz=14;
linewidth=2;
%amazon somewhere
lonp=297.5;
latp=-2.842105;
%sierra
%lonp=240;
%latp=38.84211;
%tapajos
lonp=305;
latp=-2.356021;

ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

tdayssec=86400;
chdir='clm45evaphdr_ref';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
qsoi=get_clm_sitedat(ncf1,iloc,jloc,'QSOIL');

ncf1=[mdir,chdir,'/','QVEGE','.',chdir,'.51-60.nc'];
qvege=get_clm_sitedat(ncf1,iloc,jloc,'QVEGE');

ncf1=[mdir,chdir,'/','QVEGT','.',chdir,'.51-60.nc'];
qvegt=get_clm_sitedat(ncf1,iloc,jloc,'QVEGT');

qet_hd=(qsoi+qvege+qvegt).*tdayssec;

plot(qet_hd,'b','LineWidth',linewidth);




chdir='clm45evapdef';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
qsoi=get_clm_sitedat(ncf1,iloc,jloc,'QSOIL');

ncf1=[mdir,chdir,'/','QVEGE','.',chdir,'.51-60.nc'];
qvege=get_clm_sitedat(ncf1,iloc,jloc,'QVEGE');

ncf1=[mdir,chdir,'/','QVEGT','.',chdir,'.51-60.nc'];
qvegt=get_clm_sitedat(ncf1,iloc,jloc,'QVEGT');

qet_def=(qsoi+qvege+qvegt).*tdayssec;

hold on;
plot(qet_def,'r-','LineWidth',linewidth);

chdir='clm45evapcosby4';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
qsoi=get_clm_sitedat(ncf1,iloc,jloc,'QSOIL');

ncf1=[mdir,chdir,'/','QVEGE','.',chdir,'.51-60.nc'];
qvege=get_clm_sitedat(ncf1,iloc,jloc,'QVEGE');

ncf1=[mdir,chdir,'/','QVEGT','.',chdir,'.51-60.nc'];
qvegt=get_clm_sitedat(ncf1,iloc,jloc,'QVEGT');

qet_cosby4=(qsoi+qvege+qvegt).*tdayssec;

%plot(qet_cosby4,'k');


chdir='clm45evapnoilhan';
ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
qsoi=get_clm_sitedat(ncf1,iloc,jloc,'QSOIL');

ncf1=[mdir,chdir,'/','QVEGE','.',chdir,'.51-60.nc'];
qvege=get_clm_sitedat(ncf1,iloc,jloc,'QVEGE');

ncf1=[mdir,chdir,'/','QVEGT','.',chdir,'.51-60.nc'];
qvegt=get_clm_sitedat(ncf1,iloc,jloc,'QVEGT');

qet_noilhan=(qsoi+qvege+qvegt).*tdayssec;

%plot(qet_noilhan,'g');


chdir='clm45evapdef_bs';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
qsoi_def=get_clm_sitedat(ncf1,iloc,jloc,'QSOIL').*tdayssec;
plot(qsoi_def,'k-','LineWidth',linewidth);

legend('CLM45-HD veg','CLM45 veg','CLM45-Bare soil');
xlabel('Cumulative time (month)','FontSize',fontsz);
ylabel('ET (mm H_2O day^-^1)','FontSize',fontsz);
set(gca,'FontSize',14);
return;
chdir='clm45evapcosby4_bs';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
qsoi_cosby4=get_clm_sitedat(ncf1,iloc,jloc,'QSOIL').*tdayssec;

plot(qsoi_cosby4,'g--');
chdir='clm45evapnoilhan_bs';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
qsoi_noilhan=get_clm_sitedat(ncf1,iloc,jloc,'QSOIL').*tdayssec;

plot(qsoi_noilhan,'k--');
