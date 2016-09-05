function rcpflux_stats_globe(loadit)

mother_dir='/Volumes/OS/Users/JinyunTang/data_mirror/RCP45';

child_dirs={'betr_clm_derive',...    %CLM,  MNL
'betr_cent_derive',...               %CENT, NUL
'betr_clm3_derive',...               %CLM3, PNL
'betr_clm3_cent_derive',...          %CLM3C,PNLIC
'betr_clmo_derive'};                 %CMLO, PNLO};

stem='carbon_flux.RCP45.2001-2300.nc';


area=netcdf('area_2000.nc','var','area');


area_sum_m2=get_area_sum(area);

if(loadit)
   load('rcpflux_stat.mat');
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





    save('rcpflux_stat.mat',...
        'nee_glb_ts_pnlo','nep_glb_ts_pnlo','npp_glb_ts_pnlo','hr_glb_ts_pnlo',...
        'nee_glb_ts_pnlic','nep_glb_ts_pnlic','npp_glb_ts_pnlic','hr_glb_ts_pnlic',...
        'nee_glb_ts_pnl','nep_glb_ts_pnl','npp_glb_ts_pnl','hr_glb_ts_pnl',...
        'nee_glb_ts_nul','nep_glb_ts_nul','npp_glb_ts_nul','hr_glb_ts_nul',...
        'nee_glb_ts_mnl','nep_glb_ts_mnl','npp_glb_ts_mnl','hr_glb_ts_mnl');
end


[neet_pnlo2100,nept_pnlo2100,nppt_pnlo2100,hrt_pnlo2100,...
    neet_pnlo2300,nept_pnlo2300,nppt_pnlo2300,hrt_pnlo2300]=printflux('PNLO',nee_glb_ts_pnlo,nep_glb_ts_pnlo,npp_glb_ts_pnlo,hr_glb_ts_pnlo);

[neet_pnlic2100,nept_pnlic2100,nppt_pnlic2100,hrt_pnlic2100,...
    neet_pnlic2300,nept_pnlic2300,nppt_pnlic2300,hrt_pnlic2300]=printflux('PNLIC',nee_glb_ts_pnlic,nep_glb_ts_pnlic,npp_glb_ts_pnlic,hr_glb_ts_pnlic);

[neet_pnl2100,nept_pnl2100,nppt_pnl2100,hrt_pnl2100,...
    neet_pnl2300,nept_pnl2300,nppt_pnl2300,hrt_pnl2300]=printflux('PNL',nee_glb_ts_pnl,nep_glb_ts_pnl,npp_glb_ts_pnl,hr_glb_ts_pnl);

[neet_nul2100,nept_nul2100,nppt_nul2100,hrt_nul2100,...
    neet_nul2300,nept_nul2300,nppt_nul2300,hrt_nul2300]=printflux('NUL',nee_glb_ts_nul,nep_glb_ts_nul,npp_glb_ts_nul,hr_glb_ts_nul);

[neet_mnl2100,nept_mnl2100,nppt_mnl2100,hrt_mnl2100,...
    neet_mnl2300,nept_mnl2300,nppt_mnl2300,hrt_mnl2300]=printflux('MNL',nee_glb_ts_mnl,nep_glb_ts_mnl,npp_glb_ts_mnl,hr_glb_ts_mnl);


fprintf('%s\n','2100');
fprintf('%10s %20s %20s %20s %20s\n','model','NEE','NEP','NPP','HR'); 
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','MNL',neet_mnl2100,nept_mnl2100,nppt_mnl2100,hrt_mnl2100);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','NUL',neet_nul2100,nept_nul2100,nppt_nul2100,hrt_nul2100);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','PNL',neet_pnl2100,nept_pnl2100,nppt_pnl2100,hrt_pnl2100);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','PNLIC',neet_pnlic2100,nept_pnlic2100,nppt_pnlic2100,hrt_pnlic2100);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','PNLO',neet_pnlo2100,nept_pnlo2100,nppt_pnlo2100,hrt_pnlo2100);


fprintf('%s\n','2300');
fprintf('%10s %20s %20s %20s %20s\n','model','NEE','NEP','NPP','HR'); 
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','MNL',neet_mnl2300,nept_mnl2300,nppt_mnl2300,hrt_mnl2300);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','NUL',neet_nul2300,nept_nul2300,nppt_nul2300,hrt_nul2300);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','PNL',neet_pnl2300,nept_pnl2300,nppt_pnl2300,hrt_pnl2300);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','PNLIC',neet_pnlic2300,nept_pnlic2300,nppt_pnlic2300,hrt_pnlic2300);
fprintf('%10s %20.10f %20.10f %20.10f %20.10f\n','PNLO',neet_pnlo2300,nept_pnlo2300,nppt_pnlo2300,hrt_pnlo2300);





end


function [nee,nep,npp,hr]=get_flux_ts(ncf,area,area_sum_m2)

var_nep='NEP';
var_hr='HR';
var_npp='NPP';
var_nee='NEE';
tdays=get_tdays(2001, 2300);

tsecs=tdays.*86400;

g2Pg=1d-15;

data=netcdf(ncf,'var',var_nep);nep=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_npp);npp=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_hr);hr=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

data=netcdf(ncf,'var',var_nee);nee=flux_area_avg(data,area).*tsecs.*area_sum_m2.*g2Pg;

end


function [neet2100,nept2100,nppt2100,hrt2100,...
    neet2300,nept2300,nppt2300,hrt2300]=printflux(model, nee,nep,npp,hr)

fprintf('-------------------------------------------------\n');
fprintf('%s\n',model);

fprintf('%6s %20s %20s %20s %20s\n','time','NEE','NEP','NPP','HR');

yr=2001;

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
        if(yr==2101)
            neet2100=cnee(j);
            nept2100=cnep(j);
            nppt2100=cnpp(j);
            hrt2100=chr(j);            
        end
    end
    

end
neet2300=cnee(end);
nept2300=cnep(end);
nppt2300=cnpp(end);
hrt2300=chr(end);
end

