%global_statistics_flux_mte

close all;
clear all;
clc;

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
ncf_map=[mdir,'area_info.nc'];
latv=netcdf(ncf_map,'var','lat');
area=netcdf(ncf_map,'var','area');
id=find(abs(area)>1d20);
area(id)=0./0.;


id_lat20=find(latv<=20);
area_n20=area;
area_n20(:,id_lat20)=0./0.;

id_latns20=find(latv<=-20 | latv>=20);
area_ns20=area;
area_ns20(:,id_latns20)=0./0.;

id_lats20=find(latv>-20);
area_s20=area;
area_s20(:,id_lats20)=0./0.;
%plot_opt='meanval';
load('mat/fluxnet_mte_clm.mat');

%use the 10 year mean for comparison
year1=1991;
year2=2000;

id1=(year1-year0)*12+1;
id2=(year2-year0+1)*12;

MJ2mm=1./2.501;
lh_subset=lh_mean2clm(:,:,id1:id2).*MJ2mm;


lh_tsn20=area_weight(lh_subset,area_n20);
lh_tsns20=area_weight(lh_subset,area_ns20);
lh_tss20=area_weight(lh_subset,area_s20);


ref_files={'clm45evapdef','clm45hdr_maxlai_ref','cruclm45def','cruclm45hd_maxlai_ref'};

fontsz=14;

fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.8,.8]);
ax=multipanel(fig,3,1,[.12,.1],[.8,.25],[.05,0.05]);
set(fig,'CurrentAxes',ax(1));

cc={'c','k','r','b'};
for j1=1:length(ref_files)    
    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j1},'/','QSOIL','.',ref_files{j1},'.51-60.nc'];
    ncf_vegt=[mdir,ref_files{j1},'/','QVEGT','.',ref_files{j1},'.51-60.nc'];
    ncf_vege=[mdir,ref_files{j1},'/','QVEGE','.',ref_files{j1},'.51-60.nc'];
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);
    
    mean_et_ts=area_weight(mean_et_veg,area_n20);

    dat=mean_et_ts-lh_tsn20;
    dat_m=reshape(dat,[12,10]);
    hh=errorbar((1:12),mean(dat_m,2),std(dat_m,[],2));
    fprintf('%s,%f\n',ref_files{j1},mean(mean(dat_m,2)));
    set(hh,'color',cc{j1},'lineWidth',2);
    hold on;
end



set(fig,'CurrentAxes',ax(2));
for j1=1:length(ref_files)    
    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j1},'/','QSOIL','.',ref_files{j1},'.51-60.nc'];
    ncf_vegt=[mdir,ref_files{j1},'/','QVEGT','.',ref_files{j1},'.51-60.nc'];
    ncf_vege=[mdir,ref_files{j1},'/','QVEGE','.',ref_files{j1},'.51-60.nc'];
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);
    
    mean_et_ts=area_weight(mean_et_veg,area_ns20);

    dat=mean_et_ts-lh_tsns20;
    dat_m=reshape(dat,[12,10]);
    
    hh=errorbar((1:12),mean(dat_m,2),std(dat_m,[],2));
    fprintf('%s,%f\n',ref_files{j1},mean(mean(dat_m,2)));
    set(hh,'color',cc{j1},'lineWidth',2);
    hold on;
end

set(fig,'CurrentAxes',ax(3));

for j1=1:length(ref_files)    
    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j1},'/','QSOIL','.',ref_files{j1},'.51-60.nc'];
    ncf_vegt=[mdir,ref_files{j1},'/','QVEGT','.',ref_files{j1},'.51-60.nc'];
    ncf_vege=[mdir,ref_files{j1},'/','QVEGE','.',ref_files{j1},'.51-60.nc'];
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);
    
    mean_et_ts=area_weight(mean_et_veg,area_s20);

    dat=mean_et_ts-lh_tss20;
    dat_m=reshape(dat,[12,10]);
    hh=errorbar((1:12),mean(dat_m,2),std(dat_m,[],2));
    fprintf('%s,%f\n',ref_files{j1},mean(mean(dat_m,2)));
    set(hh,'color',cc{j1},'lineWidth',2);
    hold on;
end
legend('CLM4.5','CLM4.5RHR-TCI','CLM4.5-CRU','CLM4.5RHR-TCI-CRU');
xlabel('Month','FontSize',fontsz);
set(ax,'FontSize',fontsz,'Xlim',[1,12]);
tags={'(a)20\circN north','(b)20\circS-20\circN','(c)20\circS south'};
for j = 1 : 3
    set(fig,'CurrentAxes',ax(j));
    put_tag(fig,ax(j),[.05,.8],tags{j},fontsz);
    if(j<3)    
        set(ax(j),'XTickLabel','');
    end
    ylabel('\DeltaET (mm day^-^1)','FontSize',fontsz);

end
set(fig,'color','w');
