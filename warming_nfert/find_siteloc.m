function [iloc,jloc]=find_siteloc(lon_v,lat_v,lon_p,lat_p)
r_lon=abs(lon_v(2)-lon_v(1))/2;
r_lat=abs(lat_v(2)-lat_v(1))/2;
iloc=find(abs(lon_v-lon_p+eps)<=r_lon);
jloc=find(abs(lat_v-lat_p)<=r_lat);
end