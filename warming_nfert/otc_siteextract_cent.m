function dat = otc_siteextract_cent(varname,iloc,jloc,ntype)
%varname='NEE';

mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
if(strcmp(ntype,'ctl'))
    ncf=[mdir,'I1850-2000bgcvrt60N_control/',varname,'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
else
    ncf=[mdir,'I1980-2000petbcent_OTC/',varname,'.I1980-2000petbcent_OTC.1980-2000.nc'];
end







region=0;
[data_ctl,lon_v,lat_v]=flux_grid_extract(varname,ncf,region);

dat=squeeze(data_ctl(iloc,jloc,:));
end