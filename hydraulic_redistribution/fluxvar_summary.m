function mean_et=fluxvar_summary(ncf_soil, varname,do_avg)
%derive the ET difference between two input files
if(nargin==2)
    do_avg=1;
end
qsoil=netcdf(ncf_soil,'var',varname);


id=find(abs(qsoil)>1d3);

qsoil(id)=0./0.;

qet_ref=qsoil.*86400;   %convert from mm seconds to mm day

if(do_avg)
    mean_et=multiyear_average(qet_ref);
else
    mean_et=qet_ref;
end

end