function [fld,lon_f,lat_f]=vertfld_grid_extract(varname,ncf,region)

%load the latitude
lat=netcdf('/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/lat.nc','var','lat');
lon360=netcdf('/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/lon.nc','var','lon');

%load flux
data=netcdf(ncf,'var',varname);
id0=find(lat>60);
lat_f=lat(id0);
dat0=data(:,id0,:,:);
if(region==1)
    %North America
    %longitude between -173 ~ -30
    %id  -173 + 360, -30+360
    lbd=-173+360;
    rbd=-30+360;
    id1=find(lon360>=lbd & lon360<=rbd);
    dat1=dat0(id1,:,:,:);
    lon_f=lon360(id1);
elseif(region==2)
    %EuroAsia
    lbd=-173+360;
    rbd=-30+360;
    id1=find(lon360<lbd | lon360>rbd);    
    dat1=dat0(id1,:,:,:);
    lon_f=lon360(id1);
else
    %overall
    dat1=dat0;
    lon_f=lon360;
end

id1=find(abs(dat1)>1.d10);
fld=dat1;
fld(id1)=0./0.;
%now reshape

end