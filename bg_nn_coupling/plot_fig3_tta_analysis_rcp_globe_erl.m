close all;
clear all;
clc;
%This draws figure 2 and Figure 2 supp
loadit=1;

mother_dir='/Users/jinyuntang/work/data_collection/clm_output/bg_nn_coupling/RCP45';

child_dirs={'betr_clm_derive',...    %CLM,  MNL
'betr_cent_derive',...               %CENT, NUL
'betr_clm3_derive',...               %CLM3, PNL
'betr_clm3_cent_derive',...          %CLM3C,PNLIC
'betr_clmo_derive'};                 %CMLO, PNLO};


stem1='totcolc.RCP45.2001-2300.nc';
stem2='cstate.RCP45.2001-2300.nc';

clr={'b','k','r','c','g'};

var_colc='TOTCOLC';
var_litc='TOTLITC';
var_somc='TOTSOMC';
var_vegc='TOTVEGC';

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

if(~loadit)
%%
j=1;


ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf,'var',var_colc);
colc_glb_ts_mnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_mnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_mnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_mnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_mnl=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_mnl=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;


ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf,'var',var_somc)+netcdf(ncf,'var',var_litc);
soic_glb_ts_mnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

soic_arc_ts_mnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

soic_temp_ts_mnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

soic_trop_ts_mnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

soic_t23south_ts_mnl=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

soic_t23north_ts_mnl=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

data=netcdf(ncf,'var',var_vegc);
vegc_glb_ts_mnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

vegc_arc_ts_mnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

vegc_temp_ts_mnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

vegc_trop_ts_mnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

vegc_t23south_ts_mnl=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

vegc_t23north_ts_mnl=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;



%%

j=2;


ncf2=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf2,'var',var_colc);
colc_glb_ts_nul=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_nul=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_nul=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_nul=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_nul=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_nul=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;


ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf,'var',var_somc)+netcdf(ncf,'var',var_litc);
soic_glb_ts_nul=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

soic_arc_ts_nul=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

soic_temp_ts_nul=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

soic_trop_ts_nul=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

soic_t23south_ts_nul=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

soic_t23north_ts_nul=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

data=netcdf(ncf,'var',var_vegc);
vegc_glb_ts_nul=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

vegc_arc_ts_nul=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

vegc_temp_ts_nul=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

vegc_trop_ts_nul=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

vegc_t23south_ts_nul=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

vegc_t23north_ts_nul=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

%%
j=3;


ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf1,'var',var_colc);
colc_glb_ts_pnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_pnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_pnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_pnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_pnl=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_pnl=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;


ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf,'var',var_somc)+netcdf(ncf,'var',var_litc);
soic_glb_ts_pnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

soic_arc_ts_pnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

soic_temp_ts_pnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

soic_trop_ts_pnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

soic_t23south_ts_pnl=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

soic_t23north_ts_pnl=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

data=netcdf(ncf,'var',var_vegc);
vegc_glb_ts_pnl=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

vegc_arc_ts_pnl=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

vegc_temp_ts_pnl=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

vegc_trop_ts_pnl=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

vegc_t23south_ts_pnl=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

vegc_t23north_ts_pnl=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;
%%

j=4;



ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf1,'var',var_colc);
colc_glb_ts_pnlic=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_pnlic=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_pnlic=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_pnlic=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_pnlic=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_pnlic=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;


ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf,'var',var_somc)+netcdf(ncf,'var',var_litc);
soic_glb_ts_pnlic=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

soic_arc_ts_pnlic=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

soic_temp_ts_pnlic=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

soic_trop_ts_pnlic=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

soic_t23south_ts_pnlic=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

soic_t23north_ts_pnlic=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

data=netcdf(ncf,'var',var_vegc);
vegc_glb_ts_pnlic=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

vegc_arc_ts_pnlic=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

vegc_temp_ts_pnlic=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

vegc_trop_ts_pnlic=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

vegc_t23south_ts_pnlic=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

vegc_t23north_ts_pnlic=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;
%%
j=5;

ncf1=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem1);

data=netcdf(ncf1,'var',var_colc);
colc_glb_ts_pnlo=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

colc_arc_ts_pnlo=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

colc_temp_ts_pnlo=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

colc_trop_ts_pnlo=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

colc_t23south_ts_pnlo=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

colc_t23north_ts_pnlo=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem2);

data=netcdf(ncf,'var',var_somc)+netcdf(ncf,'var',var_litc);
soic_glb_ts_pnlo=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

soic_arc_ts_pnlo=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

soic_temp_ts_pnlo=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

soic_trop_ts_pnlo=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

soic_t23south_ts_pnlo=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

soic_t23north_ts_pnlo=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

data=netcdf(ncf,'var',var_vegc);
vegc_glb_ts_pnlo=flux_area_avg(data,area).*area_sum_m2_glb.*g2Pg;

vegc_arc_ts_pnlo=flux_area_avg(data,areaarc).*area_sum_m2_arc.*g2Pg;

vegc_temp_ts_pnlo=flux_area_avg(data,areatemp).*area_sum_m2_temp.*g2Pg;

vegc_trop_ts_pnlo=flux_area_avg(data,areatrop).*area_sum_m2_trop.*g2Pg;

vegc_t23south_ts_pnlo=flux_area_avg(data,areat23south).*area_sum_m2_23south.*g2Pg;

vegc_t23north_ts_pnlo=flux_area_avg(data,areat23north).*area_sum_m2_23north.*g2Pg;

save('tta_analysis_rcp_globe.mat',...
    'vegc_glb_ts_pnlo','vegc_arc_ts_pnlo','vegc_temp_ts_pnlo','vegc_trop_ts_pnlo','vegc_t23south_ts_pnlo','vegc_t23north_ts_pnlo',...
    'soic_glb_ts_pnlo','soic_arc_ts_pnlo','soic_temp_ts_pnlo','soic_trop_ts_pnlo','soic_t23south_ts_pnlo','soic_t23north_ts_pnlo',...
    'colc_glb_ts_pnlo','colc_arc_ts_pnlo','colc_temp_ts_pnlo','colc_trop_ts_pnlo','colc_t23south_ts_pnlo','colc_t23north_ts_pnlo',...
    'vegc_glb_ts_pnlic','vegc_arc_ts_pnlic','vegc_temp_ts_pnlic','vegc_trop_ts_pnlic','vegc_t23south_ts_pnlic','vegc_t23north_ts_pnlic',...
    'soic_glb_ts_pnlic','soic_arc_ts_pnlic','soic_temp_ts_pnlic','soic_trop_ts_pnlic','soic_t23south_ts_pnlic','soic_t23north_ts_pnlic',...
    'colc_glb_ts_pnlic','colc_arc_ts_pnlic','colc_temp_ts_pnlic','colc_trop_ts_pnlic','colc_t23south_ts_pnlic','colc_t23north_ts_pnlic',...   
    'vegc_glb_ts_pnl','vegc_arc_ts_pnl','vegc_temp_ts_pnl','vegc_trop_ts_pnl','vegc_t23south_ts_pnl','vegc_t23north_ts_pnl',...
    'soic_glb_ts_pnl','soic_arc_ts_pnl','soic_temp_ts_pnl','soic_trop_ts_pnl','soic_t23south_ts_pnl','soic_t23north_ts_pnl',...
    'colc_glb_ts_pnl','colc_arc_ts_pnl','colc_temp_ts_pnl','colc_trop_ts_pnl','colc_t23south_ts_pnl','colc_t23north_ts_pnl',...    
    'vegc_glb_ts_mnl','vegc_arc_ts_mnl','vegc_temp_ts_mnl','vegc_trop_ts_mnl','vegc_t23south_ts_mnl','vegc_t23north_ts_mnl',...
    'soic_glb_ts_mnl','soic_arc_ts_mnl','soic_temp_ts_mnl','soic_trop_ts_mnl','soic_t23south_ts_mnl','soic_t23north_ts_mnl',...
    'colc_glb_ts_mnl','colc_arc_ts_mnl','colc_temp_ts_mnl','colc_trop_ts_mnl','colc_t23south_ts_mnl','colc_t23north_ts_mnl',...     
    'vegc_glb_ts_nul','vegc_arc_ts_nul','vegc_temp_ts_nul','vegc_trop_ts_nul','vegc_t23south_ts_nul','vegc_t23north_ts_nul',...
    'soic_glb_ts_nul','soic_arc_ts_nul','soic_temp_ts_nul','soic_trop_ts_nul','soic_t23south_ts_nul','soic_t23north_ts_nul',...
    'colc_glb_ts_nul','colc_arc_ts_nul','colc_temp_ts_nul','colc_trop_ts_nul','colc_t23south_ts_nul','colc_t23north_ts_nul');      

else
    
    load('tta_analysis_rcp_globe.mat');
end

%%
fontsz=24;
time=2001+(1:length(vegc_glb_ts_mnl))./12;

%%

fig=figure(2);
set(fig,'unit','normalized','position',[.1,.1,.8,.85]);
ax=multipanel(fig,3,3,[.1,.06],[.25,.25],[0.065,0.065]);

jpd=12;
set(fig,'CurrentAxes',ax(1));
plot(jump_vec(time,jpd),jump_vec(colc_temp_ts_mnl-colc_temp_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(colc_temp_ts_nul-colc_temp_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(colc_temp_ts_pnl-colc_temp_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);

%plot(jump_vec(time,jpd),jump_vec(colc_temp_ts_pnlic-colc_temp_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_temp_ts_pnlo-colc_temp_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
title('North temperate [23.2^\circN, 66.0^\circN]','FontSize',fontsz);

ylabel('Total carbon (Pg C)','FontSize',fontsz);

legend('MNL','NUL','PNL');%,'PNLIC','PNLO');

set(fig,'CurrentAxes',ax(2));
plot(jump_vec(time,jpd),jump_vec(colc_trop_ts_mnl-colc_trop_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(colc_trop_ts_nul-colc_trop_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(colc_trop_ts_pnl-colc_trop_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_trop_ts_pnlic-colc_trop_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_trop_ts_pnlo-colc_trop_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
title('Tropics [23.2^\circS, 23.2^\circN]','FontSize',fontsz);



set(fig,'CurrentAxes',ax(3));
plot(jump_vec(time,jpd),jump_vec(colc_arc_ts_mnl-colc_arc_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(colc_arc_ts_nul-colc_arc_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(colc_arc_ts_pnl-colc_arc_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_arc_ts_pnlic-colc_arc_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_arc_ts_pnlo-colc_arc_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));
title('Arctic [66.0^\circN, 90^\circN]','FontSize',fontsz);



set(fig,'CurrentAxes',ax(4));
plot(jump_vec(time,jpd),jump_vec(vegc_temp_ts_mnl-vegc_temp_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(vegc_temp_ts_nul-vegc_temp_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(vegc_temp_ts_pnl-vegc_temp_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_temp_ts_pnlic-vegc_temp_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_temp_ts_pnlo-vegc_temp_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);


ylabel('Total vegetation carbon (Pg C)','FontSize',fontsz);


set(fig,'CurrentAxes',ax(5));
plot(jump_vec(time,jpd),jump_vec(vegc_trop_ts_mnl-vegc_trop_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(vegc_trop_ts_nul-vegc_trop_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(vegc_trop_ts_pnl-vegc_trop_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_trop_ts_pnlic-vegc_trop_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_trop_ts_pnlo-vegc_trop_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);



set(fig,'CurrentAxes',ax(6));
plot(jump_vec(time,jpd),jump_vec(vegc_arc_ts_mnl-vegc_arc_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(vegc_arc_ts_nul-vegc_arc_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(vegc_arc_ts_pnl-vegc_arc_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_arc_ts_pnlic-vegc_arc_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_arc_ts_pnlo-vegc_arc_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));


set(fig,'CurrentAxes',ax(7));
plot(jump_vec(time,jpd),jump_vec(soic_temp_ts_mnl-soic_temp_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(soic_temp_ts_nul-soic_temp_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(soic_temp_ts_pnl-soic_temp_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_temp_ts_pnlic-soic_temp_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_temp_ts_pnlo-soic_temp_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
xlabel('Year','FontSize',fontsz);
ylabel('Total soil carbon (Pg C)','FontSize',fontsz);


set(fig,'CurrentAxes',ax(8));
plot(jump_vec(time,jpd),jump_vec(soic_trop_ts_mnl-soic_trop_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(soic_trop_ts_nul-soic_trop_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(soic_trop_ts_pnl-soic_trop_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_trop_ts_pnlic-soic_trop_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_trop_ts_pnlo-soic_trop_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
xlabel('Year','FontSize',fontsz);


set(fig,'CurrentAxes',ax(9));
plot(jump_vec(time,jpd),jump_vec(soic_arc_ts_mnl-soic_arc_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(soic_arc_ts_nul-soic_arc_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(soic_arc_ts_pnl-soic_arc_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_arc_ts_pnlic-soic_arc_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_arc_ts_pnlo-soic_arc_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));

xlabel('Year','FontSize',fontsz);
put_tag(fig,ax(1),[.05,.95],'(a1)',fontsz);
put_tag(fig,ax(2),[.05,.95],'(b1)',fontsz);
put_tag(fig,ax(3),[.05,.95],'(c1)',fontsz);

put_tag(fig,ax(4),[.05,.95],'(a2)',fontsz);
put_tag(fig,ax(5),[.05,.95],'(b2)',fontsz);
put_tag(fig,ax(6),[.05,.95],'(c2)',fontsz);

put_tag(fig,ax(7),[.05,.95],'(a3)',fontsz);
put_tag(fig,ax(8),[.05,.95],'(b3)',fontsz);
put_tag(fig,ax(9),[.05,.95],'(c3)',fontsz);
set(fig,'color','w');
for j = 1 : 9
    set(fig,'CurrentAxes',ax(j));
    grid on;
end
%%
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.8,.85]);
ax=multipanel(fig,3,3,[.1,.06],[.25,.25],[0.065,0.065]);

jpd=12;
set(fig,'CurrentAxes',ax(1));
plot(jump_vec(time,jpd),jump_vec(colc_glb_ts_mnl-colc_glb_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(colc_glb_ts_nul-colc_glb_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(colc_glb_ts_pnl-colc_glb_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_glb_ts_pnlic-colc_glb_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_glb_ts_pnlo-colc_glb_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
title('Globe','FontSize',fontsz);
legend('MNL','NUL','PNL');%,'PNLIC','PNLO');
ylabel('Total carbon (Pg C)','FontSize',fontsz);


set(fig,'CurrentAxes',ax(2));
plot(jump_vec(time,jpd),jump_vec(colc_t23south_ts_mnl-colc_t23south_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(colc_t23south_ts_nul-colc_t23south_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(colc_t23south_ts_pnl-colc_t23south_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_t23south_ts_pnlic-colc_t23south_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_t23south_ts_pnlo-colc_t23south_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
title('South of 23^\circS','FontSize',fontsz);



set(fig,'CurrentAxes',ax(3));
plot(jump_vec(time,jpd),jump_vec(colc_t23north_ts_mnl-colc_t23north_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(colc_t23north_ts_nul-colc_t23north_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(colc_t23north_ts_pnl-colc_t23north_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_t23north_ts_pnlic-colc_t23north_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(colc_t23north_ts_pnlo-colc_t23north_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));
title('North of 23^\circS','FontSize',fontsz);



set(fig,'CurrentAxes',ax(4));
plot(jump_vec(time,jpd),jump_vec(vegc_glb_ts_mnl-vegc_glb_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(vegc_glb_ts_nul-vegc_glb_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(vegc_glb_ts_pnl-vegc_glb_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_glb_ts_pnlic-vegc_glb_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_glb_ts_pnlo-vegc_glb_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);


ylabel('Total vegetation carbon (Pg C)','FontSize',fontsz);


set(fig,'CurrentAxes',ax(5));
plot(jump_vec(time,jpd),jump_vec(vegc_t23south_ts_mnl-vegc_t23south_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(vegc_t23south_ts_nul-vegc_t23south_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(vegc_t23south_ts_pnl-vegc_t23south_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_t23south_ts_pnlic-vegc_t23south_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_t23south_ts_pnlo-vegc_t23south_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);



set(fig,'CurrentAxes',ax(6));
plot(jump_vec(time,jpd),jump_vec(vegc_t23north_ts_mnl-vegc_t23north_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(vegc_t23north_ts_nul-vegc_t23north_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(vegc_t23north_ts_pnl-vegc_t23north_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_t23north_ts_pnlic-vegc_t23north_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(vegc_t23north_ts_pnlo-vegc_t23north_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));


set(fig,'CurrentAxes',ax(7));
plot(jump_vec(time,jpd),jump_vec(soic_glb_ts_mnl-soic_glb_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(soic_glb_ts_nul-soic_glb_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(soic_glb_ts_pnl-soic_glb_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_glb_ts_pnlic-soic_glb_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_glb_ts_pnlo-soic_glb_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
xlabel('Year','FontSize',fontsz);
ylabel('Total soil carbon (Pg C)','FontSize',fontsz);


set(fig,'CurrentAxes',ax(8));
plot(jump_vec(time,jpd),jump_vec(soic_t23south_ts_mnl-soic_t23south_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(soic_t23south_ts_nul-soic_t23south_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(soic_t23south_ts_pnl-soic_t23south_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_t23south_ts_pnlic-soic_t23south_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_t23south_ts_pnlo-soic_t23south_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
xlabel('Year','FontSize',fontsz);


set(fig,'CurrentAxes',ax(9));
plot(jump_vec(time,jpd),jump_vec(soic_t23north_ts_mnl-soic_t23north_ts_mnl(1),jpd),'color',clr{1},'LineWidth',2);hold on;
plot(jump_vec(time,jpd),jump_vec(soic_t23north_ts_nul-soic_t23north_ts_nul(1),jpd),'color',clr{2},'LineWidth',2);
plot(jump_vec(time,jpd),jump_vec(soic_t23north_ts_pnl-soic_t23north_ts_pnl(1),jpd),'color',clr{3},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_t23north_ts_pnlic-soic_t23north_ts_pnlic(1),jpd),'color',clr{4},'LineWidth',2);
%plot(jump_vec(time,jpd),jump_vec(soic_t23north_ts_pnlo-soic_t23north_ts_pnlo(1),jpd),'color',clr{5},'LineWidth',2);
set(gca,'FontSize',fontsz);
set(ax,'Xlim',[2000,2301]);
set(ax,'XTick',(2000:50:2300));

xlabel('Year','FontSize',fontsz);
set(fig,'color','w');

put_tag(fig,ax(1),[.05,.95],'(a1)',fontsz);
put_tag(fig,ax(2),[.05,.95],'(b1)',fontsz);
put_tag(fig,ax(3),[.05,.95],'(c1)',fontsz);

put_tag(fig,ax(4),[.05,.95],'(a2)',fontsz);
put_tag(fig,ax(5),[.05,.95],'(b2)',fontsz);
put_tag(fig,ax(6),[.05,.95],'(c2)',fontsz);

put_tag(fig,ax(7),[.05,.95],'(a3)',fontsz);
put_tag(fig,ax(8),[.05,.95],'(b3)',fontsz);
put_tag(fig,ax(9),[.05,.95],'(c3)',fontsz);
for j = 1 : 9
    set(fig,'CurrentAxes',ax(j));
    grid on;
end
fprintf('statistics 2006-2100\n');
id1=60;  %time = 2006;
id2=1188;%time = 2100;
fprintf('%-20s %-20s %-20s\n','total_carbon', 'veg_carbon', 'soil_carbon');
fprintf('mnl\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_mnl(id2)-colc_glb_ts_mnl(id1),...
    vegc_glb_ts_mnl(id2)-vegc_glb_ts_mnl(id1),soic_glb_ts_mnl(id2)-soic_glb_ts_mnl(id1));
fprintf('nul\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_nul(id2)-colc_glb_ts_nul(id1),...
    vegc_glb_ts_nul(id2)-vegc_glb_ts_nul(id1),soic_glb_ts_nul(id2)-soic_glb_ts_nul(id1));
fprintf('pnl\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_pnl(id2)-colc_glb_ts_pnl(id1),...
    vegc_glb_ts_pnl(id2)-vegc_glb_ts_pnl(id1),soic_glb_ts_pnl(id2)-soic_glb_ts_pnl(id1));
fprintf('pnlo\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_pnlo(id2)-colc_glb_ts_pnlo(id1),...
    vegc_glb_ts_pnlo(id2)-vegc_glb_ts_pnlo(id1),soic_glb_ts_pnlo(id2)-soic_glb_ts_pnlo(id1));
fprintf('pnlic\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_pnlic(id2)-colc_glb_ts_pnlic(id1),...
    vegc_glb_ts_pnlic(id2)-vegc_glb_ts_pnlic(id1),soic_glb_ts_pnlic(id2)-soic_glb_ts_pnlic(id1));


fprintf('statistics 2000-2300\n');
id1=1;  %time = 2000;
id2=3600;%time = 2300;
fprintf('%-20s %-20s %-20s\n','total_carbon', 'veg_carbon', 'soil_carbon');
fprintf('mnl\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_mnl(id2)-colc_glb_ts_mnl(id1),...
    vegc_glb_ts_mnl(id2)-vegc_glb_ts_mnl(id1),soic_glb_ts_mnl(id2)-soic_glb_ts_mnl(id1));
fprintf('nul\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_nul(id2)-colc_glb_ts_nul(id1),...
    vegc_glb_ts_nul(id2)-vegc_glb_ts_nul(id1),soic_glb_ts_nul(id2)-soic_glb_ts_nul(id1));
fprintf('pnl\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_pnl(id2)-colc_glb_ts_pnl(id1),...
    vegc_glb_ts_pnl(id2)-vegc_glb_ts_pnl(id1),soic_glb_ts_pnl(id2)-soic_glb_ts_pnl(id1));
fprintf('pnlo\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_pnlo(id2)-colc_glb_ts_pnlo(id1),...
    vegc_glb_ts_pnlo(id2)-vegc_glb_ts_pnlo(id1),soic_glb_ts_pnlo(id2)-soic_glb_ts_pnlo(id1));
fprintf('pnlic\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_pnlic(id2)-colc_glb_ts_pnlic(id1),...
    vegc_glb_ts_pnlic(id2)-vegc_glb_ts_pnlic(id1),soic_glb_ts_pnlic(id2)-soic_glb_ts_pnlic(id1));


fprintf('statistics 2000-2005\n');
id1=1;  %time = 2006;
id2=60;
fprintf('%-20s %-20s %-20s\n','total_carbon', 'veg_carbon', 'soil_carbon');
fprintf('mnl\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_mnl(id2)-colc_glb_ts_mnl(id1),...
    vegc_glb_ts_mnl(id2)-vegc_glb_ts_mnl(id1),soic_glb_ts_mnl(id2)-soic_glb_ts_mnl(id1));
fprintf('nul\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_nul(id2)-colc_glb_ts_nul(id1),...
    vegc_glb_ts_nul(id2)-vegc_glb_ts_nul(id1),soic_glb_ts_nul(id2)-soic_glb_ts_nul(id1));
fprintf('pnl\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_pnl(id2)-colc_glb_ts_pnl(id1),...
    vegc_glb_ts_pnl(id2)-vegc_glb_ts_pnl(id1),soic_glb_ts_pnl(id2)-soic_glb_ts_pnl(id1));
fprintf('pnlo\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_pnlo(id2)-colc_glb_ts_pnlo(id1),...
    vegc_glb_ts_pnlo(id2)-vegc_glb_ts_pnlo(id1),soic_glb_ts_pnlo(id2)-soic_glb_ts_pnlo(id1));
fprintf('pnlic\n');
fprintf('%-20.8f %-20.8f %-20.8f\n',colc_glb_ts_pnlic(id2)-colc_glb_ts_pnlic(id1),...
    vegc_glb_ts_pnlic(id2)-vegc_glb_ts_pnlic(id1),soic_glb_ts_pnlic(id2)-soic_glb_ts_pnlic(id1));

