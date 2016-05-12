function [data_ctl,zdep] = cn_siteextract_depvar(varname,ntype)
%varname='NEE';

mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
if(strcmp(ntype,'ctl'))
    ncf=[mdir,'I1850-2000bgcvrt60N-CN_control/',varname,'.I1850-2000bgcvrt60N-CN_control.1980-2000.nc'];
elseif(strcmp(ntype,'otc'))
    ncf=[mdir,'I1980-2000bgc60N-CN_OTC/',varname,'.I1980-2000bgc60N-CN_OTC.1980-2000.nc'];
elseif(strcmp(ntype,'n.02'))
    ncf=[mdir,'I1980-2000bgc60N-CN_T0.0_N.02/',varname,'.I1980-2000bgc60N-CN_T0.0_N.02.1980-2000.nc'];    
elseif(strcmp(ntype,'n.1'))
    ncf=[mdir,'I1980-2000bgc60N-CN_T0.0_N.1/',varname,'.I1980-2000bgc60N-CN_T0.0_N.1.1980-2000.nc'];
elseif(strcmp(ntype,'n.2'))
    ncf=[mdir,'I1980-2000bgc60N-CN_T0.0_N.2/',varname,'.I1980-2000bgc60N-CN_T0.0_N.2.1980-2000.nc'];
elseif(strcmp(ntype,'n.3'))
    ncf=[mdir,'I1980-2000bgc60N-CN_T0.0_N.3/',varname,'.I1980-2000bgc60N-CN_T0.0_N.3.1980-2000.nc'];
elseif(strcmp(ntype,'n.4'))
    ncf=[mdir,'I1980-2000bgc60N-CN_T0.0_N.4/',varname,'.I1980-2000bgc60N-CN_T0.0_N.4.1980-2000.nc'];
elseif(strcmp(ntype,'n.5'))
    ncf=[mdir,'I1980-2000bgc60N-CN_T0.0_N.5/',varname,'.I1980-2000bgc60N-CN_T0.0_N.5.1980-2000.nc'];
end







region=0;
ndim=3;
nlay=3;
[fld,lon_f,lat_f]=vertfld_grid_extract(varname,ncf,region);
[data_ctl,zdep]=int_depth(fld,ndim,nlay);

end