function mean_et=LH_summary(ncf_lh,do_avg)
%derive the ET difference between two input files
if(nargin==1)
    do_avg=1;
end
qsoil=netcdf(ncf_lh,'var','EFLX_LH_TOT');


id=find(abs(qsoil)>1d3);

qsoil(id)=0./0.; %W/m2


if(do_avg)
    mean_et=multiyear_average(qsoil);
else
    mean_et=qsoil;
end

end