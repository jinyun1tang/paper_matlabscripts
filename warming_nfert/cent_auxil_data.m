close all;
clear all
clc;

load('CLMcentbgc9_site_OTC.mat');
nyr=21;

%extract the vertical field
ntype='otc';

varname='SOIL1C_vr';
soil1c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL2C_vr';
soil2c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL3C_vr';
soil3c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

soilc=soil1c+soil2c+soil3c;

varname='SMIN_NH4_vr';
smin_nh4 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SMIN_NO3_vr';
smin_no3 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

sminn=smin_nh4+smin_no3;


model_aux.soilc=soilc;

model_aux.sminn=sminn;


ntype='n.02';
varname='SOIL1C_vr';
soil1c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL2C_vr';
soil2c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL3C_vr';
soil3c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

soilc=soil1c+soil2c+soil3c;

varname='SMIN_NH4_vr';
smin_nh4 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SMIN_NO3_vr';
smin_no3 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

sminn=smin_nh4+smin_no3;


model_aux.soilc_n02=soilc;

model_aux.sminn_n02=sminn;

ntype='n.1';
varname='SOIL1C_vr';
soil1c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL2C_vr';
soil2c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL3C_vr';
soil3c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

soilc=soil1c+soil2c+soil3c;

varname='SMIN_NH4_vr';
smin_nh4 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SMIN_NO3_vr';
smin_no3 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

sminn=smin_nh4+smin_no3;


model_aux.soilc_n1=soilc;

model_aux.sminn_n1=sminn;


ntype='n.2';
varname='SOIL1C_vr';
soil1c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL2C_vr';
soil2c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL3C_vr';
soil3c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

soilc=soil1c+soil2c+soil3c;

varname='SMIN_NH4_vr';
smin_nh4 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SMIN_NO3_vr';
smin_no3 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

sminn=smin_nh4+smin_no3;


model_aux.soilc_n2=soilc;

model_aux.sminn_n2=sminn;


ntype='n.3';
varname='SOIL1C_vr';
soil1c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL2C_vr';
soil2c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL3C_vr';
soil3c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

soilc=soil1c+soil2c+soil3c;

varname='SMIN_NH4_vr';
smin_nh4 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SMIN_NO3_vr';
smin_no3 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

sminn=smin_nh4+smin_no3;


model_aux.soilc_n3=soilc;

model_aux.sminn_n3=sminn;


ntype='n.4';
varname='SOIL1C_vr';
soil1c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL2C_vr';
soil2c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL3C_vr';
soil3c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

soilc=soil1c+soil2c+soil3c;

varname='SMIN_NH4_vr';
smin_nh4 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SMIN_NO3_vr';
smin_no3 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

sminn=smin_nh4+smin_no3;


model_aux.soilc_n4=soilc;

model_aux.sminn_n4=sminn;

ntype='n.5';
varname='SOIL1C_vr';
soil1c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL2C_vr';
soil2c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SOIL3C_vr';
soil3c = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

soilc=soil1c+soil2c+soil3c;

varname='SMIN_NH4_vr';
smin_nh4 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

varname='SMIN_NO3_vr';
smin_no3 = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active);

sminn=smin_nh4+smin_no3;


model_aux.soilc_n5=soilc;

model_aux.sminn_n5=sminn;

save('aux9_pert_10cm.mat','model_aux');