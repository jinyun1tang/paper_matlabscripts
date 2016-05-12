close all;
clear all;
clc;
%analyze simulation for the sierra site
mdir='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/sierra/';

ncf{1}='1x1_pt_sierra_bare_soi_br_ch.clm2.h0.0031-01-02-00000.nc';
ncf{2}='1x1_pt_sierra_bare_soi_br_ch_beta.clm2.h0.0031-01-02-00000.nc';
ncf{3}='1x1_pt_sierra_bare_soi_br_chbet.clm2.h0.0031-01-02-00000.nc';
ncf{4}='1x1_pt_sierra_bare_soi_br_chbet_beta.clm2.h0.0031-01-02-00000.nc';
ncf{5}='1x1_pt_sierra_ch_br_ch.clm2.h0.0031-01-02-00000.nc';
ncf{6}='1x1_pt_sierra_ch_br_ch_beta.clm2.h0.0031-01-02-00000.nc';
ncf{7}='1x1_pt_sierra_ch_br_chbet.clm2.h0.0031-01-02-00000.nc';
ncf{8}='1x1_pt_sierra_ch_br_chbet_beta.clm2.h0.0031-01-02-00000.nc';

ncf{1}='1x1_pt_sierra_bare_soi.clm2.h0.0031-01-01-00000.nc';
ncf{2}='1x1_pt_sierra_bare_soi_chbet.clm2.h0.0031-01-01-00000.nc';
ncf{3}='1x1_pt_sierra_ch.clm2.h0.0031-01-01-00000.nc';
ncf{4}='1x1_pt_sierra_chbet.clm2.h0.0031-01-01-00000.nc';
for j = 1 : 4
    ncf{j}=strcat(mdir,ncf{j});
end

%read et data
for j = 1 : 4
    qsoi=netcdf(ncf{j},'var','QSOIL');
    qvege=netcdf(ncf{j},'var','QVEGE');
    qvegt=netcdf(ncf{j},'var','QVEGT');
    qtot(j,:)=qsoi+qvege+qvegt;
end
mqtot=agg_day2mon(qtot,2);
%do year average
mqtot2=zeros(4,12);
len=size(mqtot,2)/12;
for j = 1 : 4
    dat=reshape(mqtot(j,:),[12,len]);
    mqtot2(j,:)=mean(dat,2);
end
mqtot2=mqtot2.*86400;
fig=figure(1);
set(fig,'unit','normalized','position',[0.1,0.14,0.5,0.7]);
ax=multipanel(fig,2,1,[0.1,0.09],[0.8,0.4],[0.06,0.09]);
set(fig,'CurrentAxes',ax(1));
plot(mqtot2(1,:),'b-d','LineWidth',2);
hold on;
plot(mqtot2(2,:),'r-d','LineWidth',2);
plot(mqtot2(3,:),'g-d','LineWidth',2);
plot(mqtot2(4,:),'k-d','LineWidth',2);
%legend('Bare soil: CLM4 Default','Bare soil: CLM4 New','Veg: CLM4 Default','Veg: CLM4 New');
%
xlim([1,12]);
xlabel('Month','FontSize',14);
set(ax(1),'FontSize',12,'XTick',(1:12),...
    'XTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
ylabel('mm day^-^1','FontSize',14);
len=size(qtot,2)/365;
yqtot=zeros(4,len);
for j = 1 : 4
    dat=reshape(qtot(j,:),[365,len]);
    yqtot(j,:)=mean(dat);
end
yqtot=yqtot.*86400;
set(fig,'CurrentAxes',ax(2));
plot(yqtot(1,:),'b-d','LineWidth',2);
hold on;
plot(yqtot(2,:),'r-d','LineWidth',2);
plot(yqtot(3,:),'g-d','LineWidth',2);
plot(yqtot(4,:),'k-d','LineWidth',2);
legend('Bare soil: CLM4 Default','Bare soil: CLM4 New','Veg: CLM4 Default','Veg: CLM4 New','location','southwest');
xlabel('Year','FontSize',14);
ylabel('mm day^-^1','FontSize',14);
set(ax(2),'FontSize',12);
put_tag(fig,ax(1),[0.05,0.9],'(a)',14);
put_tag(fig,ax(2),[0.05,0.9],'(b)',14);
