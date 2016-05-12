
%
%analyze the relationship between the potential ET bias and precipitation
close all;
clear all;
clc;

fontsz=14;
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';


%now plot the latitude versus precipitation
ncf_map=[mdir,'area_info.nc'];
latv=netcdf(ncf_map,'var','lat');
lat2d=repmat(latv',[144,1]);


ref_files={'clm45evapcosby4','clm45evapdef','clm45evapnoilhan','clm45evaphdr_ref'};
bare_soil_files={'clm45evapcosby4_bs','clm45evapdef_bs','clm45evapnoilhan_bs','clm45evapdef_bs'};

%reference
fig1=figure(1);
ax1=multipanel(fig1,1,2,[0.1,0.1],[0.4,0.8],[0.075,0.1]);
fig2=figure(2);
ax2=multipanel(fig2,1,2,[0.1,0.1],[0.4,0.8],[0.075,0.1]);

wt0=[31,28,31,30,31,30,31,31,30,31,30,31];
wt=repmat(wt0,[1,10]);  
%chdir='clm45evaphdr_kx10';
cc={'b','r','k','g'};
for j=1:length(ref_files)

    rain_file=[mdir,ref_files{j},'/','RAIN','.',ref_files{j},'.50-59.nc'];

    snow_file=[mdir,ref_files{j},'/','SNOW','.',ref_files{j},'.50-59.nc'];

    rain=netcdf(rain_file,'var','RAIN');id=find(abs(rain)>1d10);rain(id)=0./0.;

    snow=netcdf(snow_file,'var','SNOW');

    prec=(rain+snow).*86400.*365;


    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.50-59.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.50-59.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.50-59.nc'];
    
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);
    %obtain ET for bare soil runs
    ncf_soil=[mdir,bare_soil_files{j},'/','QSOIL','.',bare_soil_files{j},'.50-59.nc'];
    mean_et_baresoil=ET_summary(ncf_soil,'','',0);
    

    %compute the ET difference

    delta_et=mean_et_baresoil-mean_et_veg;

    

    id=find(~isnan(delta_et));


    [delta_et_lat_bined_mean,delta_et_lat_bined_std]=latitude_bin_time(delta_et,2,wt);
    figure(fig2);
    set(fig2,'CurrentAxes',ax2(1));
    hh=herrorbar(delta_et_lat_bined_mean,latv,delta_et_lat_bined_std);
    set(hh(2),'color',cc{j},'LineWidth',2);
    if(j==4)
        set(hh(1),'color',[.5,.5,.5]);
    end
    h11(j)=hh(2);
    hold on;
end


figure(fig2);
set(fig2,'CurrentAxes',ax2(1));
xlabel('Bare soil ET minus Vegetated ET (mm day^-1)','FontSize',fontsz);
ylabel('Latitude','FontSize',fontsz);
set(fig2,'CurrentAxes',ax2(2));
legend(h11,'CLM45-Cosby Eq.4','CLM45','CLM45-Noilhan Eq.','CLM45-HD');
[prec_lat_bined_mean,prec_lat_bined_std]=latitude_bin_time(prec,2,wt);

herrorbar(prec_lat_bined_mean,latv, prec_lat_bined_std); 

xlabel('Mean precipitation (mm year^-^1)','FontSize',fontsz);
set(ax2,'FontSize',14);
set(ax2(2),'YTickLabel','');
put_tag(fig2,ax2(1),[0.05,0.95],'(a)',fontsz);
put_tag(fig2,ax2(2),[0.05,0.95],'(b)',fontsz);

set(ax2,'Ylim',[-90,90],'YTick',(-90:20:90));

