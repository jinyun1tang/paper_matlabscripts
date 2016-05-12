%
%compare the difference in precipitation of the two products
close all;
clear all;
clc;

fontsz=14;
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';


%now plot the latitude versus precipitation
ncf_map=[mdir,'area_info.nc'];
latv=netcdf(ncf_map,'var','lat');
lat2d=repmat(latv',[144,1]);


ref_files={'cruclm45hd_ref','clm45evaphdr_ref'};

%reference
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

    if(j==1)    
        prec1=(rain+snow).*86400.*365;
    else
        prec2=(rain+snow).*86400.*365;
    end

end
set(fig2,'CurrentAxes',ax2(1));
    
[prec_lat_bined_mean,prec_lat_bined_std2]=latitude_bin_time(prec2,2,wt);    
handle=herrorbar(prec_lat_bined_mean,latv, prec_lat_bined_std2); 
set(handle(2),'color','k','LineWidth',2);

xlabel('Mean precipitation (mm year^-^1)','FontSize',fontsz);
ylabel('Latitude','FontSize',fontsz);
set(fig2,'CurrentAxes',ax2(2));
    
[prec_lat_bined_mean,prec_lat_bined_std]=latitude_bin_time(prec1-prec2,2,wt);    
handle=herrorbar(prec_lat_bined_mean,latv, prec_lat_bined_std); hold on;
line([0,0],[-90,90],'LineStyle','--','Color','r');
set(handle(2),'color','k','LineWidth',2);
set(ax2(2),'YTickLabel','','Xlim',[-800,400]);

xlabel('Mean precipitation difference (mm year^-^1)','FontSize',fontsz);
set(ax2,'FontSize',14);

set(ax2,'Ylim',[-90,90],'YTick',(-90:20:90));

put_tag(fig2,ax2(1),[.05,.95],'(a)',fontsz);
put_tag(fig2,ax2(2),[.05,.95],'(b)',fontsz);


[prec_lat_bined_mean,prec_lat_bined_std1]=latitude_bin_time(prec1,2,wt);    

figure;
plot(sqrt(prec_lat_bined_std1.^2+prec_lat_bined_std2.^2)./prec_lat_bined_std,latv);
