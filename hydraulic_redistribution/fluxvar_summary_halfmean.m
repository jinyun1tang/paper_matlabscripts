function [mean_et1,mean_et2]=fluxvar_summary_halfmean(ncf_soil, varname)
%derive the ET difference between two input files
if(nargin==2)
    do_avg=1;
end
qsoil=netcdf(ncf_soil,'var',varname);


id=find(abs(qsoil)>1d3);

qsoil(id)=0./0.;

qet_ref=qsoil.*86400;   %convert from mm seconds to mm day



len=size(qet_ref,3);

len2=fix(len/2);
mean_et1=multiyear_average(qet_ref(:,:,1:len2));

mean_et2=multiyear_average(qet_ref(:,:,len2+1:len));

end