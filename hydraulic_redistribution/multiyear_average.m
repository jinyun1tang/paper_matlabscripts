function dat2d_out=multiyear_average(dat3d_in)
%do temporal average for 3D CLM monthly mean ouptut

wt0=[31,28,31,30,31,30,31,31,30,31,30,31];
len=size(dat3d_in,3);
wt=repmat(wt0,[1,fix(len/12)]);

dat2d_out=wmean(dat3d_in,wt,3);

end