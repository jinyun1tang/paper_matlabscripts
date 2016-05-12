
function dat=get_clm_data(ncf, var, id, wt, scr, dshft)

data=netcdf(ncf,'var',var);
dat=zeros(size(data,1),size(data,2));
twt=sum(wt);
for j1 = 1 : size(data,1)
    for j2 = 1 : size(data,2)
        dat(j1,j2) = sum(squeeze(data(j1,j2,id)).*wt)./twt;
    end
end

clear data;
dat=dat.*scr;
if(nargin==6)
    dat=double(circshift(dat,dshft));
end