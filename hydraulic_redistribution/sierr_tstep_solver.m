close all;
clear all;
ncf1='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd1_1min/ET_hd1_1min_51-60.nc';
ncf2='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd1_10min/ET_hd1_10min_51-60.nc';
ncf3='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd1_30min/ET_hd1_30min_51-60.nc';
ncf4='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd_1min/ET_hd_1min_51-60.nc';
ncf5='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd_10min/ET_hd_10min_51-60.nc';
ncf6='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd_30min/ET_hd_30min_51-60.nc';

tdaysec=86400;
qsoil1=netcdf(ncf1,'var','QSOIL');
qvege1=netcdf(ncf1,'var','QVEGE');
qvegt1=netcdf(ncf1,'var','QVEGT');

ET1=qsoil1+qvege1+qvegt1;

qsoil2=netcdf(ncf2,'var','QSOIL');
qvege2=netcdf(ncf2,'var','QVEGE');
qvegt2=netcdf(ncf2,'var','QVEGT');

ET2=qsoil2+qvege2+qvegt2;


qsoil3=netcdf(ncf3,'var','QSOIL');
qvege3=netcdf(ncf3,'var','QVEGE');
qvegt3=netcdf(ncf3,'var','QVEGT');

ET3=qsoil3+qvege3+qvegt3;

qsoil4=netcdf(ncf4,'var','QSOIL');
qvege4=netcdf(ncf4,'var','QVEGE');
qvegt4=netcdf(ncf4,'var','QVEGT');

ET4=qsoil4+qvege4+qvegt4;

qsoil5=netcdf(ncf5,'var','QSOIL');
qvege5=netcdf(ncf5,'var','QVEGE');
qvegt5=netcdf(ncf5,'var','QVEGT');

ET5=qsoil5+qvege5+qvegt5;

qsoil6=netcdf(ncf6,'var','QSOIL');
qvege6=netcdf(ncf6,'var','QVEGE');
qvegt6=netcdf(ncf6,'var','QVEGT');

ET6=qsoil6+qvege6+qvegt6;

ET1=ET1.*tdaysec;
ET2=ET2.*tdaysec;
ET3=ET3.*tdaysec;
ET4=ET4.*tdaysec;
ET5=ET5.*tdaysec;
ET6=ET6.*tdaysec;


lwd=2;
fontsz=14;
mksize=8;
fig=figure(1);
set(fig,'unit','normalized','position',[0.05,0.14,0.9,0.75],'color','w');
ax=multipanel(fig,1,2,[0.12,0.12],[0.4,0.7],[0.05,0.1]);


green=[0,204,102]./256;
blue=[0,128,255]./256;
black=[96,96,96]./256;
set(fig,'CurrentAxes',ax(1));
h(1)=plot(ET1,ET2,'o','MarkerSize',mksize,'MarkerFaceColor',blue,...
    'MarkerEdgeColor',blue);
hold on;
h(2)=plot(ET1,ET3,'d','MarkerSize',mksize,'MarkerFaceColor',...
    green,'MarkerEdgeColor',green);
legend('CLM4.5RHR-SCI \Deltat=10 min vs. CLM4.5RHR-SCI \Deltat=1 min',...
    'CLM4.5RHR-SCI \Deltat=30 min vs. CLM4.5RHR-SCI \Deltat=1 min',...
    'Location','North');
legend boxoff;
xlabel('ET (mm day^-^1) from CLM4.5RHR-SCI with \Deltat=1 min','FontSize',fontsz);
ylabel('ET (mm day^-^1)','Fontsize',fontsz);
set(fig,'CurrentAxes',ax(2));
h1(1)=plot(ET6,ET4,'o','MarkerSize',mksize,'MarkerFaceColor',...
    blue,'MarkerEdgeColor',blue);
hold on;
h1(2)=plot(ET6,ET5,'rd','MarkerSize',mksize,'MarkerFaceColor',...
    green,'MarkerEdgeColor',green);
h1(3)=plot(ET6,ET1,'p','MarkerSize',mksize,'MarkerFaceColor',...
    black,'MarkerEdgeColor',black);
legend('CLM4.5RHR-TCI \Deltat=1 min vs. CLM4.5RHR-TCI \Deltat=30 min',...
    'CLM4.5RHR-TCI \Deltat=10 min vs. CLM4.5RHR-TCI \Deltat=30 min',...
    'CLM4.5RHR-SCI \Deltat=1 min vs. CLM4.5RHR-TCI \Deltat=30 min',...
    'Location','North');
legend boxoff;
xlabel('ET (mm day^-^1) from CLM4.5RHR-TCI with \Deltat=30 min',...
    'FontSize',fontsz);
ylabel('ET (mm day^-^1)','Fontsize',fontsz);
set(ax,'Xlim',[0,7],'Ylim',[0,7],'FontSize',fontsz);

put_tag(fig,ax(1),[0.95,0.05],'(a)',14);
put_tag(fig,ax(2),[0.95,0.05],'(b)',14);



