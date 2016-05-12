function pct=get_pft(pft)
ncf='/Users/jinyuntang/work/programming/ncl_learning/data/surfdata_1.9x2.5_simyr2000_c091005.nc';

pct_pft=netcdf(ncf,'var','PCT_PFT');
pct=squeeze(pct_pft(:,:,pft));