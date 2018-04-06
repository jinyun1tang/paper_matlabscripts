close all;
clear all;
clc;


loadit=1;
mother_dir='/Users/jinyuntang/work/data_collection/clm_output/bg_nn_coupling/RCP45';

child_dirs={'betr_clm_derive',...    %CLM,  MNL
'betr_cent_derive',...               %CENT, NUL
'betr_clm3_derive',...               %CLM3, PNL
'betr_clm3_cent_derive',...          %CLM3C,PNLIC
'betr_clmo_derive'};                 %CMLO, PNLO};

stem1='cwd_state.RCP45.2001-2300.nc';

stem2='prod.RCP45.2001-2300.nc';

stem3='seed.RCP45.2001-2300.nc';


clr={'b','k','r'};
fontsz=28;

var_cwd='CWDC';
var_prod='TOTPRODC';
var_seed='SEEDC';

area=netcdf('area_2000.nc','var','area');

lon=netcdf('area_2000.nc','var','lon');

lat=netcdf('area_2000.nc','var','lat');

area_sum_m2_glb=get_area_sum(area);


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
area_sum_m2_t23south=get_area_sum(areat23south);
area_sum_m2_t23north=get_area_sum(areat23north);

g2Pg=1d-15;
if(~loadit)
j=1;
ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);
ncf2=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);
ncf3=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem3);


data=netcdf(ncf1,'var',var_cwd);

cwd_glb_ts_mnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
cwd_arc_ts_mnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
cwd_temp_ts_mnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
cwd_trop_ts_mnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
cwd_t23south_ts_mnl=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
cwd_t23north_ts_mnl=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;

data=netcdf(ncf2,'var',var_prod)+netcdf(ncf3,'var',var_seed);

prod_glb_ts_mnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
prod_arc_ts_mnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
prod_temp_ts_mnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
prod_trop_ts_mnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
prod_t23south_ts_mnl=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
prod_t23north_ts_mnl=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;

%%
j=2;
ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);
ncf2=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf1,'var',var_cwd);
cwd_glb_ts_nul=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
cwd_arc_ts_nul=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
cwd_temp_ts_nul=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
cwd_trop_ts_nul=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
cwd_t23south_ts_nul=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
cwd_t23north_ts_nul=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;

data=netcdf(ncf2,'var',var_prod)+netcdf(ncf3,'var',var_seed);

prod_glb_ts_nul=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
prod_arc_ts_nul=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
prod_temp_ts_nul=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
prod_trop_ts_nul=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
prod_t23south_ts_nul=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
prod_t23north_ts_nul=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;
%%
j=3;
ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);
ncf2=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf1,'var',var_cwd);
cwd_glb_ts_pnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
cwd_arc_ts_pnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
cwd_temp_ts_pnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
cwd_trop_ts_pnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
cwd_t23south_ts_pnl=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
cwd_t23north_ts_pnl=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;


data=netcdf(ncf2,'var',var_prod)+netcdf(ncf3,'var',var_seed);

prod_glb_ts_pnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
prod_arc_ts_pnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
prod_temp_ts_pnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
prod_trop_ts_pnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
prod_t23south_ts_pnl=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
prod_t23north_ts_pnl=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;
%%
j=4;
ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);
ncf2=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf1,'var',var_cwd);
cwd_glb_ts_pnlic=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
cwd_arc_ts_pnlic=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
cwd_temp_ts_pnlic=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
cwd_trop_ts_pnlic=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
cwd_t23south_ts_pnlic=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
cwd_t23north_ts_pnlic=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;

data=netcdf(ncf2,'var',var_prod)+netcdf(ncf3,'var',var_seed);

prod_glb_ts_pnlic=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
prod_arc_ts_pnlic=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
prod_temp_ts_pnlic=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
prod_trop_ts_pnlic=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
prod_t23south_ts_pnlic=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
prod_t23north_ts_pnlic=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;
%%
j=5;
ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);
ncf2=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf1,'var',var_cwd);
cwd_glb_ts_pnlo=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
cwd_arc_ts_pnlo=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
cwd_temp_ts_pnlo=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
cwd_trop_ts_pnlo=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
cwd_t23south_ts_pnlo=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
cwd_t23north_ts_pnlo=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;

data=netcdf(ncf2,'var',var_prod)+netcdf(ncf3,'var',var_seed);

prod_glb_ts_pnlo=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;
prod_arc_ts_pnlo=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;
prod_temp_ts_pnlo=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;
prod_trop_ts_pnlo=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;
prod_t23south_ts_pnlo=flux_area_avg(data,areat23south).*area_sum_m2_t23south.*g2Pg;
prod_t23north_ts_pnlo=flux_area_avg(data,areat23north).*area_sum_m2_t23north.*g2Pg;

save('cwd_analysis_globe.mat',...
    'cwd_glb_ts_pnlo','cwd_arc_ts_pnlo','cwd_temp_ts_pnlo','cwd_trop_ts_pnlo','cwd_t23south_ts_pnlo','cwd_t23north_ts_pnlo',...
    'prod_glb_ts_pnlo','prod_arc_ts_pnlo','prod_temp_ts_pnlo','prod_trop_ts_pnlo','prod_t23south_ts_pnlo','prod_t23north_ts_pnlo',...    
    'cwd_glb_ts_pnlic','cwd_arc_ts_pnlic','cwd_temp_ts_pnlic','cwd_trop_ts_pnlic','cwd_t23south_ts_pnlic','cwd_t23north_ts_pnlic',...
    'prod_glb_ts_pnlic','prod_arc_ts_pnlic','prod_temp_ts_pnlic','prod_trop_ts_pnlic','prod_t23south_ts_pnlic','prod_t23north_ts_pnlic',...
    'cwd_glb_ts_pnl','cwd_arc_ts_pnl','cwd_temp_ts_pnl','cwd_trop_ts_pnl','cwd_t23south_ts_pnl','cwd_t23north_ts_pnl',...
    'prod_glb_ts_pnl','prod_arc_ts_pnl','prod_temp_ts_pnl','prod_trop_ts_pnl','prod_t23south_ts_pnl','prod_t23north_ts_pnl',...       
    'cwd_glb_ts_mnl','cwd_arc_ts_mnl','cwd_temp_ts_mnl','cwd_trop_ts_mnl','cwd_t23south_ts_mnl','cwd_t23north_ts_mnl',...
    'prod_glb_ts_mnl','prod_arc_ts_mnl','prod_temp_ts_mnl','prod_trop_ts_mnl','prod_t23south_ts_mnl','prod_t23north_ts_mnl',...       
    'cwd_glb_ts_nul','cwd_arc_ts_nul','cwd_temp_ts_nul','cwd_trop_ts_nul','cwd_t23south_ts_nul','cwd_t23north_ts_nul',...
    'prod_glb_ts_nul','prod_arc_ts_nul','prod_temp_ts_nul','prod_trop_ts_nul','prod_t23south_ts_nul','prod_t23north_ts_nul');       
    
%%
else
    
    load('cwd_analysis_globe.mat');
end

time=2001+(1:length(cwd_glb_ts_mnl))./12;

%%
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.8,.65]);
ax=multipanel(fig,2,3,[.1,.11],[.25,.4],[0.065,0.05]);
set(fig,'CurrentAxes',ax(1));
plot(time,cwd_glb_ts_mnl-cwd_glb_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,cwd_glb_ts_nul-cwd_glb_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,cwd_glb_ts_pnl-cwd_glb_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,cwd_glb_ts_pnlic-cwd_glb_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,cwd_glb_ts_pnlo-cwd_glb_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
title('Globe','FontSize',fontsz);

ylabel('Total CWD carbon (Pg C)','FontSize',fontsz);


set(fig,'CurrentAxes',ax(2));
plot(time,cwd_t23south_ts_mnl-cwd_t23south_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,cwd_t23south_ts_nul-cwd_t23south_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,cwd_t23south_ts_pnl-cwd_t23south_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,cwd_t23south_ts_pnlic-cwd_t23south_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,cwd_t23south_ts_pnlo-cwd_t23south_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
title('South of 23.2\circS','FontSize',fontsz);



set(fig,'CurrentAxes',ax(3));
plot(time,cwd_t23north_ts_mnl-cwd_t23north_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,cwd_t23north_ts_nul-cwd_t23north_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,cwd_t23north_ts_pnl-cwd_t23north_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,cwd_t23north_ts_pnlic-cwd_t23north_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,cwd_t23north_ts_pnlo-cwd_t23north_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));
title('North of 23.2\circS','FontSize',fontsz);


set(fig,'CurrentAxes',ax(4));
plot(time,prod_glb_ts_mnl-prod_glb_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,prod_glb_ts_nul-prod_glb_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,prod_glb_ts_pnl-prod_glb_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,prod_glb_ts_pnlic-prod_glb_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,prod_glb_ts_pnlo-prod_glb_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;

xlabel('Year','FontSize',fontsz);
ylabel('Total PROD+Seed carbon (Pg C)','FontSize',fontsz);
legend('MNL','NUL','PNL');

set(fig,'CurrentAxes',ax(5));
plot(time,prod_t23south_ts_mnl-prod_t23south_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,prod_t23south_ts_nul-prod_t23south_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,prod_t23south_ts_pnl-prod_t23south_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,prod_t23south_ts_pnlic-prod_t23south_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,prod_t23south_ts_pnlo-prod_t23south_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
xlabel('Year','FontSize',fontsz);


set(fig,'CurrentAxes',ax(6));
plot(time,prod_t23north_ts_mnl-prod_t23north_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,prod_t23north_ts_nul-prod_t23north_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,prod_t23north_ts_pnl-prod_t23north_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,prod_t23north_ts_pnlic-prod_t23north_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,prod_t23north_ts_pnlo-prod_t23north_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));
xlabel('Year','FontSize',fontsz);


put_tag(fig,ax(1),[.05,.95],'(a1)',fontsz);
put_tag(fig,ax(2),[.05,.95],'(b1)',fontsz);
put_tag(fig,ax(3),[.05,.95],'(c1)',fontsz);

put_tag(fig,ax(4),[.05,.95],'(a2)',fontsz);
put_tag(fig,ax(5),[.05,.95],'(b2)',fontsz);
put_tag(fig,ax(6),[.05,.95],'(c2)',fontsz);


set(fig,'color','w');
%%

fig=figure(2);
set(fig,'unit','normalized','position',[.1,.1,.8,.65]);
ax=multipanel(fig,2,3,[.1,.11],[.25,.4],[0.065,0.05]);

set(fig,'CurrentAxes',ax(1));
plot(time,cwd_temp_ts_mnl-cwd_temp_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,cwd_temp_ts_nul-cwd_temp_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,cwd_temp_ts_pnl-cwd_temp_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,cwd_temp_ts_pnlic-cwd_temp_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,cwd_temp_ts_pnlo-cwd_temp_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
title('North temperate','FontSize',fontsz);

ylabel('Total CWD carbon (Pg C)','FontSize',fontsz);

set(fig,'CurrentAxes',ax(2));
plot(time,cwd_trop_ts_mnl-cwd_trop_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,cwd_trop_ts_nul-cwd_trop_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,cwd_trop_ts_pnl-cwd_trop_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,cwd_trop_ts_pnlic-cwd_trop_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,cwd_trop_ts_pnlo-cwd_trop_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
title('Tropics','FontSize',fontsz);

set(fig,'CurrentAxes',ax(3));
plot(time,cwd_arc_ts_mnl-cwd_arc_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,cwd_arc_ts_nul-cwd_arc_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,cwd_arc_ts_pnl-cwd_arc_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,cwd_arc_ts_pnlic-cwd_arc_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,cwd_arc_ts_pnlo-cwd_arc_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));
title('Arctic','FontSize',fontsz);


set(fig,'CurrentAxes',ax(4));
plot(time,prod_temp_ts_mnl-prod_temp_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,prod_temp_ts_nul-prod_temp_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,prod_temp_ts_pnl-prod_temp_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,prod_temp_ts_pnlic-prod_temp_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,prod_temp_ts_pnlo-prod_temp_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
xlabel('Year','FontSize',fontsz);
ylabel('Total PROD+Seed carbon (Pg C)','FontSize',fontsz);
legend('MNL','NUL','PNL');

set(fig,'CurrentAxes',ax(5));
plot(time,prod_trop_ts_mnl-prod_trop_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,prod_trop_ts_nul-prod_trop_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,prod_trop_ts_pnl-prod_trop_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,prod_trop_ts_pnlic-prod_trop_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,prod_trop_ts_pnlo-prod_trop_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
xlabel('Year','FontSize',fontsz);

set(fig,'CurrentAxes',ax(6));
plot(time,prod_arc_ts_mnl-prod_arc_ts_mnl(1),'color',clr{1},'LineWidth',2);hold on;
plot(time,prod_arc_ts_nul-prod_arc_ts_nul(1),'color',clr{2},'LineWidth',2);
plot(time,prod_arc_ts_pnl-prod_arc_ts_pnl(1),'color',clr{3},'LineWidth',2);
%plot(time,prod_arc_ts_pnlic-prod_arc_ts_pnlic(1),'color',clr{4},'LineWidth',2);
%plot(time,prod_arc_ts_pnlo-prod_arc_ts_pnlo(1),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);grid on;
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));

xlabel('Year','FontSize',fontsz);


put_tag(fig,ax(1),[.05,.95],'(a1)',fontsz);
put_tag(fig,ax(2),[.05,.95],'(b1)',fontsz);
put_tag(fig,ax(3),[.05,.95],'(c1)',fontsz);

put_tag(fig,ax(4),[.05,.95],'(a2)',fontsz);
put_tag(fig,ax(5),[.05,.95],'(b2)',fontsz);
put_tag(fig,ax(6),[.05,.95],'(c2)',fontsz);


set(fig,'color','w');

fprintf('cwd distribution\n');
fprintf('tropic temperate south_23 arctic\n');
fprintf('mnl\n');
fprintf('%-20.10f, %-20.10f, %-20.10f, %-20.10f\n',...
    (cwd_trop_ts_mnl(end)-cwd_trop_ts_mnl(1))/area_sum_m2_arc/g2Pg,...
    (cwd_temp_ts_mnl(end)-cwd_temp_ts_mnl(1))/area_sum_m2_arc/g2Pg,...
    (cwd_t23south_ts_mnl(end)-cwd_t23south_ts_mnl(1))/area_sum_m2_arc/g2Pg,...
    (cwd_arc_ts_mnl(end)-cwd_arc_ts_mnl(1))/area_sum_m2_arc/g2Pg);
fprintf('nul\n');
fprintf('%-20.10f, %-20.10f, %-20.10f, %-20.10f\n',...
    (cwd_trop_ts_nul(end)-cwd_trop_ts_nul(1))/area_sum_m2_arc/g2Pg,...
    (cwd_temp_ts_nul(end)-cwd_temp_ts_nul(1))/area_sum_m2_arc/g2Pg,...
    (cwd_t23south_ts_nul(end)-cwd_t23south_ts_nul(1))/area_sum_m2_arc/g2Pg,...
    (cwd_arc_ts_nul(end)-cwd_arc_ts_nul(1))/area_sum_m2_arc/g2Pg);
fprintf('pnl\n');
fprintf('%-20.10f, %-20.10f, %-20.10f, %-20.10f\n',...
    (cwd_trop_ts_pnl(end)-cwd_trop_ts_pnl(1))/area_sum_m2_arc/g2Pg,...
    (cwd_temp_ts_pnl(end)-cwd_temp_ts_pnl(1))/area_sum_m2_arc/g2Pg,...
    (cwd_t23south_ts_pnl(end)-cwd_t23south_ts_pnl(1))/area_sum_m2_arc/g2Pg,...
    (cwd_arc_ts_pnl(end)-cwd_arc_ts_pnl(1))/area_sum_m2_arc/g2Pg);
fprintf('pnlo\n');
fprintf('%-20.10f, %-20.10f, %-20.10f, %-20.10f\n',...
    (cwd_trop_ts_pnlo(end)-cwd_trop_ts_pnlo(1))/area_sum_m2_arc/g2Pg,...
    (cwd_temp_ts_pnlo(end)-cwd_temp_ts_pnlo(1))/area_sum_m2_arc/g2Pg,...
    (cwd_t23south_ts_pnlo(end)-cwd_t23south_ts_pnlo(1))/area_sum_m2_arc/g2Pg,...
    (cwd_arc_ts_pnlo(end)-cwd_arc_ts_pnlo(1))/area_sum_m2_arc/g2Pg);
fprintf('pnlic\n');
fprintf('%-20.10f, %-20.10f, %-20.10f, %-20.10f\n',...
    (cwd_trop_ts_pnlic(end)-cwd_trop_ts_pnlic(1))/area_sum_m2_arc/g2Pg,...
    (cwd_temp_ts_pnlic(end)-cwd_temp_ts_pnlic(1))/area_sum_m2_arc/g2Pg,...
    (cwd_t23south_ts_pnlic(end)-cwd_t23south_ts_pnlic(1))/area_sum_m2_arc/g2Pg,...
    (cwd_arc_ts_pnlic(end)-cwd_arc_ts_pnlic(1))/area_sum_m2_arc/g2Pg);

