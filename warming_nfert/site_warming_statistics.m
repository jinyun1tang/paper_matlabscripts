close all;
clear all;
clc;
%site statistics
%this code compares the model simulated results with the metadata
site.name={'Prudhoe-Alaska','Abisko-Sweden','Delta Junction-Alaska',...
    'Zackenberg-NE Greenland','Tazovskiy Peninsula-Nothern Siberia',...
    'Latnjajaure-Nth Sweden','Toolik (Brooks range)-Alaska',...
    'Alaska Range','Barrow-Alaska','Atqasuk-Alaska',...
    'Kilpisjarvi-NW Finland','Pituffik Peninsula-Greenland',...
    'Spitsbergen-Svalbard','Healy-Alaska'};
site.lat=[70,68,63,74,67,68,68,63,71,70,69,76,78,63]+...
    [21,21,55,28,56,21,38,52,23,27,30,33,10,52]./60+eps;
site.lon=[-148,18,-145,-21,74,18,-149,-149,-156,-157,20,-68,16,-149]+...
    [360,0,360,360,0,0,360,360,360,360,0,360,0,360]+...
    [33,49,44,34,51,30,43,13,28,24,50,34,6,15]./60+eps;
nsites=length(site.lon);
iscent=0;
varname='CUMWARMDAY';

mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
if(iscent)
    ncf1=[mdir,'I1850-2000bgcvrt60N_control/',varname,'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
else
    ncf1=[mdir,'I1850-2000bgcvrt60N-CN_control/',varname,'.I1850-2000bgcvrt60N-CN_control.1980-2000.nc'];    
end
region=0;
[data_ctl,lon_v,lat_v]=flux_grid_extract(varname,ncf1,region);

site.iloc=zeros(length(site.lon),9);
site.jloc=zeros(length(site.lon),9);


for k1 = 1 : nsites
    [iloc,jloc]=find_siteloc9(lon_v,lat_v,site.lon(k1),site.lat(k1));

    site.iloc(k1,:)=iloc;
    site.jloc(k1,:)=jloc;
end

%
site.mat=[-11.5,0./0.,0./0.,-8.3,-8.8,-2,0./0.,-1,-12.6,-11.9,-2.3,-11.6,-6.7,-1];
site.map=[150,303,0./0.,261,370,848,0./0.,378,0./0.,0./0.,0./0.,122,190,378];
site.tsoi=[0./0.,6.7,9,0./0.,10.6,0.0/0.0,3.8,0./0.,0/0,0/0,0/0,9.4,4,6.5];
site.dtsoi=[0.5,1,1,0./0.,1,1.5,2.2,2.0,0./0.,0./0.,1.3,2,1.2,0/0];
site.tair=[4,10.9,0/0,0/0,15.4,0/0,11.2,0/0,0/0,0/0,9,3.5,5.8,11.2];
site.dtair=[1.3,2.3,0/0,0/0,3.6,2.5,3.5,0.4,0/0,0/0,3.9,4,1.4,0/0];
site.gsl_daz=[0/0,130,120,0/0,0/0,0/0,0/0,125,0/0,0/0,110,63,63,130];
site.mstart={'9_july','June','Mid-May',' ','May','Late-May','Late-May',...
    '2_May',' ',' ','Mid June','early June','early June','late May'};
site.mstop={'1_sep','Sep','Mid-Sep',' ',' ',' ','Late Aug/Early Sep',...
    'Sep 22',' ',' ','Mid Sep','Late Aug','Late Aug','Sep'};


sz=size(data_ctl,3);
%now find the growing season days
cumday_yr=zeros(9,1);
site.cumday_mean=zeros(nsites,9);
site.active=ones(nsites,1);
for k1 = 1 : nsites
    for k2 = 1 : 9
        if(site.iloc(k1,k2)>0)
            cumday_yr(k2)=mean(data_ctl(site.iloc(k1,k2),site.jloc(k1,k2),:));
        else
            cumday_yr(k2)=0./0.;
        end
    end
    fprintf('%d: maxd=%.2f, mind=%.2f\n',k1,max(cumday_yr),min(cumday_yr));
    if(min(cumday_yr)==0.0 || isnan(min(cumday_yr)))
        %the site is inactive
        site.active(k1)=0;
    else
        site.cumday_mean(k1,:)=cumday_yr;
    end    
end

varname='TBOT';
tbot=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
model.tbot=squeeze(tbot(:,:,:,1));
varname='RAIN';
rain=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);

varname='SNOW';
snow=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
model.prec=squeeze(rain(:,:,:,1)+snow(:,:,:,1));

%ts format (:,:,2) perturbed run, (:,:,1) control run
varname='TG';
model.tg_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='TSA';
model.tsa_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='TSOI_10CM';
model.tsoi10cm_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='SNOW_DEPTH';
model.snowdepth_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='NET_NMIN';
model.netnmin_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='LITTERC_LOSS';
model.ltrcloss_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='SMINN';
model.sminn_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='SOILC_HR';
model.soilchr_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='TOTSOMC';
model.totsomc_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='AR';
model.soilchr_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='ER';
model.er_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='GPP';
model.gpp_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='HR';
model.hr_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);
varname='NEE';
model.nee_otc=otc_site_ts(varname,iscent,site.iloc,site.jloc,21,site.active);


model.units={'atmospheric temperature TBOT: K',...
             'precipitation prec: mm/s',...
             'Ground temperature TG: K',...
             '2m air temperature TSA: K',...
             '10 cm deep soil temperature TSOI_10CM: K',...
             'snow depth SNOW_DEPTH: m',...
             'net nitrogen mineralization NET_NMIN: gN/m^2/s',...
             'litter C loss LITTRC_LOSS: gC/m^2/s',...
             'Soil mineral nitrogen SMINN: gN/m^2',...
             'Soil carbon heterotrophic respiration SOIL_HR: gC/m^2/s',...
             'total soil organic matter carbon TOTSOMC: gC/m^2',...
             'autotrophic respiration AR: gC/m^2/s',...
             'total ecosystem respiration ER: gC/m^2/s',...
             'GPP: gC/m^2/s',...
             'total heterotrophic respiration HR: gC/m^2/s',...
             'net ecosystem exchange of carbon NEE: gC/m^2/s'};
if(iscent)
    save('CLMcentbgc9_site_OTC.mat','model','site');
else
    save('CLMCNbgc9_site_OTC.mat','model','site');
end

