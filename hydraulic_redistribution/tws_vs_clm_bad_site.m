close all;
clear all;
clc;



load('crudef_tws.mat');
dat_def=dat_g;

load('clm45hdr_maxlai_ref.mat');

dat_hdr=dat_g;
clear dat_g;

load('grace.mat');

%site level comparison
id=(2003-2000)*12+(1:72);
%site='sierra';

lonp=100;
latp=35;

[iloc,jloc]=find_siteloc(lon_g,lat_g,lonp,latp);
tws_ser_def=squeeze(dat_def(jloc,iloc,:)).*1d-3;
tws_ser_hdr=squeeze(dat_hdr(jloc,iloc,:)).*1d-3;
tws_ser_grace=squeeze(lwe_thickness(iloc,jloc,:)).*scalf(iloc,jloc).*1d-2;

err_ser_grace=tot_err(iloc,jloc).*1d-2;

%tapajos
lonp=24;
latp=22;
[iloc,jloc]=find_siteloc(lon_g,lat_g,lonp,latp);
tws_tap_def=squeeze(dat_def(jloc,iloc,:)).*1d-3;
tws_tap_hdr=squeeze(dat_hdr(jloc,iloc,:)).*1d-3;
tws_tap_grace=squeeze(lwe_thickness(iloc,jloc,:)).*scalf(iloc,jloc).*1d-2;
err_tap_grace=tot_err(iloc,jloc).*1d-2;
%plot out the time series
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.7,.8]);
ax= multipanel(fig,2,1,[.1,.1],[.8,.4],[.05,.05]);
linw=2;
set(fig,'CurrentAxes',ax(1));
yr=(1:120)./12+2001;

%define the anomaly
tws_ser_def=tws_ser_def-mean(tws_ser_def(id));
tws_ser_hdr=tws_ser_hdr-mean(tws_ser_hdr(id));
tws_tap_def=tws_tap_def-mean(tws_tap_def(id));
tws_tap_hdr=tws_tap_hdr-mean(tws_tap_hdr(id));
hdl=zeros(3,1);
hh=shadedErrorBar(target_mon+2002,tws_ser_grace,err_ser_grace.*ones(size(target_mon)),'k',1);
set(hh.mainLine,'LineWidth',linw);
hdl(1)=hh.mainLine;
hold on;
hdl(2)=plot(yr,tws_ser_def,'linewidth',linw);
hdl(3)=plot(yr,tws_ser_hdr,'r','linewidth',linw);


ylabel('TWSA (m)','FontSize',14);
set(ax(1),'XTickLabel','');

legend(hdl,'GRACE','CLM4.5-CRU','CLM4.5RHD-TCI-CRU');
ylim([-0.2-eps,0.2+eps]);
title('Example locations where including RHR degraded TWSA prediction','FontSize',14);
set(fig,'CurrentAxes',ax(2));

hh=shadedErrorBar(target_mon+2002,tws_tap_grace,err_tap_grace.*ones(size(target_mon)),'k',1);
set(hh.mainLine,'LineWidth',linw);
hold on;
plot(yr,tws_tap_def,'linewidth',linw);
plot(yr,tws_tap_hdr,'r','linewidth',linw);

ylabel('TWSA (m)','FontSize',14);
xlabel('Year','FontSize',14);

set(ax,'FontSize',14,'Xlim',[2001-eps,2011+eps]);
put_tag(fig,ax(1),[.02,.85],'(a) Midwest China (Lat: 35\circ, Lon: 100\circ)',14);
put_tag(fig,ax(2),[.02,.85],'(b) Sahara desert (Lat: 22\circ, Lon: 24\circ)',14);
set(fig,'color','w');

%doing statistics
%sierra
id1=find(target_mon+2002<2011);
%interp to measurement temporal grid
tws_ser_def_int=interp1(yr,tws_ser_def,target_mon(id1)+2002);
tws_ser_hdr_int=interp1(yr,tws_ser_hdr,target_mon(id1)+2002);

tws_tap_def_int=interp1(yr,tws_tap_def,target_mon(id1)+2002);
tws_tap_hdr_int=interp1(yr,tws_tap_hdr,target_mon(id1)+2002);

w_def=linearfit(tws_ser_def_int,tws_ser_grace(id1));
w_hdr=linearfit(tws_ser_hdr_int,tws_ser_grace(id1));

fprintf('sierra\n');
fprintf('def:obs=%f*model+%f,rms=%f,r2=%f,p=%f,cor=%f\n',w_def(1),w_def(3),w_def(5),w_def(6),w_def(7),w_def(8));
fprintf('hdr:obs=%f*model+%f,rms=%f,r2=%f,p=%f,cor=%f\n',w_hdr(1),w_hdr(3),w_hdr(5),w_hdr(6),w_hdr(7),w_hdr(8));
w_def=linearfit(tws_tap_def_int,tws_tap_grace(id1));
w_hdr=linearfit(tws_tap_hdr_int,tws_tap_grace(id1));

fprintf('tapajos\n');
fprintf('def:obs=%f*model+%f,rms=%f,r2=%f,p=%f,cor=%f\n',w_def(1),w_def(3),w_def(5),w_def(6),w_def(7),w_def(8));
fprintf('hdr:obs=%f*model+%f,rms=%f,r2=%f,p=%f,cor=%f\n',w_hdr(1),w_hdr(3),w_hdr(5),w_hdr(6),w_hdr(7),w_hdr(8));


