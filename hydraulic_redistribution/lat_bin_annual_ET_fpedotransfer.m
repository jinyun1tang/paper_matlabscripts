close all;
clear all;
clc;
%comparison of ET using different pedotransfer functions


mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
ref_files={'clm45evapdef','clm45evapcosby4_hdr_maxlai','clm45evapnoilhan_hdr_maxlai','clm45hdr_maxlai_ref','cruclm45hd_maxlai_ref'};
bare_soil_files={'clm45evapdef_bs','clm45evapcosby4_bs','clm45evapnoilhan_bs','clm45evapdef_bs','cruclm45_baresoi'};

ncf_map=[mdir,'area_info.nc'];
latv=netcdf(ncf_map,'var','lat');

wt0=[31,28,31,30,31,30,31,31,30,31,30,31];
wt=repmat(wt0,[1,10]);  
cc={'b','k','r','c','g'};
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.6,.72]);   
ax=multipanel(fig,1,2,[.1,.1],[0.4,.8],[.075,.1]);
%plot the latitudinal binned ET
for j = 1 : length(ref_files)
    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.51-60.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.51-60.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.51-60.nc'];
    
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);

    
    %obtain ET for bare soil runs
    ncf_soil=[mdir,bare_soil_files{j},'/','QSOIL','.',bare_soil_files{j},'.51-60.nc'];
    mean_et_baresoil=ET_summary(ncf_soil,'','',0);
    
    [mean_et_lat_bined_mean,mean_et_lat_bined_std]=latitude_bin_time(mean_et_veg,2,wt);  
    
    delta_et=mean_et_baresoil-mean_et_veg;
    
    id=find(~isnan(delta_et));

    set(fig,'CurrentAxes',ax(1));
    plot(mean_et_lat_bined_mean,latv,'color',cc{j},'LineWidth',2);
    hold on;
    
    [delta_et_lat_bined_mean,delta_et_lat_bined_std]=latitude_bin_time(delta_et,2,wt);    
    set(fig,'CurrentAxes',ax(2));
    %hh=herrorbar(delta_et_lat_bined_mean,latv,delta_et_lat_bined_std);
    %set(hh,'color',cc{j},'LineWidth',2);
    plot(delta_et_lat_bined_mean,latv,'color',cc{j},'LineWidth',2);
    
    hold on;
end

set(ax,'FontSize',14);
set(ax(2),'YTickLabel','');
tags={'(a)','(b)'};
for jj=1 : 2
    put_tag(fig,ax(jj),[.05,.9],tags{jj},14);

end
set(fig,'CurrentAxes',ax(1));
xlabel('ET (mm day^-^1)','FontSize',14);
ylabel('Latitude','FontSize',14);
set(fig,'CurrentAxes',ax(2));
xlabel('\deltaET (mm day^-^1)','FontSize',14);
legend('CLM4.5','CLM4.5RHR-TCI-Cosby4','CLM4.5RHR-TCI-NL','CLM4.5RHR-TCI','CLM4.5RHR-TCI-CRU');





ref_files={'clm45evapdef','clm45evapcosby4','clm45evapnoilhan','clm45hdr_maxlai_ref','cruclm45def'};
bare_soil_files={'clm45evapdef_bs','clm45evapcosby4_bs','clm45evapnoilhan_bs','clm45evapdef_bs','cruclm45_baresoi'};



wt0=[31,28,31,30,31,30,31,31,30,31,30,31];
wt=repmat(wt0,[1,10]);  
cc={'b','k','r','c','g'};
set(fig,'color','w');
fig=figure(2);
set(fig,'unit','normalized','position',[.1,.1,.6,.72]);
ax=multipanel(fig,1,2,[.1,.1],[0.4,.8],[.075,.1]);
%plot the latitudinal binned ET
for j = 1 : length(ref_files)
    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.51-60.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.51-60.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.51-60.nc'];
    
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);

    
    %obtain ET for bare soil runs
    ncf_soil=[mdir,bare_soil_files{j},'/','QSOIL','.',bare_soil_files{j},'.51-60.nc'];
    mean_et_baresoil=ET_summary(ncf_soil,'','',0);
    
    [mean_et_lat_bined_mean,mean_et_lat_bined_std]=latitude_bin_time(mean_et_veg,2,wt);  
    
    delta_et=mean_et_baresoil-mean_et_veg;
    
    id=find(~isnan(delta_et));

    set(fig,'CurrentAxes',ax(1));
    plot(mean_et_lat_bined_mean,latv,'color',cc{j},'LineWidth',2);
    hold on;
    
    [delta_et_lat_bined_mean,delta_et_lat_bined_std]=latitude_bin_time(delta_et,2,wt);    
    set(fig,'CurrentAxes',ax(2));
    %hh=herrorbar(delta_et_lat_bined_mean,latv,delta_et_lat_bined_std);
    %set(hh,'color',cc{j},'LineWidth',2);
    plot(delta_et_lat_bined_mean,latv,'color',cc{j},'LineWidth',2);
    
    hold on;
end

set(ax,'FontSize',14);
set(ax(2),'YTickLabel','');
tags={'(a)','(b)'};
for jj=1 : 2
    put_tag(fig,ax(jj),[.05,.9],tags{jj},14);

end
set(fig,'CurrentAxes',ax(1));
xlabel('ET (mm day^-^1)','FontSize',14);
ylabel('Latitude','FontSize',14);
set(fig,'CurrentAxes',ax(2));
xlabel('\deltaET (mm day^-^1)','FontSize',14);
legend('CLM4.5','CLM4.5-Cosby4','CLM4.5-NL','CLM4.5RHR-TCI','CLM4.5-CRU');
set(fig,'color','w');