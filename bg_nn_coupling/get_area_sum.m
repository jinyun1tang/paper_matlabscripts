function area_sum_m2=get_area_sum(area)

%get total area, 

km2m2 = 1.e6;

id=area>0;

area_sum_m2=sum(double(area(id)))*double(km2m2);


end