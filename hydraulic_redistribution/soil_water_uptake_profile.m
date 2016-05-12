close all;
clear all;
clc;
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
varname='QVEGT_DEP';
fontsz=14;
%amazon somewhere
lonp=297.5;
latp=-2.842105;
site='sierra';
%site='tapajos';
if(strcmp(site,'sierra'))
    lonp=240;
    latp=38.84211;
    load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/Blodgett_Forest.mat');
elseif(strcmp(site,'tapajos'))
%tapajos
    lonp=305;
    latp=-2.356021;
    load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/LBA_Tapajos_KM67_Mature_Forest.mat');
end
ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

w=[31,28,31,30,31,30,31,31,30,31,30,31]./365;
window=12;
chdir='clm45evaphdr_ref';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
eflx_hd=get_clm_sitedat(ncf1,iloc,jloc,varname);


chdir='clm45evapdef';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
eflx_nhd=get_clm_sitedat(ncf1,iloc,jloc,varname);

%do the comparison
eflx_hd=eflx_hd.*dayseconds();

eflx_nhd=eflx_nhd.*dayseconds();

depz=getclmz(10);
len=120;
id1=(73:84);
fig=figure(1);
ax=multipanel(fig,2,1,[0.12,0.1],[0.8,0.35],[0.05,.075]);
set(fig,'CurrentAxes',ax(1));
[c,h]=contourf((1:length(id1)),depz,eflx_hd(1:10,id1),(-1:.1:1));set(h,'color','none');colorbar;
ylabel('Depth (m)','FontSize',fontsz);
set(fig,'CurrentAxes',ax(2));
[c,h]=contourf((1:length(id1)),depz,eflx_nhd(1:10,id1),(0:.01:.25));set(h,'color','none');colorbar;
xlabel('Month','FontSize',fontsz);
ylabel('Depth (m)','FontSize',fontsz);
set(ax(1),'XTickLabel','');
set(ax,'FontSize',fontsz);
put_tag(fig,ax(1),[0.1,0.9],'(a)CLM45-HD',fontsz);
put_tag(fig,ax(2),[0.1,0.9],'(b)CLM45',fontsz);
put_tag(fig,ax(1),[0.1,1.1],'mm H_2O day^-^1',fontsz);

figure;
plot(sum(eflx_hd(1:10,id1),1));
hold on;
plot(sum(eflx_nhd(1:10,id1),1),'r');



