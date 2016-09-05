function data_out=flux_area_avg(data_in,area)
%calcualte the average area of the flux variable

len=size(data_in,3);

data_out=zeros(len,1);


id=area>0;

area_sum=sum(area(id));
for j = 1 : len
    data_loc=squeeze(data_in(:,:,j));
    data_out(j)=sum(data_loc(id).*area(id))/area_sum;
end

end