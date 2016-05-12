close all;
clear all;
clc;
ncf1='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/pch_fsh_bare_soi.nc.nc';
ncf2='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/pchbet_fsh_bare_soi_new.nc';
ncf3='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/pch_fsh_beta_bare_soi_new.nc';
%ncf3='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/qflx_pchbet_bare_soi_lit_new.nc';
ncf4='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/pchbet_fsh_beta_bare_soi.nc';

ncf_map='/Users/jinyuntang/work/data_collection/clm_output/DiffBound/map_info.nc';
pft_lunit=netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_itype_lunit');
lon_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_ixy');
lat_id = netcdf('/Users/jinyuntang/work/data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_jxy');
id2=find(pft_lunit==1);
%read map info

tsum=86400;
area=netcdf(ncf_map,'var','area');
lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
lon=circshift(lon,dshft);
wt=[31,28,31,30,31,30,31,31,30,31,30,31]';
wt=repmat(wt,[5,1]);
scr=zeros(144,96);
for k = 1 : length(id2)        
    scr(lon_id(id2(k)),lat_id(id2(k)))=1.;
end
id1=find(scr==0.0);
scr(id1)=0./0.;
area(id1)=0.0;
clear id1;
var='FSH';
id=(1:60);

mam=[3,4,5];
jja=[6,7,8];
son=[9,10,11];
djf=[12,1,2];
id_season(:,1)=[mam,mam+12,mam+24,mam+36,mam+48];
id_season(:,2)=[jja,jja+12,jja+24,jja+36,jja+48];
id_season(:,3)=[son,son+12,son+24,son+36,son+48];
id_season(:,4)=[djf,djf+12,djf+24,djf+36,djf+48];
days_season(1)=31+30+31;
days_season(2)=30+31+31;
days_season(3)=30+31+30;
days_season(4)=31+31+28;

%cm=colormap(jet);
area=area';
dfyr=zeros(96,144);
q_chbet=zeros(96,144);
q_ch_beta=zeros(96,144);
for j = 1 : 4
    for k = 1 : 5
        id1=(1:3)+(k-1)*3;
    %qsoi_ch=get_clm_data(ncf1, var, id_season(:,j),wt,scr, dshft);
        qsoi_chbet=get_clm_data(ncf2, var, id_season(id1,j),wt(id_season(id1,j)),scr, dshft);
        qsoi_ch_beta=get_clm_data(ncf3, var, id_season(id1,j),wt(id_season(id1,j)),scr, dshft);
    %qsoi_chbet_beta=get_clm_data(ncf4, var,id,wt,scr, dshft);
    

        df=qsoi_chbet'-qsoi_ch_beta';
        q_chbet=q_chbet+qsoi_chbet'.*days_season(j)./365;
        q_ch_beta=q_ch_beta+qsoi_ch_beta'.*days_season(j)./365;        
        dfyr(:,:)=dfyr(:,:)+df.*days_season(j)./365;
        
    %df=-df;
        id_n=find(isnan(df)==0);    
        dfs(j,k)=sum(df(id_n).*area(id_n))./sum(area(id_n))
    end

end
id_n=find(isnan(dfyr)==0);    
sum(dfyr(id_n).*area(id_n))./sum(area(id_n))
