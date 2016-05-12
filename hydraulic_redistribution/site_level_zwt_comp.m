close all;
clear all;

%read data

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

ncf_ctl='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45evapdef/ZWT.clm45evapdef.51-60.nc';
ncf_hdr='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45hdr_maxlai_ref/ZWT.clm45hdr_maxlai_ref.51-60.nc';


varname='ZWT';

%site='sierra';

lonp=240;
latp=38.84211;

ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

zwt_ctl_ser_qan=get_clm_sitedat(ncf_ctl,iloc,jloc,varname);
zwt_hdr_ser_qan=get_clm_sitedat(ncf_hdr,iloc,jloc,varname);

%tapajos
lonp=305;
latp=-2.356021;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

zwt_ctl_tap_qan=get_clm_sitedat(ncf_ctl,iloc,jloc,varname);
zwt_hdr_tap_qan=get_clm_sitedat(ncf_hdr,iloc,jloc,varname);





ncf_ctl='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/cruclm45def/ZWT.cruclm45def.51-60.nc';

ncf_hdr='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/cruclm45hd_maxlai_ref/ZWT.cruclm45hd_maxlai_ref.51-60.nc';


%site='sierra';

lonp=240;
latp=38.84211;

ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

zwt_ctl_ser_cru=get_clm_sitedat(ncf_ctl,iloc,jloc,varname);
zwt_hdr_ser_cru=get_clm_sitedat(ncf_hdr,iloc,jloc,varname);

%tapajos
lonp=305;
latp=-2.356021;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

zwt_ctl_tap_cru=get_clm_sitedat(ncf_ctl,iloc,jloc,varname);
zwt_hdr_tap_cru=get_clm_sitedat(ncf_hdr,iloc,jloc,varname);







ncf_ctl='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45evapdef/TWS.clm45evapdef.51-60.nc';
ncf_hdr='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45hdr_maxlai_ref/TWS.clm45hdr_maxlai_ref.51-60.nc';


varname='TWS';



%site='sierra';

lonp=240;
latp=38.84211;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

tws_ctl_ser_qan=get_clm_sitedat(ncf_ctl,iloc,jloc,varname).*1d-3;
tws_hdr_ser_qan=get_clm_sitedat(ncf_hdr,iloc,jloc,varname).*1d-3;

%tapajos
lonp=305;
latp=-2.356021;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

tws_ctl_tap_qan=get_clm_sitedat(ncf_ctl,iloc,jloc,varname).*1d-3;
tws_hdr_tap_qan=get_clm_sitedat(ncf_hdr,iloc,jloc,varname).*1d-3;



ncf_ctl='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/cruclm45def/TWS.cruclm45def.51-60.nc';

ncf_hdr='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/cruclm45hd_maxlai_ref/TWS.cruclm45hd_maxlai_ref.51-60.nc';


%site='sierra';

lonp=240;
latp=38.84211;



[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

tws_ctl_ser_cru=get_clm_sitedat(ncf_ctl,iloc,jloc,varname).*1d-3;
tws_hdr_ser_cru=get_clm_sitedat(ncf_hdr,iloc,jloc,varname).*1d-3;

%tapajos
lonp=305;
latp=-2.356021;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

tws_ctl_tap_cru=get_clm_sitedat(ncf_ctl,iloc,jloc,varname).*1d-3;
tws_hdr_tap_cru=get_clm_sitedat(ncf_hdr,iloc,jloc,varname).*1d-3;

%%
%plot
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.8,.9]);
linw=2;
ax= multipanel(fig,2,2,[.1,.1],[.4,.4],[.05,.05]);

cc={'b','r','g','k'};
set(fig,'CurrentAxes',ax(1));

plot(zwt_ctl_ser_qan,'color',cc{1},'LineWidth',linw);
hold on;
plot(zwt_hdr_ser_qan,'color',cc{2},'LineWidth',linw);

plot(zwt_ctl_ser_cru,'color',cc{3},'LineWidth',linw);

plot(zwt_hdr_ser_cru,'color',cc{4},'LineWidth',linw);

ylabel('Water table depth (m)','FontSize',14);

set(fig,'CurrentAxes',ax(2));

plot(zwt_ctl_tap_qan,'color',cc{1},'LineWidth',linw);
hold on;
plot(zwt_hdr_tap_qan,'color',cc{2},'LineWidth',linw);
plot(zwt_ctl_tap_cru,'color',cc{3},'LineWidth',linw);
plot(zwt_hdr_tap_cru,'color',cc{4},'LineWidth',linw);

ylabel('Water table depth (m)','FontSize',14);


set(fig,'CurrentAxes',ax(3));

plot(anomaly_ts(tws_ctl_ser_qan),'color',cc{1},'LineWidth',linw);
hold on;
plot(anomaly_ts(tws_hdr_ser_qan),'color',cc{2},'LineWidth',linw);
plot(anomaly_ts(tws_ctl_ser_cru),'color',cc{3},'LineWidth',linw);
plot(anomaly_ts(tws_hdr_ser_cru),'color',cc{4},'LineWidth',linw);
ylabel('TWSA (m)','FontSize',14);
xlabel('Ordinal month','FontSize',14);
legend('CLM4.5','CLM4.5RHD-TCI','CLM4.5-CRU','CLM4.5RHD-TCI-CRU','location','northwest');
set(fig,'CurrentAxes',ax(4));

plot(anomaly_ts(tws_ctl_tap_qan),'color',cc{1},'LineWidth',linw);
hold on;
plot(anomaly_ts(tws_hdr_tap_qan),'color',cc{2},'LineWidth',linw);
plot(anomaly_ts(tws_ctl_tap_cru),'color',cc{3},'LineWidth',linw);
plot(anomaly_ts(tws_hdr_tap_cru),'color',cc{4},'LineWidth',linw);
ylabel('TWSA (m)','FontSize',14);
xlabel('Ordinal month','FontSize',14);
set(ax,'FontSize',14);
set(ax(3:4),'Ylim',[-2,6]);

put_tag(fig,ax(1),[.02,.05],'(a) Blodgett Forest: ZWT',14);
put_tag(fig,ax(2),[.02,.05],'(b) Tapajos Forest: ZWT',14);
put_tag(fig,ax(3),[.02,.05],'(c) Blodgett Forest: TWS',14);
put_tag(fig,ax(4),[.02,.05],'(d) Tapajos Forest: TWS',14);

set(ax(1:2),'XTickLabel','');
set(fig,'color','w');

%%
%plot precipitation at two sites
ncf_rain='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45evapdef/RAIN.clm45evapdef.51-60.nc';
ncf_snow='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/clm45evapdef/SNOW.clm45evapdef.51-60.nc';



varname1='RAIN';
varname2='SNOW';



%site='sierra';

lonp=240;
latp=38.84211;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

prec_ser_qan=(get_clm_sitedat(ncf_rain,iloc,jloc,varname1)+get_clm_sitedat(ncf_snow,iloc,jloc,varname2)).*86400;


%tapajos
lonp=305;
latp=-2.356021;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

prec_tap_qan=(get_clm_sitedat(ncf_rain,iloc,jloc,varname1)+get_clm_sitedat(ncf_snow,iloc,jloc,varname2)).*86400;

ncf_rain='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/cruclm45def/RAIN.cruclm45def.51-60.nc';
ncf_snow='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/cruclm45def/SNOW.cruclm45def.51-60.nc';

lonp=240;
latp=38.84211;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

prec_ser_cru=(get_clm_sitedat(ncf_rain,iloc,jloc,varname1)+get_clm_sitedat(ncf_snow,iloc,jloc,varname2)).*86400;


%tapajos
lonp=305;
latp=-2.356021;


[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);


prec_tap_cru=(get_clm_sitedat(ncf_rain,iloc,jloc,varname1)+get_clm_sitedat(ncf_snow,iloc,jloc,varname2)).*86400;


clear ax;
fig=figure(2);

set(fig,'unit','normalized','position',[.1,.1,.5,.8]);
ax= multipanel(fig,2,1,[.1,.1],[.8,.4],[.05,.05]);
set(fig,'CurrentAxes',ax(1));

plot(prec_ser_qan,'LineWidth',linw);
hold on;
plot(prec_ser_cru,'r','LineWidth',linw);
ylabel('Precipitation (mm/day)','FontSize',14);
set(ax(1),'XTickLabel','');
set(fig,'CurrentAxes',ax(2));
plot(prec_tap_qan,'LineWidth',linw);
hold on;
plot(prec_tap_cru,'r','LineWidth',linw);
ylabel('Precipitation (mm/day)','FontSize',14);
xlabel('Ordinal month','FontSize',14);
legend('QIAN','CRU');


set(ax,'FontSize',14);

put_tag(fig,ax(1),[.02,.85],'(a) Blodgett Forest',14);
put_tag(fig,ax(2),[.02,.85],'(b) Tapajos Forest',14);
set(fig,'color','w');