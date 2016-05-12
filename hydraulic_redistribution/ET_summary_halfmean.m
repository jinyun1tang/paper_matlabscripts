function [mean_et1,mean_et2]=ET_summary_halfmean(ncf_soil, ncf_vege, ncf_vegt)
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

len=size(qet_ref,3);

len2=fix(len/2);
mean_et1=multiyear_average(qet_ref(:,:,1:len2));

mean_et2=multiyear_average(qet_ref(:,:,len2+1:len));



end