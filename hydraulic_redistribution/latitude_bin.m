function bin_out_mean=latitude_bin(dat2d,latdim)
%bin the 2d data along the latitude dimension
%assume bad data are screened with nan


if(latdim==1)
    len=size(dat2d,1);
    bin_out_mean=zeros(len,1);
    for j = 1 : len        
        id=find(~isnan(dat2d(j,:)));
        if(isempty(id))
            bin_out_mean(j)=0./0.;
        else
            bin_out_mean(j)=mean(dat2d(j,id));
        end
    end
else
    len=size(dat2d,2);
    bin_out_mean=zeros(len,1);
  
    for j = 1 : len        
        id=find(~isnan(dat2d(:,j)));
        if(isempty(id))
            bin_out_mean(j)=0./0.;
        else
            bin_out_mean(j)=mean(dat2d(id,j));          
        end
    end
end
end