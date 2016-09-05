close all;
clear all;
clc;



mother_dir='/Users/jinyuntang/work/data_collection/clm_output/bg_nn_coupling/RCP45';

child_dirs={'betr_clm_derive',...    %CLM,  MNL
'betr_cent_derive',...               %CENT, NUL
'betr_clm3_derive',...               %CLM3, PNL
'betr_clm3_cent_derive',...          %CLM3C,PNLIC
'betr_clmo_derive'};                 %CMLO, PNLO};

stem1='nee.RCP45.2001-2300.nc';
stem2='totcolc.RCP45.2001-2300.nc';


clr={'b','g','r','c','k'};

var_nee='NEE';
var_colc='TOTCOLC';


area=netcdf('area_rcp.nc','var','area');

lon=netcdf('area_rcp.nc','var','lon');

lat=netcdf('area_rcp.nc','var','lat');

area_sum_m2_glb=get_area_sum(area);
   
tdays=get_tdays(2001, 2300);    

tsecs=tdays.*86400;

tropid=(lat > -23.2) & (lat <= 23.2);
arcid= (lat > 66.0 );
tempid=(lat > 23.2) & (lat <= 66.0);


t23south=lat<=-23.2;
t23north=lat>-23.2;


areatrop=area;areatrop(:,~tropid)=0./0.;

areatemp=area;areatemp(:,~tempid)=0./0.;

areaarc=area;areaarc(:,~arcid)=0./0.;

areat23south=area;areat23south(:,~t23south)=0./0.;
areat23north=area;areat23north(:,~t23north)=0./0.;

area_sum_m2_trop=get_area_sum(areatrop);
area_sum_m2_temp=get_area_sum(areatemp);
area_sum_m2_arc=get_area_sum(areaarc);
area_sum_m2_23south=get_area_sum(areat23south);
area_sum_m2_23north=get_area_sum(areat23north);


g2Pg=1d-15;

j=1;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf,'var',var_nee);
nee_glb_ts_mnl=flux_area_avg(data,area).*tsecs.*area_sum_m2_glb.*g2Pg;

nee_arc_ts_mnl=flux_area_avg(data,areaarc).*tsecs.*area_sum_m2_arc.*g2Pg;

nee_temp_ts_mnl=flux_area_avg(data,areatemp).*tsecs.*area_sum_m2_temp.*g2Pg;

nee_trop_ts_mnl=flux_area_avg(data,areatrop).*tsecs.*area_sum_m2_trop.*g2Pg;

nee_t23south_ts_mnl=flux_area_avg(data,areat23south).*tsecs.*area_sum_m2_23south.*g2Pg;

nee_t23north_ts_mnl=flux_area_avg(data,areat23north).*tsecs.*area_sum_m2_23north.*g2Pg;


ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf,'var',var_colc);
colc_glb_ts_mnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_mnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_mnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_mnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_mnl=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_mnl=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;


j=2;
ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf1,'var',var_nee);
nee_glb_ts_nul=flux_area_avg(data,area).*tsecs.*area_sum_m2_glb.*g2Pg;

nee_arc_ts_nul=flux_area_avg(data,areaarc).*tsecs.*area_sum_m2_arc.*g2Pg;

nee_temp_ts_nul=flux_area_avg(data,areatemp).*tsecs.*area_sum_m2_temp.*g2Pg;

nee_trop_ts_nul=flux_area_avg(data,areatrop).*tsecs.*area_sum_m2_trop.*g2Pg;

nee_t23south_ts_nul=flux_area_avg(data,areat23south).*tsecs.*area_sum_m2_23south.*g2Pg;

nee_t23north_ts_nul=flux_area_avg(data,areat23north).*tsecs.*area_sum_m2_23north.*g2Pg;


ncf2=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf2,'var',var_colc);
colc_glb_ts_nul=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_nul=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_nul=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_nul=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_nul=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_nul=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

j=3;
ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf1,'var',var_nee);
nee_glb_ts_pnl=flux_area_avg(data,area).*tsecs.*area_sum_m2_glb.*g2Pg;

nee_arc_ts_pnl=flux_area_avg(data,areaarc).*tsecs.*area_sum_m2_arc.*g2Pg;

nee_temp_ts_pnl=flux_area_avg(data,areatemp).*tsecs.*area_sum_m2_temp.*g2Pg;

nee_trop_ts_pnl=flux_area_avg(data,areatrop).*tsecs.*area_sum_m2_trop.*g2Pg;

nee_t23south_ts_pnl=flux_area_avg(data,areat23south).*tsecs.*area_sum_m2_23south.*g2Pg;

nee_t23north_ts_pnl=flux_area_avg(data,areat23north).*tsecs.*area_sum_m2_23north.*g2Pg;


ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf1,'var',var_colc);
colc_glb_ts_pnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_pnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_pnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_pnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_pnl=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_pnl=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;


j=4;
ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf1,'var',var_nee);
nee_glb_ts_pnlic=flux_area_avg(data,area).*tsecs.*area_sum_m2_glb.*g2Pg;

nee_arc_ts_pnlic=flux_area_avg(data,areaarc).*tsecs.*area_sum_m2_arc.*g2Pg;

nee_temp_ts_pnlic=flux_area_avg(data,areatemp).*tsecs.*area_sum_m2_temp.*g2Pg;

nee_trop_ts_pnlic=flux_area_avg(data,areatrop).*tsecs.*area_sum_m2_trop.*g2Pg;

nee_t23south_ts_pnlic=flux_area_avg(data,areat23south).*tsecs.*area_sum_m2_23south.*g2Pg;

nee_t23north_ts_pnlic=flux_area_avg(data,areat23north).*tsecs.*area_sum_m2_23north.*g2Pg;


ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf1,'var',var_colc);
colc_glb_ts_pnlic=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_pnlic=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_pnlic=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_pnlic=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_pnlic=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_pnlic=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

j=5;
ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf1,'var',var_nee);
nee_glb_ts_pnlo=flux_area_avg(data,area).*tsecs.*area_sum_m2_glb.*g2Pg;

nee_arc_ts_pnlo=flux_area_avg(data,areaarc).*tsecs.*area_sum_m2_arc.*g2Pg;

nee_temp_ts_pnlo=flux_area_avg(data,areatemp).*tsecs.*area_sum_m2_temp.*g2Pg;

nee_trop_ts_pnlo=flux_area_avg(data,areatrop).*tsecs.*area_sum_m2_trop.*g2Pg;

nee_t23south_ts_pnlo=flux_area_avg(data,areat23south).*tsecs.*area_sum_m2_23south.*g2Pg;

nee_t23north_ts_pnlo=flux_area_avg(data,areat23north).*tsecs.*area_sum_m2_23north.*g2Pg;


ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf1,'var',var_colc);
colc_glb_ts_pnlo=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_pnlo=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_pnlo=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_pnlo=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_pnlo=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_pnlo=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

time=2001+(1:length(nee_glb_ts_mnl))./12;

%%
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.8,.45]);
ax=multipanel(fig,1,3,[.1,.11],[.25,.8],[0.065,0.05]);
set(fig,'CurrentAxes',ax(1));
plot(time,-cumsum(nee_glb_ts_mnl),'color',clr{1},'LineWidth',2);hold on;
plot(time,-cumsum(nee_glb_ts_nul),'color',clr{2},'LineWidth',2);
plot(time,-cumsum(nee_glb_ts_pnl),'color',clr{3},'LineWidth',2);
plot(time,-cumsum(nee_glb_ts_pnlic),'color',clr{4},'LineWidth',2);
plot(time,-cumsum(nee_glb_ts_pnlo),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',14);
title('Globe','FontSize',14);
xlabel('Year','FontSize',14);
ylabel('Total CWD carbon (Pg C)','FontSize',14);
legend('MNL','NUL','PNL','PNLIC','PNLO');

set(fig,'CurrentAxes',ax(2));
plot(time,-cumsum(nee_t23south_ts_mnl),'color',clr{1},'LineWidth',2);hold on;
plot(time,-cumsum(nee_t23south_ts_nul),'color',clr{2},'LineWidth',2);
plot(time,-cumsum(nee_t23south_ts_pnl),'color',clr{3},'LineWidth',2);
plot(time,-cumsum(nee_t23south_ts_pnlic),'color',clr{4},'LineWidth',2);
plot(time,-cumsum(nee_t23south_ts_pnlo),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',14);
title('<23.2\circS','FontSize',14);
xlabel('Year','FontSize',14);


set(fig,'CurrentAxes',ax(3));
plot(time,-cumsum(nee_t23north_ts_mnl),'color',clr{1},'LineWidth',2);hold on;
plot(time,-cumsum(nee_t23north_ts_nul),'color',clr{2},'LineWidth',2);
plot(time,-cumsum(nee_t23north_ts_pnl),'color',clr{3},'LineWidth',2);
plot(time,-cumsum(nee_t23north_ts_pnlic),'color',clr{4},'LineWidth',2);
plot(time,-cumsum(nee_t23north_ts_pnlo),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',14);
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));
title('>23.2\circS','FontSize',14);
xlabel('Year','FontSize',14);


set(fig,'color','w');

fig=figure(2);
set(fig,'unit','normalized','position',[.1,.1,.8,.85]);
ax=multipanel(fig,2,3,[.1,.11],[.25,.3],[0.065,0.1]);
set(fig,'CurrentAxes',ax(1));
plot(time,-cumsum(nee_temp_ts_mnl),'color',clr{1},'LineWidth',2);hold on;
plot(time,-cumsum(nee_temp_ts_nul),'color',clr{2},'LineWidth',2);
plot(time,-cumsum(nee_temp_ts_pnl),'color',clr{3},'LineWidth',2);
plot(time,-cumsum(nee_temp_ts_pnlic),'color',clr{4},'LineWidth',2);
plot(time,-cumsum(nee_temp_ts_pnlo),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',14);
title('North temperate','FontSize',14);
xlabel('Year','FontSize',14);
ylabel('Total CWD carbon (Pg C)','FontSize',14);
legend('MNL','NUL','PNL','PNLIC','PNLO');

set(fig,'CurrentAxes',ax(2));
plot(time,-cumsum(nee_trop_ts_mnl),'color',clr{1},'LineWidth',2);hold on;
plot(time,-cumsum(nee_trop_ts_nul),'color',clr{2},'LineWidth',2);
plot(time,-cumsum(nee_trop_ts_pnl),'color',clr{3},'LineWidth',2);
plot(time,-cumsum(nee_trop_ts_pnlic),'color',clr{4},'LineWidth',2);
plot(time,-cumsum(nee_trop_ts_pnlo),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',14);
title('Tropics','FontSize',14);
xlabel('Year','FontSize',14);


set(fig,'CurrentAxes',ax(3));
plot(time,-cumsum(nee_arc_ts_mnl),'color',clr{1},'LineWidth',2);hold on;
plot(time,-cumsum(nee_arc_ts_nul),'color',clr{2},'LineWidth',2);
plot(time,-cumsum(nee_arc_ts_pnl),'color',clr{3},'LineWidth',2);
plot(time,-cumsum(nee_arc_ts_pnlic),'color',clr{4},'LineWidth',2);
plot(time,-cumsum(nee_arc_ts_pnlo),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',14);
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));
title('Arctic','FontSize',14);
xlabel('Year','FontSize',14);


set(fig,'CurrentAxes',ax(4));
plot(time,(colc_temp_ts_mnl-colc_temp_ts_mnl(1)),'color',clr{1},'LineWidth',2);hold on;
plot(time,(colc_temp_ts_nul-colc_temp_ts_nul(1)),'color',clr{2},'LineWidth',2);
plot(time,(colc_temp_ts_pnl-colc_temp_ts_pnl(1)),'color',clr{3},'LineWidth',2);
plot(time,(colc_temp_ts_pnlic-colc_temp_ts_pnlic(1)),'color',clr{4},'LineWidth',2);
plot(time,(colc_temp_ts_pnlo-colc_temp_ts_pnlo(1)),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',14);
title('North temperate','FontSize',14);
xlabel('Year','FontSize',14);
ylabel('Total CWD carbon (Pg C)','FontSize',14);
legend('MNL','NUL','PNL','PNLIC','PNLO');

set(fig,'CurrentAxes',ax(5));
plot(time,(colc_trop_ts_mnl-colc_trop_ts_mnl(1)),'color',clr{1},'LineWidth',2);hold on;
plot(time,(colc_trop_ts_nul-colc_trop_ts_nul(1)),'color',clr{2},'LineWidth',2);
plot(time,(colc_trop_ts_pnl-colc_trop_ts_pnl(1)),'color',clr{3},'LineWidth',2);
plot(time,(colc_trop_ts_pnlic-colc_trop_ts_pnlic(1)),'color',clr{4},'LineWidth',2);
plot(time,(colc_trop_ts_pnlo-colc_trop_ts_pnlo(1)),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',14);
title('Tropics','FontSize',14);
xlabel('Year','FontSize',14);


set(fig,'CurrentAxes',ax(6));
plot(time,(colc_arc_ts_mnl-colc_arc_ts_mnl(1)),'color',clr{1},'LineWidth',2);hold on;
plot(time,(colc_arc_ts_nul-colc_arc_ts_nul(1)),'color',clr{2},'LineWidth',2);
plot(time,(colc_arc_ts_pnl-colc_arc_ts_pnl(1)),'color',clr{3},'LineWidth',2);
plot(time,(colc_arc_ts_pnlic-colc_arc_ts_pnlic(1)),'color',clr{4},'LineWidth',2);
plot(time,(colc_arc_ts_pnlo-colc_arc_ts_pnlo(1)),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',14);
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));
title('Arctic','FontSize',14);
xlabel('Year','FontSize',14);

set(fig,'color','w');