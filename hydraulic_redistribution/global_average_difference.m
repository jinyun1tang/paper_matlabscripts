close all;
clear all;
clc;

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

ncf_map=[mdir,'area_info.nc'];
area=netcdf(ncf_map,'var','area');

%averaging coefficients
w_djf=[31,28,0,0,0,0,0,0,0,0,0,31]./(31+28+31);
w_mam=[0,0,31,30,31,0,0,0,0,0,0,0]./(31+31+30);
w_jja=[0,0,0,0,0,30,31,31,0,0,0,0]./(31+31+30);
w_son=[0,0,0,0,0,0,0,0,30,31,30,0]./(31+30+30);

w_annual=(w_djf+w_mam+w_jja+w_son)./sum(w_djf+w_mam+w_jja+w_son);

ref_files={'clm45evapcosby4','clm45evapdef','clm45evapnoilhan',...
    'clm45hdr_maxlai_ref','clm45evaphdr_maxlai_kx0.1','clm45evaphdr_maxlai_kx10',...
    'cruclm45def','cruclm45hd_maxlai_ref'};
bare_soil_files={'clm45evapcosby4_bs','clm45evapdef_bs',...
    'clm45evapnoilhan_bs','clm45evapdef_bs','clm45evapdef_bs',...
    'clm45evapdef_bs','cruclm45_baresoi','cruclm45_baresoi'};

for j = 1 : length(ref_files)
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.51-60.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.51-60.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.51-60.nc'];
    
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);

    %obtain ET for bare soil runs
    ncf_soil=[mdir,bare_soil_files{j},'/','QSOIL','.',bare_soil_files{j},'.51-60.nc'];
    mean_et_baresoil=ET_summary(ncf_soil,'','',0);

    areal_et_dif_field=mean_et_baresoil-mean_et_veg;
    areal_et_dif_ts=area_weight(areal_et_dif_field,area);
    
    mean_etdif_djf=mean(slidew_mean(areal_et_dif_ts,12,w_djf));
    mean_etdif_mam=mean(slidew_mean(areal_et_dif_ts,12,w_mam));
    mean_etdif_jja=mean(slidew_mean(areal_et_dif_ts,12,w_jja));
    mean_etdif_son=mean(slidew_mean(areal_et_dif_ts,12,w_son));  
    
    std_etdif_djf=std(slidew_mean(areal_et_dif_ts,12,w_djf));
    std_etdif_mam=std(slidew_mean(areal_et_dif_ts,12,w_mam));
    std_etdif_jja=std(slidew_mean(areal_et_dif_ts,12,w_jja));
    std_etdif_son=std(slidew_mean(areal_et_dif_ts,12,w_son));      
    fprintf('ref=%s\n',ref_files{j});
    fprintf('seasonal: spring=%f(%f),summer=%f(%f),autum=%f(%f),winter=%f(%f)\n',...
        mean_etdif_mam,std_etdif_mam,...
        mean_etdif_jja,std_etdif_jja,...
        mean_etdif_son,std_etdif_son,...
        mean_etdif_djf,std_etdif_djf);
    
    mean_etdif_annual=mean(slidew_mean(areal_et_dif_ts,12,w_annual));
    std_etdif_annual=std(slidew_mean(areal_et_dif_ts,12,w_annual));
    fprintf('annual:%f(%f)\n',mean_etdif_annual,std_etdif_annual);
    fprintf('\n');
    
    
end










