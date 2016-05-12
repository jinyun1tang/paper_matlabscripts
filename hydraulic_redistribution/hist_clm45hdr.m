close all;
clear all;
clc;
%here tests whether the inclusion of hd has reduced the ET bias

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';


%reference
chdir='clm45evaphdr_ref';
chdir='clm45evapdef';
%chdir='clm45evaphdr_kx10';

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
etdif_hdr_mon=zeros(sz1,sz2,12);
nyr=10;
for j1 = 1 : sz1
    for j2 = 1 : sz2
        etdif_hdr_mon(j1,j2,:)=mean(reshape(squeeze(etdif_hdr(j1,j2,:)),[12,nyr]),2);      
    end
end

area=netcdf(ncf_map,'var','area');
lat=netcdf(ncf_map,'var','lat');

etdif_band=zeros(sz2,12*nyr);
for j = 1 : sz2
    darea=area(:,j);
    dat=squeeze(etdif_hdr(:,j,:));
    id=find(abs(darea)<1d30);
    
    etdif_band(j,:)=darea(id)'*dat(id,:)./sum(darea(id));
end
id=find(etdif_band<-1.5);
etdif_band(id)=-1.51;
%reset
[c,h]=contourf((1:120),lat,etdif_band,(-1.51:0.1:1.5));colorbar;set(h,'color','none');
