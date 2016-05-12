function [ts,ts_tot]=area_weight(dat3d,area)
%return area weighted mean of the given 3d variable

len=size(dat3d,3);
ts=zeros(len,1);

ts_tot=ts;
for jj = 1 : len
    dat2d=squeeze(dat3d(:,:,jj));

    id=find((~isnan(dat2d)) & (~isnan(area)));
    totarea=sum(area(id));
    ts_tot(jj)=sum(dat2d(id).*area(id));
    ts(jj)=ts_tot(jj)/totarea;

end