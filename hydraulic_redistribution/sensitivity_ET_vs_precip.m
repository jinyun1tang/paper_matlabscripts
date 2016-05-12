close all;
clear all;
clc;
%compare the ET difference between cru and qian data

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
ncf_map=[mdir,'area_info.nc'];
cc={'b','r'};

%reference


    
chdir='clm45evapdef';

ncf_soil=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf_vegt=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];
ncf_vege=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];

qet_ref_qian=ET_summary(ncf_soil, ncf_vege, ncf_vegt,1);


chdir='clm45evaphdr_ref';


ncf_soil=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf_vegt=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];
ncf_vege=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];

qet_hd_qian=ET_summary(ncf_soil, ncf_vege, ncf_vegt,1);

%load precipitation
ncf_rain=[mdir,chdir,'/','RAIN','.',chdir,'.50-59.nc'];
ncf_snow=[mdir,chdir,'/','SNOW','.',chdir,'.50-59.nc'];

rain=fluxvar_summary(ncf_rain, 'RAIN',1);
snow=fluxvar_summary(ncf_snow, 'SNOW',1);
prec_qian=rain+snow;



chdir='cruclm45def';

ncf_soil=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf_vegt=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];
ncf_vege=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];


qet_ref_cru=ET_summary(ncf_soil, ncf_vege, ncf_vegt,1);


%do cru dataset
chdir='cruclm45hd_ref';
ncf_soil=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf_vegt=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];
ncf_vege=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];


qet_hd_cru=ET_summary(ncf_soil, ncf_vege, ncf_vegt,1);    
    

%load precipitation
ncf_rain=[mdir,chdir,'/','RAIN','.',chdir,'.50-59.nc'];
ncf_snow=[mdir,chdir,'/','SNOW','.',chdir,'.50-59.nc'];

rain=fluxvar_summary(ncf_rain, 'RAIN',1);
snow=fluxvar_summary(ncf_snow, 'SNOW',1);
prec_cru=rain+snow;


id=find(~isnan(prec_cru));
prec_new=prec_cru(id);
prec_dif=prec_cru(id)-prec_qian(id);
et_hddif=qet_hd_cru(id)-qet_ref_qian(id);
et_dif=qet_ref_cru(id)-qet_ref_qian(id);
prec_mean=(prec_cru(id)+prec_qian(id)).*0.5;

marksize=4;
fontsz=14;
ax(1)=subplot(2,1,1);
id1=find(prec_dif<0);
plot(prec_dif(id1),et_dif(id1),'.','MarkerSize',marksize);
hold on;
plot(prec_dif(id1),et_hddif(id1),'r.','MarkerSize',marksize);

[p1,stats1]=robustfit(prec_dif(id1),et_dif(id1));
[p2,stats2]=robustfit(prec_dif(id1),et_hddif(id1));

plot(prec_dif(id1),p1(2).*prec_dif(id1)+p1(1));
plot(prec_dif(id1),p2(2).*prec_dif(id1)+p2(1),'r');
xlim([-2,0]);

xlabel('\Delta Prec (mm day^-^1)','FontSize',fontsz);
ylabel('\Delta ET (mm day^-^1)','FontSize',fontsz);

set(gca,'FontSize',fontsz);
ax(2)=subplot(2,1,2);
id2=find(prec_dif>0);
plot(prec_dif(id2),et_dif(id2),'.','MarkerSize',marksize);
hold on;
plot(prec_dif(id2),et_hddif(id2),'r.','MarkerSize',marksize);

[p3,stats3]=robustfit(prec_dif(id2),et_dif(id2));
[p4,stats4]=robustfit(prec_dif(id2),et_hddif(id2));

plot(prec_dif(id2),p3(2).*prec_dif(id2)+p3(1));
plot(prec_dif(id2),p4(2).*prec_dif(id2)+p4(1),'r');

xlim([0,2]);
xlabel('\Delta Prec (mm day^-^1)','FontSize',fontsz);
ylabel('\Delta ET (mm day^-^1)','FontSize',fontsz);
set(gca,'FontSize',fontsz);
set(gcf,'color','w');

[lenh,hobj]=legend('CLM4.5-CRU vs CLM4.5','CLM4.5RHD-TM-CRU vs CLM4.5RHD-TM');
set(hobj(4),'MarkerSize',6);
set(hobj(6),'MarkerSize',6);
put_tag(gcf,ax(1),[.05,0.9],'(a)',14);
put_tag(gcf,ax(2),[.05,0.9],'(b)',14);
