close all;
clear all;
clc;
%
ncf1='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pch.nc';
ncf2='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet.nc';
ncf3='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_beta.nc';
ncf_map='/Users/jinyuntang/work/data_collection/clm_output/DiffBound/map_info.nc';
pft_lunit=netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_itype_lunit');
lon_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_ixy');
lat_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_jxy');
id2=find(pft_lunit==1);
area=netcdf(ncf_map,'var','area');

scr=zeros(144,96);
for k = 1 : length(id2)        
    scr(lon_id(id2(k)),lat_id(id2(k)))=1.;
end

area=area.*scr;
tarea=sum(sum(area));
id=(1:60);
%QVEGT
var='QVEGT';
mqvegt_ch=get_yrmean(ncf1,area,id,var,tarea);
mqvegt_chbet=get_yrmean(ncf2,area,id,var,tarea);
mqvegt_chbet_beta=get_yrmean(ncf3,area,id,var,tarea);
%QVEGE
var='QVEGE';
mqvege_ch=get_yrmean(ncf1,area,id,var,tarea);
mqvege_chbet=get_yrmean(ncf2,area,id,var,tarea);
mqvege_chbet_beta=get_yrmean(ncf3,area,id,var,tarea);

%QSOIL
var='QSOIL';
mqsoil_ch=get_yrmean(ncf1,area,id,var,tarea);
mqsoil_chbet=get_yrmean(ncf2,area,id,var,tarea);
mqsoil_chbet_beta=get_yrmean(ncf3,area,id,var,tarea);

meet_ch=mqvegt_ch+mqvege_ch+mqsoil_ch;
meet_chbet=mqvegt_chbet+mqvege_chbet+mqsoil_chbet;
meet_chbet_beta=mqvegt_chbet_beta+mqvege_chbet_beta+mqsoil_chbet_beta;

%QINFL
var='QINFL';
mqinfil_ch=get_yrmean(ncf1,area,id,var,tarea);
mqinfil_chbet=get_yrmean(ncf2,area,id,var,tarea);
mqinfil_chbet_beta=get_yrmean(ncf3,area,id,var,tarea);

%QOVER
var='QOVER';
mqover_ch=get_yrmean(ncf1,area,id,var,tarea);
mqover_chbet=get_yrmean(ncf2,area,id,var,tarea);
mqover_chbet_beta=get_yrmean(ncf3,area,id,var,tarea);

%QDRAI
var1='QDRAI';var2='QDRAI_PERCH';
mqdrai_ch=get_yrmean(ncf1,area,id,var1,tarea)+get_yrmean(ncf1,area,id,var2,tarea);
mqdrai_chbet=get_yrmean(ncf2,area,id,var1,tarea)+get_yrmean(ncf2,area,id,var2,tarea);
mqdrai_chbet_beta=get_yrmean(ncf3,area,id,var1,tarea)+get_yrmean(ncf3,area,id,var2,tarea);


fprintf('%-10s,%-14s,%-14s,%-14s,%-14s,%-10s,%-10s,%-10s\n', 'Exp','transpiration',...
    'canopy evaporation', 'soil evaporation','total ET','QINFIL','QOVER','QDRAI');
fprintf('%-10s,%-7.3f,%-7.3f,%-7.3f,%-7.3f,%-7.3f,%-7.3f,%-14.7f,%-10.4f,%-10.4f,%-10.4f\n','ch',...
    mqvegt_ch./meet_ch*100,mqvegt_ch,...
    mqvege_ch./meet_ch*100,mqvege_ch,...
    mqsoil_ch./meet_ch*100,mqsoil_ch,...
    meet_ch,mqinfil_ch,mqover_ch,mqdrai_ch);
fprintf('%-10s,%-7.3f,%-7.3f,%-7.3f,%-7.3f,%-7.3f,%-7.3f,%-14.7f,%-10.4f,%-10.4f,%-10.4f\n','chbet',...
    mqvegt_chbet./meet_chbet*100,mqvegt_chbet,...
    mqvege_chbet./meet_chbet*100,mqvege_chbet,...
    mqsoil_chbet./meet_chbet*100,mqsoil_chbet,...
    meet_chbet,mqinfil_chbet,mqover_chbet,mqdrai_chbet);

fprintf('%-10s,%-7.3f,%-7.3f,%-7.3f,%-7.3f,%-7.3f,%-7.3f,%-14.7f,%-10.4f,%-10.4f,%-10.4f\n','chbet_beta',...
    mqvegt_chbet_beta./meet_chbet_beta*100,mqvegt_chbet_beta,...
    mqvege_chbet_beta./meet_chbet_beta*100,mqvege_chbet_beta,...
    mqsoil_chbet_beta./meet_chbet_beta*100,mqsoil_chbet_beta,...
    meet_chbet_beta,mqinfil_chbet_beta,mqover_chbet_beta,mqdrai_chbet_beta);
