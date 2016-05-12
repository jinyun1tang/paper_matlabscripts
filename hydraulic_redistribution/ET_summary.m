function mean_et=ET_summary(ncf_soil, ncf_vege, ncf_vegt,do_avg)
%derive the ET difference between two input files
if(nargin==3)
    do_avg=1;
end
qsoil=netcdf(ncf_soil,'var','QSOIL');
if(~isempty(ncf_vege))
    qvege=netcdf(ncf_vege,'var','QVEGE');
else
    qvege=0.;
end
if(~isempty(ncf_vegt))
    qvegt=netcdf(ncf_vegt,'var','QVEGT');
else
    qvegt=0.;
end

id=find(abs(qsoil)>1d3);

qsoil(id)=0./0.;

qet_ref=(qsoil+qvegt+qvege).*86400;   %convert from mm seconds to mm day

if(do_avg)
    mean_et=multiyear_average(qet_ref);
else
    mean_et=qet_ref;
end

end