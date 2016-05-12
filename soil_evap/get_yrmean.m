function mqflx=get_yrmean(ncf,area,id,var,tarea)


data=netcdf(ncf,'var',var);
qflx=mean(data(:,:,id),3);
qflx=qflx.*area;
mqflx=sum(sum(qflx))./tarea.*86400;
