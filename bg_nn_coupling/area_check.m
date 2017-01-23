close all;
clear all;
clc;

area=netcdf('area_rcp.nc','var','area');

lon=netcdf('area_rcp.nc','var','lon');

lat=netcdf('area_rcp.nc','var','lat');

area_sum_m2_glb=get_area_sum(area);
   
tdays=get_tdays(2001, 2300);    

tsecs=tdays.*86400;

tropid=(lat > -23.2) & (lat <= 23.2);
arcid= (lat > 66.0 );
tempid=(lat > 23.2) & (lat <= 66.0);


t23south=lat<=-23.2;
t23north=lat>-23.2;


areatrop=area;areatrop(:,~tropid)=0./0.;

areatemp=area;areatemp(:,~tempid)=0./0.;

areaarc=area;areaarc(:,~arcid)=0./0.;

areat23south=area;areat23south(:,~t23south)=0./0.;
areat23north=area;areat23north(:,~t23north)=0./0.;

area_sum_m2_trop=get_area_sum(areatrop);
area_sum_m2_temp=get_area_sum(areatemp);
area_sum_m2_arc=get_area_sum(areaarc);
area_sum_m2_23south=get_area_sum(areat23south);
area_sum_m2_23north=get_area_sum(areat23north);


area_dif=zeros(size(area));
for j1 = 1 : size(area,1)
    for j2= 1 : size(area,2)
        
        area_dif(j1,j2)=area(j1,j2);
        if(~isnan(areat23south(j1,j2)))
            area_dif(j1,j2)=area_dif(j1,j2)-areat23south(j1,j2);
        end
        
        if(~isnan(areat23north(j1,j2)))
            area_dif(j1,j2)=area_dif(j1,j2)-areat23north(j1,j2);
        end
    end
end
