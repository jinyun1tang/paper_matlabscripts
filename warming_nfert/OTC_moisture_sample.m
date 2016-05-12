close all;
clear all;
clc;


%sampling H2OSOI for the control and OTC warming experiments

load('CLMcentbgc9_site_OTC.mat');
nyr=21;

avg=1;
ntype='otc';

varname='H2OSOI';
h2osoi_cent = cent_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active,avg);

h2osoi_cn = cn_site_ts_depvar(varname,site.iloc,site.jloc,nyr,ntype,site.active,avg);

model_h2o.h2osoi_cent=h2osoi_cent;
model_h2o.h2osoi_cn = h2osoi_cn;


save('aux9_pert_10cm_h2osoi.mat','model_h2o');