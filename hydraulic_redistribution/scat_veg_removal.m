close all;
clear all;
clc;
%here tests whether the inclusion of hd has reduced the ET bias
%the idea to look at the precipitation-\delta ET relationship
%six models are considered, default, hd, cosby4, cosby4-hd
%noilhan, noilhan-hd
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';


%reference
chdir='clm45evaphdr_ref';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf2=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];
ncf3=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];
ncf_map=[mdir,'area_info.nc'];
qsoil=netcdf(ncf1,'var','QSOIL');
qvegt=netcdf(ncf2,'var','QVEGT');
qvege=netcdf(ncf3,'var','QVEGE');
id=find(abs(qsoil)>1d3);
qsoil(id)=0./0.;
qet_ref=(qsoil+qvegt+qvege).*86400;

qet_ref_ave=mean(qet_ref,3);
%[c,h]=contourf(qet_ref_ave');set(h,'color','none');colorbar;
chdir='clm45evapdef_bs';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf2=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];
ncf3=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];

qsoil=netcdf(ncf1,'var','QSOIL');
qvegt=netcdf(ncf2,'var','QVEGT');
qvege=netcdf(ncf3,'var','QVEGE');
id=find(abs(qsoil)>1d3);
qsoil(id)=0./0.;
qethdr_ref=(qsoil+qvegt+qvege).*86400;


etdif_hdr=qethdr_ref-qet_ref;


sz1=size(etdif_hdr,1);
sz2=size(etdif_hdr,2);
etdif_hdr_mon1=zeros(sz1,sz2,12);
nyr=10;
for j1 = 1 : sz1
    for j2 = 1 : sz2
        etdif_hdr_mon1(j1,j2,:)=mean(reshape(squeeze(etdif_hdr(j1,j2,:)),[12,nyr]),2);      
    end
end

chdir='clm45evapdef';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf2=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];
ncf3=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];
ncf_map=[mdir,'area_info.nc'];
qsoil=netcdf(ncf1,'var','QSOIL');
qvegt=netcdf(ncf2,'var','QVEGT');
qvege=netcdf(ncf3,'var','QVEGE');
id=find(abs(qsoil)>1d3);
qsoil(id)=0./0.;
qet_ref=(qsoil+qvegt+qvege).*86400;


etdif_hdr=qethdr_ref-qet_ref;


sz1=size(etdif_hdr,1);
sz2=size(etdif_hdr,2);
etdif_hdr_mon2=zeros(sz1,sz2,12);
nyr=10;
for j1 = 1 : sz1
    for j2 = 1 : sz2
        etdif_hdr_mon2(j1,j2,:)=mean(reshape(squeeze(etdif_hdr(j1,j2,:)),[12,nyr]),2);      
    end
end

id=find(~isnan(etdif_hdr_mon2));

h=scatter(etdif_hdr_mon1(id),etdif_hdr_mon2(id),4);set(h,'MarkerFaceColor','k');
line([-4,2],[-4,2]);
