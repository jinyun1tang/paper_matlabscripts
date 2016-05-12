close all;
clear all;
clc;
%analyze simulation for the sierra site
mdir='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/amazon/';


ncf{1}='1x1_pt_amazon_ch_bare_soi.clm2.h0.0031-01-01-00000.nc';
ncf{2}='1x1_pt_amazon_chbet_bare_soi.clm2.h0.0031-01-01-00000.nc';
ncf{3}='1x1_pt_amazon_chbet_bare_soi_lit.clm2.h0.0031-01-01-00000.nc';
ncf{4}='1x1_pt_amazon_chbet_bare_soi_100s.clm2.h0.0031-01-01-00000.nc';
ncf{5}='1x1_pt_amazon_ch.clm2.h0.0031-01-01-00000.nc';
ncf{6}='1x1_pt_amazon_chbet.clm2.h0.0031-01-01-00000.nc';
ncf{7}='1x1_pt_amazon_chbet_10s.clm2.h0.0031-01-01-00000.nc';
nf=7;
for j = 1 : nf
    ncf{j}=strcat(mdir,ncf{j});
end

%read et data
for j = 1 : nf
    qsoi=netcdf(ncf{j},'var','QSOIL');
    qvege=netcdf(ncf{j},'var','QVEGE');
    qvegt=netcdf(ncf{j},'var','QVEGT');
    qtot(j,:)=qsoi+qvege+qvegt;
end
mqtot=agg_day2mon(qtot,2);
%do year average
mqtot2=zeros(nf,12);
len=size(mqtot,2)/12;
for j = 1 : nf
    dat=reshape(mqtot(j,:),[12,len]);
    mqtot2(j,:)=mean(dat,2);
end
mqtot2=mqtot2.*86400;
fig=figure(3);
set(fig,'unit','normalized','position',[0.1,0.14,0.5,0.7]);
ax=multipanel(fig,2,1,[0.1,0.09],[0.8,0.4],[0.06,0.09]);
set(fig,'CurrentAxes',ax(1));
plot(mqtot2(1,:),'b-d','LineWidth',2);
hold on;
plot(mqtot2(2,:),'r-d','LineWidth',2);
plot(mqtot2(3,:),'g-d','LineWidth',2);
plot(mqtot2(4,:),'c:d','LineWidth',2);
plot(mqtot2(5,:),'y-d','LineWidth',2);
plot(mqtot2(6,:),'k-d','LineWidth',2);
plot(mqtot2(7,:),'k:d','LineWidth',2);

%legend('Bare soil: CLM4 Default','Bare soil: CLM4 New','Veg: CLM4 Default','Veg: CLM4 New');
%
xlim([1,12]);
ylim([2,5.5]);
xlabel('Month','FontSize',14);
set(ax(1),'FontSize',12,'XTick',(1:12),...
    'XTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
ylabel('ET (mm day^-^1)','FontSize',14);
len=size(qtot,2)/365;
yqtot=zeros(6,len);
for j = 1 : nf
    dat=reshape(qtot(j,:),[365,len]);
    yqtot(j,:)=mean(dat);
end
yqtot=yqtot.*86400;
set(fig,'CurrentAxes',ax(2));
plot(yqtot(1,:),'b-d','LineWidth',2);
hold on;
plot(yqtot(2,:),'r-d','LineWidth',2);
plot(yqtot(3,:),'g-d','LineWidth',2);
plot(yqtot(4,:),'c:d','LineWidth',2);
plot(yqtot(5,:),'y-d','LineWidth',2);
plot(yqtot(6,:),'k-d','LineWidth',2);
plot(yqtot(7,:),'k:d','LineWidth',2);

ylim([0,5.5]);
legend('Bare soil: CLM4 Default','Bare soil: CLM4 New','Bare soil: CLM4 Newlit',...
    'Bare soil: CLM4 New-10s','Veg: CLM4 Default','Veg: CLM4 New','Veg: CLM4 New-10s','location','southwest');
xlabel('Year','FontSize',14);
ylabel('ET (mm day^-^1)','FontSize',14);
set(ax(2),'FontSize',12);
put_tag(fig,ax(1),[0.05,0.93],'(a)',14);
put_tag(fig,ax(2),[0.05,0.93],'(b)',14);


data=netcdf(ncf{1},'var','H2OSOI');h2osoi(1,:)=data(1,:);
data=netcdf(ncf{2},'var','H2OSOI');h2osoi(2,:)=data(2,:);
data=netcdf(ncf{3},'var','H2OSOI');h2osoi(3,:)=data(3,:);
data=netcdf(ncf{4},'var','H2OSOI');h2osoi(4,:)=data(4,:);

h2osoi_m=agg_day2mon(h2osoi,2);


%do year average
h2osoi_m2=zeros(4,12);
len=size(h2osoi_m,2)/12;
for j = 1 : 4
    dat=reshape(h2osoi_m(j,:),[12,len]);
    h2osoi_m2(j,:)=mean(dat,2);
end
figure;
plot(h2osoi_m2(1,:),'b-d','LineWidth',2);
hold on;
plot(h2osoi_m2(2,:),'r-d','LineWidth',2);
plot(h2osoi_m2(3,:),'g-d','LineWidth',2);
plot(h2osoi_m2(4,:),'k-d','LineWidth',2);
xlim([1,12]);
xlabel('Month','FontSize',14);
set(gca,'FontSize',12,'XTick',(1:12),...
    'XTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
ylabel('Soil moisture (v/v)','FontSize',14);
legend('Bare soil: CLM4 Default','Bare soil: CLM4 New','Veg: CLM4 Default','Veg: CLM4 New','location','southwest');
