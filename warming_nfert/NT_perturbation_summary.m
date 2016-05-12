close all;
clear all;
clc;
grows=1;
isweighted=1;
region1=1;  %North America
region2=2;  %Euroasia
varname='GPP'; %gross primary productivity
gpp_n_cent_nam = nfert_analysis_cent(varname,region1,isweighted);
gpp_n_cent_eas = nfert_analysis_cent(varname,region2,isweighted);
gpp_n_cent_tot = nfert_analysis_cent(varname,0,isweighted);
gpp_n_cn_nam = nfert_analysis(varname,region1,isweighted);
gpp_n_cn_eas = nfert_analysis(varname,region2,isweighted);
gpp_n_cn_tot = nfert_analysis(varname,0,isweighted);
gpp_t_cent_nam = heat_analysis_cent(varname,region1,isweighted);
gpp_t_cent_eas = heat_analysis_cent(varname,region2,isweighted);
gpp_t_cent_tot = heat_analysis_cent(varname,0,isweighted);
gpp_t_cn_nam = heat_analysis(varname,region1,isweighted);
gpp_t_cn_eas = heat_analysis(varname,region2,isweighted);
gpp_t_cn_tot = heat_analysis(varname,0,isweighted);

varname='NEE'; %ecosystem respiration
nee_n_cent_nam = nfert_analysis_cent(varname,region1,isweighted);
nee_n_cent_eas = nfert_analysis_cent(varname,region2,isweighted);
nee_n_cent_tot = nfert_analysis_cent(varname,0,isweighted);
nee_n_cn_nam = nfert_analysis(varname,region1,isweighted);
nee_n_cn_eas = nfert_analysis(varname,region2,isweighted);
nee_n_cn_tot = nfert_analysis(varname,0,isweighted);
nee_t_cent_nam = heat_analysis_cent(varname,region1,isweighted);
nee_t_cent_eas = heat_analysis_cent(varname,region2,isweighted);
nee_t_cent_tot = heat_analysis_cent(varname,0,isweighted);
nee_t_cn_nam = heat_analysis(varname,region1,isweighted);
nee_t_cn_eas = heat_analysis(varname,region2,isweighted);
nee_t_cn_tot = heat_analysis(varname,0,isweighted);

varname='ER'; %ecosystem respiration
er_n_cent_nam = nfert_analysis_cent(varname,region1,isweighted);
er_n_cent_eas = nfert_analysis_cent(varname,region2,isweighted);
er_n_cent_tot = nfert_analysis_cent(varname,0,isweighted);
er_n_cn_nam = nfert_analysis(varname,region1,isweighted);
er_n_cn_eas = nfert_analysis(varname,region2,isweighted);
er_n_cn_tot = nfert_analysis(varname,0,isweighted);
er_t_cent_nam = heat_analysis_cent(varname,region1,isweighted);
er_t_cent_eas = heat_analysis_cent(varname,region2,isweighted);
er_t_cent_tot = heat_analysis_cent(varname,0,isweighted);
er_t_cn_nam = heat_analysis(varname,region1,isweighted);
er_t_cn_eas = heat_analysis(varname,region2,isweighted);
er_t_cn_tot = heat_analysis(varname,0,isweighted);

varname='HR'; %heteorotrophic respiration, litter + som
hr_n_cent_nam = nfert_analysis_cent(varname,region1,isweighted);
hr_n_cent_eas = nfert_analysis_cent(varname,region2,isweighted);
hr_n_cent_tot = nfert_analysis_cent(varname,0,isweighted);
hr_n_cn_nam = nfert_analysis(varname,region1,isweighted);
hr_n_cn_eas = nfert_analysis(varname,region2,isweighted);
hr_n_cn_tot = nfert_analysis(varname,0,isweighted);
hr_t_cent_nam = heat_analysis_cent(varname,region1,isweighted);
hr_t_cent_eas = heat_analysis_cent(varname,region2,isweighted);
hr_t_cent_tot = heat_analysis_cent(varname,0,isweighted);
hr_t_cn_nam = heat_analysis(varname,region1,isweighted);
hr_t_cn_eas = heat_analysis(varname,region2,isweighted);
hr_t_cn_tot = heat_analysis(varname,0,isweighted);

isweighted=0;
varname='TOTSOMC'; %total soil organic carbon
som_n_cent_nam = nfert_analysis_cent(varname,region1,isweighted);
som_n_cent_eas = nfert_analysis_cent(varname,region2,isweighted);
som_n_cent_tot = nfert_analysis_cent(varname,0,isweighted);
som_n_cn_nam = nfert_analysis(varname,region1,isweighted);
som_n_cn_eas = nfert_analysis(varname,region2,isweighted);
som_n_cn_tot = nfert_analysis(varname,0,isweighted);
som_t_cent_nam = heat_analysis_cent(varname,region1,isweighted);
som_t_cent_eas = heat_analysis_cent(varname,region2,isweighted);
som_t_cent_tot = heat_analysis_cent(varname,0,isweighted);
som_t_cn_nam = heat_analysis(varname,region1,isweighted);
som_t_cn_eas = heat_analysis(varname,region2,isweighted);
som_t_cn_tot = heat_analysis(varname,0,isweighted);


varname='LITTERC_LOSS'; %carbon loss from litter decomposition
litloss_n_cent_nam = nfert_analysis_cent(varname,region1,isweighted);
litloss_n_cent_eas = nfert_analysis_cent(varname,region2,isweighted);
litloss_n_cent_tot = nfert_analysis_cent(varname,0,isweighted);
litloss_n_cn_nam = nfert_analysis(varname,region1,isweighted);
litloss_n_cn_eas = nfert_analysis(varname,region2,isweighted);
litloss_n_cn_tot = nfert_analysis(varname,0,isweighted);
litloss_t_cent_nam = heat_analysis_cent(varname,region1,isweighted);
litloss_t_cent_eas = heat_analysis_cent(varname,region2,isweighted);
litloss_t_cent_tot = heat_analysis_cent(varname,0,isweighted);
litloss_t_cn_nam = heat_analysis(varname,region1,isweighted);
litloss_t_cn_eas = heat_analysis(varname,region2,isweighted);
litloss_t_cn_tot = heat_analysis(varname,0,isweighted);
isweighted=1;
varname='NET_NMIN'; %net nitrogen mineralization
netnmin_n_cent_nam = nfert_analysis_cent(varname,region1,isweighted);
netnmin_n_cent_eas = nfert_analysis_cent(varname,region2,isweighted);
netnmin_n_cent_tot = nfert_analysis_cent(varname,0,isweighted);
netnmin_n_cn_nam = nfert_analysis(varname,region1,isweighted);
netnmin_n_cn_eas = nfert_analysis(varname,region2,isweighted);
netnmin_n_cn_tot = nfert_analysis(varname,0,isweighted);
netnmin_t_cent_nam = heat_analysis_cent(varname,region1,isweighted);
netnmin_t_cent_eas = heat_analysis_cent(varname,region2,isweighted);
netnmin_t_cent_tot = heat_analysis_cent(varname,0,isweighted);
netnmin_t_cn_nam = heat_analysis(varname,region1,isweighted);
netnmin_t_cn_eas = heat_analysis(varname,region2,isweighted);
netnmin_t_cn_tot = heat_analysis(varname,0,isweighted);


isweighted=0;
varname='SMINN'; %soil mineral nitrogen
sminn_n_cent_nam = nfert_analysis_cent(varname,region1,isweighted);
sminn_n_cent_eas = nfert_analysis_cent(varname,region2,isweighted);
sminn_n_cent_tot = nfert_analysis_cent(varname,0,isweighted);
sminn_n_cn_nam = nfert_analysis(varname,region1,isweighted);
sminn_n_cn_eas = nfert_analysis(varname,region2,isweighted);
sminn_n_cn_tot = nfert_analysis(varname,0,isweighted);
sminn_t_cent_nam = heat_analysis_cent(varname,region1,isweighted);
sminn_t_cent_eas = heat_analysis_cent(varname,region2,isweighted);
sminn_t_cent_tot = heat_analysis_cent(varname,0,isweighted);
sminn_t_cn_nam = heat_analysis(varname,region1,isweighted);
sminn_t_cn_eas = heat_analysis(varname,region2,isweighted);
sminn_t_cn_tot = heat_analysis(varname,0,isweighted);


varname='SOIL1C_vr'; %soil mineral nitrogen
soil1c_n_cent_nam = nfert_vertfld_cent(varname,region1,isweighted);
soil1c_n_cent_eas = nfert_vertfld_cent(varname,region2,isweighted);
soil1c_n_cent_tot = nfert_vertfld_cent(varname,0,isweighted);
soil1c_t_cent_nam = heat_vertfld_cent(varname,region1,isweighted);
soil1c_t_cent_eas = heat_vertfld_cent(varname,region2,isweighted);
soil1c_t_cent_tot = heat_vertfld_cent(varname,0,isweighted);

varname='SOIL2C_vr'; %soil mineral nitrogen
soil2c_n_cent_nam = nfert_vertfld_cent(varname,region1,isweighted);
soil2c_n_cent_eas = nfert_vertfld_cent(varname,region2,isweighted);
soil2c_n_cent_tot = nfert_vertfld_cent(varname,0,isweighted);
soil2c_t_cent_nam = heat_vertfld_cent(varname,region1,isweighted);
soil2c_t_cent_eas = heat_vertfld_cent(varname,region2,isweighted);
soil2c_t_cent_tot = heat_vertfld_cent(varname,0,isweighted);

varname='SOIL3C_vr'; %soil mineral nitrogen
soil3c_n_cent_nam = nfert_vertfld_cent(varname,region1,isweighted);
soil3c_n_cent_eas = nfert_vertfld_cent(varname,region2,isweighted);
soil3c_n_cent_tot = nfert_vertfld_cent(varname,0,isweighted);
soil3c_t_cent_nam = heat_vertfld_cent(varname,region1,isweighted);
soil3c_t_cent_eas = heat_vertfld_cent(varname,region2,isweighted);
soil3c_t_cent_tot = heat_vertfld_cent(varname,0,isweighted);

varname='SMIN_NH4_vr';
smin_nh4_n_cent_nam = nfert_vertfld_cent(varname,region1,isweighted);
smin_nh4_n_cent_eas = nfert_vertfld_cent(varname,region2,isweighted);
smin_nh4_n_cent_tot = nfert_vertfld_cent(varname,0,isweighted);
smin_nh4_t_cent_nam = heat_vertfld_cent(varname,region1,isweighted);
smin_nh4_t_cent_eas = heat_vertfld_cent(varname,region2,isweighted);
smin_nh4_t_cent_tot = heat_vertfld_cent(varname,0,isweighted);


varname='SMIN_NO3_vr';
smin_no3_n_cent_nam = nfert_vertfld_cent(varname,region1,isweighted);
smin_no3_n_cent_eas = nfert_vertfld_cent(varname,region2,isweighted);
smin_no3_n_cent_tot = nfert_vertfld_cent(varname,0,isweighted);
smin_no3_t_cent_nam = heat_vertfld_cent(varname,region1,isweighted);
smin_no3_t_cent_eas = heat_vertfld_cent(varname,region2,isweighted);
smin_no3_t_cent_tot = heat_vertfld_cent(varname,0,isweighted);


soilc_n_cent_nam=soil1c_n_cent_nam+soil2c_n_cent_nam+soil3c_n_cent_nam;
soilc_n_cent_eas=soil1c_n_cent_eas+soil2c_n_cent_eas+soil3c_n_cent_eas;
soilc_n_cent_tot=soil1c_n_cent_tot+soil2c_n_cent_tot+soil3c_n_cent_tot;
soilc_t_cent_nam=soil1c_t_cent_nam+soil2c_t_cent_nam+soil3c_t_cent_nam;
soilc_t_cent_eas=soil1c_t_cent_eas+soil2c_t_cent_eas+soil3c_t_cent_eas;
soilc_t_cent_tot=soil1c_t_cent_tot+soil2c_t_cent_tot+soil3c_t_cent_tot;




%top soil som, first five 5 layers, totally 21 cm
ndim=2;
nlay=5;
soilc20cm_n_cent_nam=int_depth(soilc_n_cent_nam,ndim,nlay);
soilc20cm_n_cent_eas=int_depth(soilc_n_cent_eas,ndim,nlay);
soilc20cm_n_cent_tot=int_depth(soilc_n_cent_tot,ndim,nlay);
soilc20cm_t_cent_nam=int_depth(soilc_t_cent_nam,ndim,nlay);
soilc20cm_t_cent_eas=int_depth(soilc_t_cent_eas,ndim,nlay);
soilc20cm_t_cent_tot=int_depth(soilc_t_cent_tot,ndim,nlay);


sminn20cm_n_cent_nam=int_depth(smin_nh4_n_cent_nam+smin_no3_n_cent_nam,ndim,nlay);
sminn20cm_n_cent_eas=int_depth(smin_nh4_n_cent_eas+smin_no3_n_cent_eas,ndim,nlay);
sminn20cm_n_cent_tot=int_depth(smin_nh4_n_cent_tot+smin_no3_n_cent_tot,ndim,nlay);
sminn20cm_t_cent_nam=int_depth(smin_nh4_t_cent_nam+smin_no3_t_cent_nam,ndim,nlay);
sminn20cm_t_cent_eas=int_depth(smin_nh4_t_cent_eas+smin_no3_t_cent_eas,ndim,nlay);
sminn20cm_t_cent_tot=int_depth(smin_nh4_t_cent_tot+smin_no3_t_cent_tot,ndim,nlay);

area_nam=area_extract(1);  %total area for north america grids
area_eas=area_extract(2);  %total area for euroasia grids
area_tot=area_extract(0);  %total area for 60N grids


varname='TOTSOMC'; %total soil organic carbon
[som_n_cent_grid,lon,lat] = nfert_analysis_cent_grid(varname,isweighted);
[som_n_cn_grid,lon,lat] = nfert_analysis_grid(varname,isweighted);
[som_t_cent_grid,lon,lat] = heat_analysis_cent_grid(varname,isweighted);
[som_t_cn_grid,lon,lat] = heat_analysis_grid(varname,isweighted);

varname='HR'; %total soil organic carbon
[hr_n_cent_grid,lon,lat] = nfert_analysis_cent_grid(varname,isweighted);
[hr_n_cn_grid,lon,lat] = nfert_analysis_grid(varname,isweighted);
[hr_t_cent_grid,lon,lat] = heat_analysis_cent_grid(varname,isweighted);
[hr_t_cn_grid,lon,lat] = heat_analysis_grid(varname,isweighted);

varname='SOIL1C_vr';
[som1c_n_cent_grid,lon,lat] = nfert_vertfld_cent_grid(varname,isweighted);
[som1c_t_cent_grid,lon,lat] = heat_vertfld_cent_grid(varname,isweighted);

varname='SOIL2C_vr';
[som2c_n_cent_grid,lon,lat] = nfert_vertfld_cent_grid(varname,isweighted);
[som2c_t_cent_grid,lon,lat] = heat_vertfld_cent_grid(varname,isweighted);

varname='SOIL3C_vr';
[som3c_n_cent_grid,lon,lat] = nfert_vertfld_cent_grid(varname,isweighted);
[som3c_t_cent_grid,lon,lat] = heat_vertfld_cent_grid(varname,isweighted);

ndim=3;
somc20cm_n_cent_grid=int_depth(som1c_n_cent_grid+som2c_n_cent_grid+som3c_n_cent_grid,ndim,nlay);
somc20cm_t_cent_grid=int_depth(som1c_t_cent_grid+som2c_t_cent_grid+som3c_t_cent_grid,ndim,nlay);

varname='SMIN_NH4_vr';
[sminn_nh4_n_cent_grid,lon,lat] = nfert_vertfld_cent_grid(varname,isweighted);
[sminn_nh4_t_cent_grid,lon,lat] = heat_vertfld_cent_grid(varname,isweighted);

varname='SMIN_NO3_vr';
[sminn_no3_n_cent_grid,lon,lat] = nfert_vertfld_cent_grid(varname,isweighted);
[sminn_no3_t_cent_grid,lon,lat] = heat_vertfld_cent_grid(varname,isweighted);

sminn20cm_n_cent_grid=int_depth(sminn_nh4_n_cent_grid+sminn_no3_n_cent_grid,ndim,nlay);
sminn20cm_t_cent_grid=int_depth(sminn_nh4_t_cent_grid+sminn_no3_t_cent_grid,ndim,nlay);


clear varname;
clear region1 region2;
clear isweighted;
if(grows)
    save('NT_perturb_summary_grows.mat');    
else
    save('NT_perturb_summary.mat');
end
    


