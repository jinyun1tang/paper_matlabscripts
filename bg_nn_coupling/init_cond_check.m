close all;
clear all;
clc;
    
mother_dir='/Volumes/data/1850-2000/init_cond';

init_files={'I1850-2000bgc.1.9x2.5.betr_clm.lr2.clm2.h0.1850-01.nc',... %CLM, MNL
    'I1850-2000bgc.1.9x2.5.betr_cent.lr2.clm2.h0.1850-01.nc',...        %CLM, NUL
    'I1850-2000bgc.1.9x2.5.betr_clm3.lr2.clm2.h0.1850-01.nc',...        %CLM3, PNL
    'I1850-2000bgc.1.9x2.5.betr_clmo.lr2.clm2.h0.1850-01.nc',...        %CLM3C, PNLIC
    'I1850-2000bgc.1.9x2.5.default.lr2.clm2.h0.1850-01.nc'};             %default


soilc_var_name='SOILC';


var_name=soilc_var_name;
j = 1;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat1=netcdf(ncf,'var',var_name);
id=~isnan(dat1);

lon=netcdf(ncf,'var','lon');
lat=netcdf(ncf,'var','lat');


j = 2;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat2=netcdf(ncf,'var',var_name);

j = 3;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat3=netcdf(ncf,'var',var_name);

j = 4;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat4=netcdf(ncf,'var',var_name);


j = 5;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat5=netcdf(ncf,'var',var_name);

fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.7,.9]);
ax=multipanel(fig,3,2,[.075,.1],[.4,.25],[.05,.055]);
set(ax(6),'position',[.6,.1,.3,.25]);
colormap('default');


set(fig,'CurrentAxes',ax(1));caxis([-8,4]);
[c,h]=contourf(lon,lat,log(dat1'));set(h,'color','none');
set(ax(1),'XTickLabel','');
ylabel('Latitude','FontSize',14);


set(fig,'CurrentAxes',ax(2));caxis([-8,4]);
[c,h]=contourf(lon,lat,log10(dat2'));set(h,'color','none');
set(ax(2),'XTickLabel','');
set(ax(2),'YTickLabel','');

set(fig,'CurrentAxes',ax(3));caxis([-8,4]);
[c,h]=contourf(lon,lat,log10(dat3'));set(h,'color','none');
set(ax(3),'XTickLabel','');
ylabel('Latitude','FontSize',14);


set(fig,'CurrentAxes',ax(4));caxis([-8,4]);
[c,h]=contourf(lon,lat,log10(dat4'));set(h,'color','none');
set(ax(4),'YTickLabel','');
xlabel('Longitude','FontSize',14);


set(fig,'CurrentAxes',ax(5));caxis([-8,4]);
[c,h]=contourf(lon,lat,log10(dat5'));set(h,'color','none');
h=colorbar;set(h, 'Position', [.5 .08 .035 .25]);
xlabel(h,'log10(g C m^-^2)','FontSize',14);
xlabel('Longitude','FontSize',14);
ylabel('Latitude','FontSize',14);

set(ax(1:5),'FontSize',14);

set(fig,'CurrentAxes',ax(6));
plot(dat1(id),dat3(id),'.');
hold on;
plot(dat2(id),dat3(id),'r.');
plot(dat4(id),dat3(id),'m.');
plot(dat5(id),dat3(id),'c.');
legend('MNL vs PNL','NUL vs PNL','PNLO vs PNL','Default vs PNL','location','SouthEast');
set(ax(6),'FontSize',14);
xlabel('Others');ylabel('PNL');


set(fig,'color','w');
put_tag(fig,ax(1),[.025,.05],'(a) MNL',14);
put_tag(fig,ax(2),[.025,.05],'(b) NUL',14);
put_tag(fig,ax(3),[.025,.05],'(c) PNL',14);
put_tag(fig,ax(4),[.025,.05],'(d) PNLO',14);
put_tag(fig,ax(5),[.025,.05],'(e) Default',14);
put_tag(fig,ax(6),[.025,.95],'(f) ',14);    


export_fig('fig_S1_SOILC.pdf')

%%
vegc_var_name='TOTVEGC';

var_name=vegc_var_name;

j = 1;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat1=netcdf(ncf,'var',var_name);
id=~isnan(dat1);

lon=netcdf(ncf,'var','lon');
lat=netcdf(ncf,'var','lat');


j = 2;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat2=netcdf(ncf,'var',var_name);

j = 3;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat3=netcdf(ncf,'var',var_name);

j = 4;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat4=netcdf(ncf,'var',var_name);


j = 5;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat5=netcdf(ncf,'var',var_name);

fig=figure(2);
set(fig,'unit','normalized','position',[.1,.1,.7,.9]);
ax=multipanel(fig,3,2,[.075,.1],[.4,.25],[.05,.055]);
set(ax(6),'position',[.6,.1,.3,.25]);
colormap('default');


set(fig,'CurrentAxes',ax(1));caxis([-8,4]);
[c,h]=contourf(lon,lat,log(dat1'));set(h,'color','none');
set(ax(1),'XTickLabel','');
ylabel('Latitude','FontSize',14);


set(fig,'CurrentAxes',ax(2));caxis([-8,4]);
[c,h]=contourf(lon,lat,log10(dat2'));set(h,'color','none');
set(ax(2),'XTickLabel','');
set(ax(2),'YTickLabel','');

set(fig,'CurrentAxes',ax(3));caxis([-8,4]);
[c,h]=contourf(lon,lat,log10(dat3'));set(h,'color','none');
set(ax(3),'XTickLabel','');
ylabel('Latitude','FontSize',14);


set(fig,'CurrentAxes',ax(4));caxis([-8,4]);
[c,h]=contourf(lon,lat,log10(dat4'));set(h,'color','none');
set(ax(4),'YTickLabel','');
xlabel('Longitude','FontSize',14);


set(fig,'CurrentAxes',ax(5));caxis([-8,4]);
[c,h]=contourf(lon,lat,log10(dat5'));set(h,'color','none');
h=colorbar;set(h, 'Position', [.5 .08 .035 .25]);
xlabel(h,'log10(g C m^-^2)','FontSize',14);
xlabel('Longitude','FontSize',14);
ylabel('Latitude','FontSize',14);

set(ax(1:5),'FontSize',14);


set(fig,'CurrentAxes',ax(6));
plot(dat1(id),dat3(id),'.');
hold on;
plot(dat2(id),dat3(id),'r.');
plot(dat4(id),dat3(id),'m.');
plot(dat5(id),dat3(id),'c.');
legend('MNL vs PNL','NUL vs PNL','PNLO vs PNL','Default vs PNL','location','SouthEast');
set(ax(6),'FontSize',14);
xlabel('Others');ylabel('PNL');

set(fig,'color','w');
put_tag(fig,ax(1),[.025,.05],'(a) MNL',14);
put_tag(fig,ax(2),[.025,.05],'(b) NUL',14);
put_tag(fig,ax(3),[.025,.05],'(c) PNL',14);
put_tag(fig,ax(4),[.025,.05],'(d) PNLO',14);
put_tag(fig,ax(5),[.025,.05],'(e) Default',14);
put_tag(fig,ax(6),[.025,.95],'(f) ',14); 


export_fig('fig_S2_VEGC.pdf')

%%
vegn_var_name='TOTVEGN';

var_name=vegn_var_name;

j = 1;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat1=netcdf(ncf,'var',var_name);
id=~isnan(dat1);

lon=netcdf(ncf,'var','lon');
lat=netcdf(ncf,'var','lat');


j = 2;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat2=netcdf(ncf,'var',var_name);

j = 3;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat3=netcdf(ncf,'var',var_name);

j = 4;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat4=netcdf(ncf,'var',var_name);


j = 5;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat5=netcdf(ncf,'var',var_name);

fig=figure(3);
set(fig,'unit','normalized','position',[.1,.1,.7,.9]);
ax=multipanel(fig,3,2,[.075,.1],[.4,.25],[.05,.055]);
set(ax(6),'position',[.6,.1,.3,.25]);
colormap('default');


set(fig,'CurrentAxes',ax(1));caxis([-8,3]);
[c,h]=contourf(lon,lat,log(dat1'));set(h,'color','none');
set(ax(1),'XTickLabel','');
ylabel('Latitude','FontSize',14);


set(fig,'CurrentAxes',ax(2));caxis([-8,3]);
[c,h]=contourf(lon,lat,log10(dat2'));set(h,'color','none');
set(ax(2),'XTickLabel','');
set(ax(2),'YTickLabel','');

set(fig,'CurrentAxes',ax(3));caxis([-8,3]);
[c,h]=contourf(lon,lat,log10(dat3'));set(h,'color','none');
set(ax(3),'XTickLabel','');
ylabel('Latitude','FontSize',14);


set(fig,'CurrentAxes',ax(4));caxis([-8,3]);
[c,h]=contourf(lon,lat,log10(dat4'));set(h,'color','none');
set(ax(4),'YTickLabel','');
xlabel('Longitude','FontSize',14);


set(fig,'CurrentAxes',ax(5));caxis([-8,3]);
[c,h]=contourf(lon,lat,log10(dat5'));set(h,'color','none');
h=colorbar;set(h, 'Position', [.5 .08 .035 .25]);
xlabel(h,'log10(g N m^-^2)','FontSize',14);
xlabel('Longitude','FontSize',14);
ylabel('Latitude','FontSize',14);

set(ax(1:5),'FontSize',14);


set(fig,'CurrentAxes',ax(6));
plot(dat1(id),dat3(id),'.');
hold on;
plot(dat2(id),dat3(id),'r.');
plot(dat4(id),dat3(id),'m.');
plot(dat5(id),dat3(id),'c.');
legend('MNL vs PNL','NUL vs PNL','PNLO vs PNL','Default vs PNL','location','SouthEast');
set(ax(6),'FontSize',14);
xlabel('Others');ylabel('PNL');

set(fig,'color','w');
put_tag(fig,ax(1),[.025,.05],'(a) MNL',14);
put_tag(fig,ax(2),[.025,.05],'(b) NUL',14);
put_tag(fig,ax(3),[.025,.05],'(c) PNL',14);
put_tag(fig,ax(4),[.025,.05],'(d) PNLO',14);
put_tag(fig,ax(5),[.025,.05],'(e) Default',14);
put_tag(fig,ax(6),[.025,.95],'(f) ',14); 


export_fig('fig_S3_VEGN.pdf')


%%
sminn_var_name='SMINN';

var_name=sminn_var_name;

j = 1;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat1=netcdf(ncf,'var',var_name);
id=~isnan(dat1);

lon=netcdf(ncf,'var','lon');
lat=netcdf(ncf,'var','lat');


j = 2;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat2=netcdf(ncf,'var',var_name);

j = 3;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat3=netcdf(ncf,'var',var_name);

j = 4;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat4=netcdf(ncf,'var',var_name);


j = 5;
ncf=sprintf('%s/%s',mother_dir,init_files{j});
dat5=netcdf(ncf,'var',var_name);

fig=figure(4);
set(fig,'unit','normalized','position',[.1,.1,.7,.9]);
ax=multipanel(fig,3,2,[.075,.1],[.4,.25],[.05,.055]);
set(ax(6),'position',[.6,.1,.3,.25]);

colormap('default');

set(fig,'CurrentAxes',ax(1));caxis([-5,2]);
[c,h]=contourf(lon,lat,log(dat1'));set(h,'color','none');
set(ax(1),'XTickLabel','');
ylabel('Latitude','FontSize',14);


set(fig,'CurrentAxes',ax(2));caxis([-5,2]);
[c,h]=contourf(lon,lat,log10(dat2'));set(h,'color','none');
set(ax(2),'XTickLabel','');
set(ax(2),'YTickLabel','');

set(fig,'CurrentAxes',ax(3));caxis([-5,2]);
[c,h]=contourf(lon,lat,log10(dat3'));set(h,'color','none');
set(ax(3),'XTickLabel','');
ylabel('Latitude','FontSize',14);


set(fig,'CurrentAxes',ax(4));caxis([-5,2]);
[c,h]=contourf(lon,lat,log10(dat4'));set(h,'color','none');
set(ax(4),'YTickLabel','');
xlabel('Longitude','FontSize',14);


set(fig,'CurrentAxes',ax(5));caxis([-5,2]);
[c,h]=contourf(lon,lat,log10(dat5'));set(h,'color','none');
h=colorbar;set(h, 'Position', [.5 .08 .035 .25]);
xlabel(h,'log10(g N m^-^2)','FontSize',14);
xlabel('Longitude','FontSize',14);
ylabel('Latitude','FontSize',14);

set(ax(1:5),'FontSize',14);


set(fig,'CurrentAxes',ax(6));
plot(dat1(id),dat3(id),'.');
hold on;
plot(dat2(id),dat3(id),'r.');
plot(dat4(id),dat3(id),'m.');
plot(dat5(id),dat3(id),'c.');
legend('MNL vs PNL','NUL vs PNL','PNLO vs PNL','Default vs PNL','location','SouthEast');
set(ax(6),'FontSize',14);
xlabel('Others');ylabel('PNL');

set(fig,'color','w');
put_tag(fig,ax(1),[.025,.05],'(a) MNL',14);
put_tag(fig,ax(2),[.025,.05],'(b) NUL',14);
put_tag(fig,ax(3),[.025,.05],'(c) PNL',14);
put_tag(fig,ax(4),[.025,.05],'(d) PNLO',14);
put_tag(fig,ax(5),[.025,.05],'(e) Default',14);
put_tag(fig,ax(6),[.025,.95],'(f) ',14); 


export_fig('fig_S4_SMINN.pdf')

