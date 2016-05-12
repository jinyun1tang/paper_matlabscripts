close all;
clear all;
clc;
%site statistics
%this code compares the model simulated results with the metadata
site.name={'Abisko-Sweden','Toolik (Brooks Range)-Alaska',...
    'Delta Junction-Alaska','Tundra Ecological Research Station-Daring Lake',...
    'Zackenberg-NE greenland','Svalbard-Norway','Kilpisjarvi-NW Finland',...
    'Salmuisuo-Finland','Latnjajaure-Sweden','Flakaliden-Sweden'};
site.lat=[68,68,63,64,74,78,69,62,68,64]+...
    [20,38,55,52,28,56,3,47,21,7]./60+eps;
site.lon=[20,149,-145,-111,-21,11,20,30,18,19]+...
    [0,0,360,360,360,0,0,0,0,0]+...
    [51,43,44,35,34,51,50,56,30,27]./60+eps;
nsites=length(site.lon);
iscent=1;
varname='CUMWARMDAY';

mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
if(iscent)
    ncf1=[mdir,'I1850-2000bgcvrt60N_control/',varname,'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
else
    ncf1=[mdir,'I1850-2000bgcvrt60N-CN_control/',varname,'.I1850-2000bgcvrt60N-CN_control.1980-2000.nc'];    
end
region=0;
[data_ctl,lon_v,lat_v]=flux_grid_extract(varname,ncf1,region);

site.iloc=zeros(nsites,9);
site.jloc=zeros(nsites,9);
for k1 = 1 : nsites
    [iloc,jloc]=find_siteloc9(lon_v,lat_v,site.lon(k1),site.lat(k1));
    site.iloc(k1,:)=iloc;
    site.jloc(k1,:)=jloc;
end

%
site.mat=[-0.8,-8.5,-2,-10.5,-8.3,-6,-2.3,-4,-2,-2];
site.map=[303,350,303,260,261,371,420,650,848,600];

site.mstart={'June',' ','June','Early June',' ','Late June','Mid-June',...
    'spring',' ','Early June'};


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

%now find the statistics
%%
nlev='n.02';
varname='TBOT';
tbot=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
model.tbot=squeeze(tbot(:,:,:,1));
varname='RAIN';
rain=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);

varname='SNOW';
snow=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
model.prec=squeeze(rain(:,:,:,1)+snow(:,:,:,1));



varname='TG';
model.tg_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TSOI_10CM';
model.tsoi10cm_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SNOW_DEPTH';
model.snowdepth_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NET_NMIN';
model.netnmin_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='LITTERC_LOSS';
model.ltrcloss_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SMINN';
model.sminn_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SOILC_HR';
model.soilchr_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TOTSOMC';
model.totsomc_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='AR';
model.soilchr_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='ER';
model.er_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='GPP';
model.gpp_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='HR';
model.hr_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NEE';
model.nee_n02=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);

%%
nlev='n.1';



varname='TG';
model.tg_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TSOI_10CM';
model.tsoi10cm_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SNOW_DEPTH';
model.snowdepth_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NET_NMIN';
model.netnmin_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='LITTERC_LOSS';
model.ltrcloss_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SMINN';
model.sminn_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SOILC_HR';
model.soilchr_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TOTSOMC';
model.totsomc_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='AR';
model.soilchr_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='ER';
model.er_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='GPP';
model.gpp_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='HR';
model.hr_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NEE';
model.nee_n1=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
%%
nlev='n.2';

varname='TG';
model.tg_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TSOI_10CM';
model.tsoi10cm_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SNOW_DEPTH';
model.snowdepth_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NET_NMIN';
model.netnmin_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='LITTERC_LOSS';
model.ltrcloss_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SMINN';
model.sminn_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SOILC_HR';
model.soilchr_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TOTSOMC';
model.totsomc_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='AR';
model.soilchr_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='ER';
model.er_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='GPP';
model.gpp_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='HR';
model.hr_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NEE';
model.nee_n2=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);


nlev='n.3';

varname='TG';
model.tg_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TSOI_10CM';
model.tsoi10cm_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SNOW_DEPTH';
model.snowdepth_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NET_NMIN';
model.netnmin_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='LITTERC_LOSS';
model.ltrcloss_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SMINN';
model.sminn_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SOILC_HR';
model.soilchr_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TOTSOMC';
model.totsomc_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='AR';
model.soilchr_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='ER';
model.er_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='GPP';
model.gpp_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='HR';
model.hr_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NEE';
model.nee_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);



nlev='n.4';

varname='TG';
model.tg_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TSOI_10CM';
model.tsoi10cm_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SNOW_DEPTH';
model.snowdepth_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NET_NMIN';
model.netnmin_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='LITTERC_LOSS';
model.ltrcloss_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SMINN';
model.sminn_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SOILC_HR';
model.soilchr_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TOTSOMC';
model.totsomc_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='AR';
model.soilchr_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='ER';
model.er_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='GPP';
model.gpp_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='HR';
model.hr_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NEE';
model.nee_n4=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);

nlev='n.5';

varname='TG';
model.tg_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TSOI_10CM';
model.tsoi10cm_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SNOW_DEPTH';
model.snowdepth_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NET_NMIN';
model.netnmin_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='LITTERC_LOSS';
model.ltrcloss_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SMINN';
model.sminn_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='SOILC_HR';
model.soilchr_n3=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='TOTSOMC';
model.totsomc_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='AR';
model.soilchr_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='ER';
model.er_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='GPP';
model.gpp_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='HR';
model.hr_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);
varname='NEE';
model.nee_n5=nfert_site_ts(varname,nlev,iscent,site.iloc,site.jloc,21,site.active);

model.units={'atmospheric temperature TBOT: K',...
             'precipitation prec: mm/s',...
             'Ground temperature TG: K',...
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
    save('CLMcentbgc9_site.mat','model','site');
else
    save('CLMCNbgc9_site.mat','model','site');
end

