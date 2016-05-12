close all;
clear all;
clc;


mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

varname='H2OSOI';
var_et='EFLX_LH_TOT';

chdir='clm45evapdef';
ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];

ncf_rain=[mdir,chdir,'/','RAIN','.',chdir,'.51-60.nc'];

ncf_snow=[mdir,chdir,'/','SNOW','.',chdir,'.51-60.nc'];

chdir='clm45hdr_maxlai_ref';
ncf2=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];

ncf4=[mdir,chdir,'/',var_et,'.',chdir,'.51-60.nc'];

chdir='clm45evaphdr_seq_maxlai';
ncf3=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];

ncf5=[mdir,chdir,'/',var_et,'.',chdir,'.51-60.nc'];

sierra=0;
%sierra    
if(sierra==1)
lonp=240;
latp=38.84211;
vv=(-0.25:0.01:0.25);
cax=[-0.1,0.1];
ttl='Blodgett Forest';
else
%tapajos
lonp=305;
latp=-2.356021;
vv=(-0.045:0.01:0.1);
cax=[-0.1,0.1];
ttl='Tapajos Forest';
end
ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);


h2osoi_ref=get_clm_sitedat(ncf1,iloc,jloc,varname);
h2osoi_cm=get_clm_sitedat(ncf2,iloc,jloc,varname);

h2osoi_sm=get_clm_sitedat(ncf3,iloc,jloc,varname);

et_cm=get_clm_sitedat(ncf4,iloc,jloc,var_et);

et_sm=get_clm_sitedat(ncf5,iloc,jloc,var_et);

daz=[31,28,31,30,31,30,31,31,30,31,30,31];
rain=get_clm_sitedat(ncf_rain,iloc,jloc,'RAIN');
snow=get_clm_sitedat(ncf_snow,iloc,jloc,'SNOW');
prec=(rain+snow).*86400.*repmat(daz,[1,10])';

fontsz=14;

watsat=[0.5033095,0.4678569,0.4454694,0.4358359,0.433149,0.4281748,...
    0.4295546,0.4252839,0.42348,0.42852,0.42852,0.42852,0.42852,...
  0.42852,0.42852 ;];


h2osoi11=h2osoi_ref(1:10,:);%./repmat(watsat(1:10)',[1,120]);
h2osoi21=h2osoi_cm(1:10,:);%./repmat(watsat(1:10)',[1,120]);
h2osoi31=h2osoi_sm(1:10,:);

depz=getclmz(10);
id=(1:120);
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.6,.8]);
ax=multipanel(fig,3,1,[.1,.1],[.75,.275],[.05,.0]);

set(fig,'CurrentAxes',ax(1));
xx=(1:length(id));
[hAx,hL1,hL2]=plotyy(xx,prec(id),[xx',xx'],[et_cm(id),et_sm(id)]);


ylabel(hAx(1),'Precipitation (mm)','FontSize',fontsz);

ylabel(hAx(2),'Latent heat (W m^-^2)','FontSize',fontsz);


set(hL1,'LineWidth',2);
set(hL2,'LineWidth',2);
set(hAx,'XTickLabel','','FontSize',fontsz);
if(sierra)
    set(hAx(1),'YLim',[0,250],'YTick',(0:50:250));
    set(hAx(2),'YLim',[0,250],'YTick',(0:50:250));
else
    set(hAx(1),'YLim',[0,400],'YTick',(0:100:400));
    set(hAx(2),'YLim',[0,160],'YTick',(0:40:160));    
end
legend('QIAN Prec','CLM4.5RHR-TCI','CLM4.5RHR-SCI');
title(ttl);
set(fig,'CurrentAxes',ax(2));
[c,h]=contourf((1:length(id)),depz,(h2osoi21(:,id)-h2osoi11(:,id)),vv);set(h,'color','none');%colorbar;
ylabel('Depth (m)','FontSize',fontsz);

%caxis([-0.2,0.2]);
caxis(cax);
set(fig,'CurrentAxes',ax(3));
[c,h]=contourf((1:length(id)),depz,(h2osoi31(:,id)-h2osoi11(:,id)),vv);set(h,'color','none');

pos=get(ax(3),'pos');

colorbar('location','eastoutside','position',[pos(1)+1.05*pos(3) pos(2)+pos(4)*0.5 0.03 pos(4)]);

%caxis([-0.2,0.2]);
caxis(cax);
xlabel('Month','FontSize',fontsz);
ylabel('Depth (m)','FontSize',fontsz);
set(ax,'FontSize',fontsz,'XLim',[0,121]);
set(ax(1:2),'XTickLabel','');
put_tag(fig,ax(1),[.05,.9],'(a)',fontsz);
put_tag(fig,ax(2),[.05,.9],'(b) CLM4.5RHR-TCI',fontsz);
put_tag(fig,ax(3),[.05,.9],'(c) CLM4.5RHR-SCI',fontsz);
put_tag(fig,ax(3),[1.05,0.4],'(v/v)',fontsz);

set(fig,'color','w');
figure;
plot(h2osoi11(1,:));
hold on;
plot(h2osoi21(1,:),'k');
plot(h2osoi31(1,:),'r');


