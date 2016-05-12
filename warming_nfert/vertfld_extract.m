function vrtfld=vertfld_extract(varname,ncf,region)

%load the latitude
lat=netcdf('/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/lat.nc','var','lat');
lon360=netcdf('/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/lon.nc','var','lon');

%load flux
data=netcdf(ncf,'var',varname);
id0=find(lat>60);
dat0=data(:,id0,:,:);
if(region==1)
    %North America
    %longitude between -173 ~ -30
    %id  -173 + 360, -30+360
    lbd=-173+360;
    rbd=-30+360;
    id1=find(lon360>=lbd & lon360<=rbd);
    dat1=dat0(id1,:,:,:);
elseif(region==2)
    %EuroAsia
    lbd=-173+360;
    rbd=-30+360;
    id1=find(lon360<lbd | lon360>rbd);    
    dat1=dat0(id1,:,:,:);
else
    %overall
    dat1=dat0;
end

id1=find(abs(dat1(:,:,1,1))<1.d10);
%now reshape
len1=size(dat1,3);
len2=size(dat1,4);
vrtfld=zeros(length(id1),len1,len2);
for k = 1 : len1
    for j = 1 : len2
        dt=dat1(:,:,k,j);
        vrtfld(:,k,j)=dt(id1);
    end
end
end