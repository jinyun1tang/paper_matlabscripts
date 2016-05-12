close all;
clear all;
clc;
%compare the ET difference between cru and qian data

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
ncf_map=[mdir,'area_info.nc'];

fig=figure(1);
ax=multipanel(fig,1,2,[0.1,0.1],[0.4,0.8],[0.05,0.05]);
cc={'b','r'};
for do_hd=0:1;
%reference
if(do_hd)
    chdir='clm45evaphdr_ref';
else    
    chdir='clm45evapdef';
end
%chdir='clm45evapcosby4';

ncf_soil=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf_vegt=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];
ncf_vege=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];

[qet_ref1,qet_ref2]=ET_summary_halfmean(ncf_soil, ncf_vege, ncf_vegt);



%load precipitation
ncf_rain=[mdir,chdir,'/','RAIN','.',chdir,'.50-59.nc'];
ncf_snow=[mdir,chdir,'/','SNOW','.',chdir,'.50-59.nc'];

[rain1,rain2]=fluxvar_summary_halfmean(ncf_rain, 'RAIN');
[snow1,snow2]=fluxvar_summary_halfmean(ncf_snow, 'SNOW');
prec_qian1=(rain1+snow1);
prec_qian2=(rain2+snow2);
if(do_hd)
    chdir='cruclm45hd_ref';
else    
    chdir='cruclm45def';
end
ncf_soil=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf_vegt=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];
ncf_vege=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];


[qet_cru1,qet_cru2]=ET_summary_halfmean(ncf_soil, ncf_vege, ncf_vegt);

etdif_hdr1=qet_cru1-qet_ref1;
etdif_hdr2=qet_cru2-qet_ref2;
%load precipitation
ncf_rain=[mdir,chdir,'/','RAIN','.',chdir,'.50-59.nc'];
ncf_snow=[mdir,chdir,'/','SNOW','.',chdir,'.50-59.nc'];

[rain1,rain2]=fluxvar_summary_halfmean(ncf_rain, 'RAIN');
[snow1,snow2]=fluxvar_summary_halfmean(ncf_snow, 'SNOW');

prec_cru1=(rain1+snow1);
prec_cru2=(rain2+snow2);

prec_dif1=prec_cru1-prec_qian1;
prec_dif2=prec_cru2-prec_qian2;

id=find(isnan(prec_dif1)==0);
set(fig,'CurrentAxes',ax(1));
hh(1+do_hd*2)=plot(prec_dif1(id),etdif_hdr1(id),'.','color',cc{do_hd+1});
[err,w]=fit_2D_data(prec_dif1(id),etdif_hdr1(id));
hold on;
dat=w(2).*prec_dif1(id)+w(1);
hh(2+do_hd*2)=plot(prec_dif1(id),w(2).*prec_dif1(id)+w(1),'LineWidth',2,'color',cc{do_hd+1});
[r2,p]=rsquare(etdif_hdr1(id),dat);
fprintf('slp=%f,int=%f,R2=%f,p=%f\n',w(2),w(1),r2,p);



set(fig,'CurrentAxes',ax(2));
hh(1+do_hd*2)=plot(prec_dif2(id),etdif_hdr2(id),'.','color',cc{do_hd+1});
[err,w]=fit_2D_data(prec_dif2(id),etdif_hdr2(id));
hold on;
dat=w(2).*prec_dif2(id)+w(1);
hh(2+do_hd*2)=plot(prec_dif2(id),w(2).*prec_dif2(id)+w(1),'LineWidth',2,'color',cc{do_hd+1});
[r2,p]=rsquare(etdif_hdr2(id),dat);
fprintf('slp=%f,int=%f,R2=%f,p=%f\n',w(2),w(1),r2,p);

end


set(ax,'FontSize',14,'Xlim',[-8,8],'Ylim',[-2,2]);
set(ax(2),'YTickLabel','');
set(fig,'CurrentAxes',ax(1));
xlabel('\DeltaPrec (mm day^-^1)','FontSize',14);
ylabel('\DeltaET (mm day^-^1)','FontSize',14);
set(fig,'CurrentAxes',ax(2));
xlabel('\DeltaPrec (mm day^-^1)','FontSize',14);

legend(hh([1,3]),'No-RHD','RHD-CM');



