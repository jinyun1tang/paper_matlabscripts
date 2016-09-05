function histflux_stats_globe(loadit)

mother_dir='/Volumes/data/1850-2000';

child_dirs={'betr_clm_derive',...    %CLM,  MNL
'betr_cent_derive',...               %CENT, NUL
'betr_clm3_derive',...               %CLM3, PNL
'betr_clm3_cent_derive',...          %CLM3C,PNLIC
'betr_clmo_derive',...               %CMLO, PNLO
'default_derive'};

stem='carbon_flux.1850-2000.nc';


area=netcdf('area_2000.nc','var','area');


area_sum_m2=get_area_sum(area);

if(loadit)
   load('histflux_stat.mat');
else

j=1;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

[nee_glb_ts_mnl,nep_glb_ts_mnl,npp_glb_ts_mnl,hr_glb_ts_mnl]=get_flux_ts(ncf,area,area_sum_m2);

j=2;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

[nee_glb_ts_nul,nep_glb_ts_nul,npp_glb_ts_nul,hr_glb_ts_nul]=get_flux_ts(ncf,area,area_sum_m2);

j=3;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

[nee_glb_ts_pnl,nep_glb_ts_pnl,npp_glb_ts_pnl,hr_glb_ts_pnl]=get_flux_ts(ncf,area,area_sum_m2);

j=4;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

[nee_glb_ts_pnlic,nep_glb_ts_pnlic,npp_glb_ts_pnlic,hr_glb_ts_pnlic]=get_flux_ts(ncf,area,area_sum_m2);

j=5;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

[nee_glb_ts_pnlo,nep_glb_ts_pnlo,npp_glb_ts_pnlo,hr_glb_ts_pnlo]=get_flux_ts(ncf,area,area_sum_m2);

j=6;
ncf=sprintf('%s/%s/%s',mother_dir,child_dirs{j},stem);

[nee_glb_ts_def,nep_glb_ts_def,npp_glb_ts_def,hr_glb_ts_def]=get_flux_ts(ncf,area,area_sum_m2);




    save('histflux_stat.mat','nee_glb_ts_def','nep_glb_ts_def','npp_glb_ts_def','hr_glb_ts_def',...
        'nee_glb_ts_pnlo','nep_glb_ts_pnlo','npp_glb_ts_pnlo','hr_glb_ts_pnlo',...
        'nee_glb_ts_pnlic','nep_glb_ts_pnlic','npp_glb_ts_pnlic','hr_glb_ts_pnlic',...
        'nee_glb_ts_pnl','nep_glb_ts_pnl','npp_glb_ts_pnl','hr_glb_ts_pnl',...
        'nee_glb_ts_nul','nep_glb_ts_nul','npp_glb_ts_nul','hr_glb_ts_nul',...
        'nee_glb_ts_mnl','nep_glb_ts_mnl','npp_glb_ts_mnl','hr_glb_ts_mnl');
end
[neet_def,nept_def,nppt_def,hrt_def]=printflux('default',nee_glb_ts_def,nep_glb_ts_def,npp_glb_ts_def,hr_glb_ts_def);

[neet_pnlo,nept_pnlo,nppt_pnlo,hrt_pnlo]=printflux('PNLO',nee_glb_ts_pnlo,nep_glb_ts_pnlo,npp_glb_ts_pnlo,hr_glb_ts_pnlo);

[neet_pnlic,nept_pnlic,nppt_pnlic,hrt_pnlic]=printflux('PNLIC',nee_glb_ts_pnlic,nep_glb_ts_pnlic,npp_glb_ts_pnlic,hr_glb_ts_pnlic);

[neet_pnl,nept_pnl,nppt_pnl,hrt_pnl]=printflux('PNL',nee_glb_ts_pnl,nep_glb_ts_pnl,npp_glb_ts_pnl,hr_glb_ts_pnl);

[neet_nul,nept_nul,nppt_nul,hrt_nul]=printflux('NUL',nee_glb_ts_nul,nep_glb_ts_nul,npp_glb_ts_nul,hr_glb_ts_nul);

[neet_mnl,nept_mnl,nppt_mnl,hrt_mnl]=printflux('MNL',nee_glb_ts_mnl,nep_glb_ts_mnl,npp_glb_ts_mnl,hr_glb_ts_mnl);



fprintf('%10s %20s %20s %20s %20s\n','model','NEE','NEP','NPP','HR'); 
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','MNL',neet_mnl,nept_mnl,nppt_mnl,hrt_mnl);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','NUL',neet_nul,nept_nul,nppt_nul,hrt_nul);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','PNL',neet_pnl,nept_pnl,nppt_pnl,hrt_pnl);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','PNLIC',neet_pnlic,nept_pnlic,nppt_pnlic,hrt_pnlic);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','PNLO',neet_pnlo,nept_pnlo,nppt_pnlo,hrt_pnlo);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','Default',neet_def,nept_def,nppt_def,hrt_def);



end


function [nee,nep,npp,hr]=get_flux_ts(ncf,area,area_sum_m2)

var_nep='NEP';
var_hr='HR';
var_npp='NPP';
var_nee='NEE';
tdays=get_tdays(1850, 2000);

tsecs=tdays.*86400;

g2Pg=1d-15;

data=netcdf(ncf,'var',var_nep);nep=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_npp);npp=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_hr);hr=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_nee);nee=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

end


function [neet,nept,nppt,hrt]=printflux(model, nee,nep,npp,hr)

fprintf('-------------------------------------------------\n');
fprintf('%s\n',model);

fprintf('%6s %20s %20s %20s %20s\n','time','NEE','NEP','NPP','HR');

yr=1850;

cnee=cumsum(nee);
cnep=cumsum(nep);
cnpp=cumsum(npp);
chr=cumsum(hr);

for j = 1 : length(nee)
    mon=mod(j,12);
    if(mon==0)
        mon=12;
    end
    fprintf('%4d%2d %20.10f %20.10f %20.10f %20.10f\n',yr,mon,cnee(j),cnep(j),cnpp(j),chr(j));
    if(mon==12)                
        yr=yr+1;
    end
end
neet=cnee(end);
nept=cnep(end);
nppt=cnpp(end);
hrt=chr(end);
end

