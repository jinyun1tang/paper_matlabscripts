function [iloc,jloc]=find_siteloc9(lon_v,lat_v,lon_p,lat_p)
r_lon=abs(lon_v(2)-lon_v(1))/2;
r_lat=abs(lat_v(2)-lat_v(1))/2;
iloc0=find(abs(lon_v-lon_p)<=r_lon);
jloc0=find(abs(lat_v-lat_p)<=r_lat);

iloc=zeros(9,1);
jloc=zeros(9,1);
if(isempty(iloc0) || isempty(jloc0))
    error('site is not located');
end
ilen=length(lon_v);
jlen=length(lat_v);

iloc(1)=iloc0(1);jloc(1)=jloc0(1); %center:
iloc(2)=iloc0(1)-1;jloc(2)=jloc0(1);%west
iloc(3)=iloc0(1)-1;jloc(3)=jloc0(1)+1;%northwest
iloc(4)=iloc0(1);jloc(4)=jloc0(1)+1;%north
iloc(5)=iloc0(1)+1;jloc(5)=jloc0(1)+1;%northeast
iloc(6)=iloc0(1)+1;jloc(6)=jloc0(1);%east
iloc(7)=iloc0(1)+1;jloc(7)=jloc0(1)-1;%southeast
iloc(8)=iloc0(1);jloc(8)=jloc0(1)-1;%south
iloc(9)=iloc0(1)-1;jloc(9)=jloc0(1)-1;%southwest

for jj = 1 : 9
    %circular for the longitude
    if(iloc(jj)<0)
        iloc(jj)=ilen;        
    end
    if(iloc(jj)>ilen)
        iloc(jj)=1;
    end
    
    if(jloc(jj)<=0 || jloc(jj)>jlen)
        iloc(jj)=-1;
        jloc(jj)=-1;
    end
end
%west: iloc(1)-1,jloc(1)
%northwest: iloc(1)-1,jlloc
end