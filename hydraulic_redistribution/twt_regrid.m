close all;
clear all;
%downscale twt data from CLM into 0.5x0.5 resolution


mdir ='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

chdir={'cruclm45def','cruclm45hd_maxlai_ref'};

varname='TWS';
j=2;
ncf=[mdir,chdir{j},'/',varname,'.',chdir{j},'.51-60.nc'];
lon=netcdf(ncf,'var','lon');
lat=netcdf(ncf,'var','lat');
dat=netcdf(ncf,'var',varname);
lon_g=(0.5:1:359.5);
lat_g=(-89.5:1:89.5);

[LON,LAT]=meshgrid(lon,lat);
[LON_G,LAT_G]=meshgrid(lon_g,lat_g);

len=size(dat,3);
dat_g=zeros(size(LON_G,1),size(LON_G,2),len);
for jj = 1 : len
    dat_g(:,:,jj)=interp2(LON,LAT,squeeze(dat(:,:,jj))',LON_G,LAT_G,'nearest');
end
dat_g=rm_nan(dat_g);
if(j==1)
    save('crudef_tws.mat','lon_g','lat_g','dat_g');
elseif(j==2)
    save('mat/cruclm45hdr_maxlai_ref.mat','lon_g','lat_g','dat_g');
end

