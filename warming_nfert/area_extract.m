function area=area_extract(region)

%load the latitude
lat=netcdf('/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/lat.nc','var','lat');
lon360=netcdf('/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/lon.nc','var','lon');
ncf1='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/area.nc';
ncf='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/I1850-2000bgcvrt60N_control/GPP.I1850-2000bgcvrt60N_control.1980-2000.nc';
varname='GPP';
%load flux
data=netcdf(ncf,'var',varname);
id0=find(lat>60);
dat0=data(:,id0,:);
dat=netcdf(ncf1,'var','area');
area0=dat(:,id0);
if(region==1)
    %North America
    %longitude between -173 ~ -30
    %id  -173 + 360, -30+360
    lbd=-173+360;
    rbd=-30+360;
    id1=find(lon360>=lbd & lon360<=rbd);
    dat1=dat0(id1,:,:);
    area1=area0(id1,:);
elseif(region==2)
    %EuroAsia
    lbd=-173+360;
    rbd=-30+360;
    id1=find(lon360<lbd | lon360>rbd);    
    dat1=dat0(id1,:,:);
    area1=area0(id1,:);
else
    %overall
    dat1=dat0;
    area1=area0;
end

id1=find(abs(dat1(:,:,1))<1.d10);
area=area1(id1);
end