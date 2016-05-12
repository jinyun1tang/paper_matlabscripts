close all;
clear all;
clc;


mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';


ref_files={'clm45evapcosby4','clm45evapdef','clm45evapnoilhan'};
bare_soil_files={'clm45evapcosby4_bs','clm45evapdef_bs','clm45evapnoilhan_bs'};

%reference

%chdir='clm45evaphdr_kx10';
j=1;
for j = 1 : length(ref_files)
    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.50-59.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.50-59.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.50-59.nc'];
    
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt);
    %obtain ET for bare soil runs
    ncf_soil=[mdir,bare_soil_files{j},'/','QSOIL','.',bare_soil_files{j},'.50-59.nc'];
    mean_et_baresoil=ET_summary(ncf_soil);
    
end