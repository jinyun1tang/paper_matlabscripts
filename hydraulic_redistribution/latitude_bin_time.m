function [bin_out_mean,bin_out_std]=latitude_bin_time(dat3d,latdim,cday)
%bin the 3d data along the latitude dimension
%assume bad data are screened with nan, and assume 


if(latdim==1)
    len1=size(dat3d,1);
    len2=size(dat3d,3);
    bin_out_mean1=zeros(len1,len2);
  
else
    len1=size(dat3d,2);
    len2=size(dat3d,3);
    bin_out_mean1=zeros(len1,len2);
  
end
if(len2~=length(cday))
    error('weighting factor does not register with input data');
end
for j2 = 1 : len2        
    bin_out_mean1(:,j2)=latitude_bin(squeeze(dat3d(:,:,j2)),latdim);
end

nyr=fix(len2/12);
bin_out_mean2=zeros(len1,nyr);
for n = 1 : nyr
    id1=(n-1)*12+1;
    id2=n*12;
    bin_out_mean2(:,n)=wmean(bin_out_mean1(:,id1:id2),...
        reshape(cday(id1:id2),[1,12]),2);
end
bin_out_mean=mean(bin_out_mean2,2);
bin_out_std=std(bin_out_mean2,[],2);

end