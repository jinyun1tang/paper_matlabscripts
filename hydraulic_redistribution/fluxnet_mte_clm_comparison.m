close all;
clear all;
clc;
%DESCRIPTION
%do latitudinal plot

load('/Users/jinyuntang/work/data_collection/FLUXNET_MTE/fluxnet_mte.mat');
%time days since 1582-10-14 00:00:00

cday=[diff(fluxnet_mte.time);31];%number of days for each data point
year0=1982;

%use the 10 year mean for comparison
year1=1991;
year2=2000;

id1=(year1-year0)*12+1;
id2=(year2-year0+1)*12;
%extract the data and convert to mm H2O /day, assuming latent heat of
%evaporization as 2.501 MJ/kg
lh=fluxnet_mte.LH_mean(:,:,id1:id2);  %converts into W/m2
for j = 1 : size(lh,3)
    dat=lh(:,:,j);
    id=find(abs(dat)>9d3);    
    dat(id)=0./0.;
    lh(:,:,j)=dat;
end

lh=lh.*1d6./86400;

[lh_mte_bin_out_mean,lh_mte_bin_out_std]=latitude_bin_time(lh,2,cday(id1:id2));



%load clm files
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
%now plot the latitude versus precipitation
ncf_map=[mdir,'area_info.nc'];
latv=netcdf(ncf_map,'var','lat');
lat2d=repmat(latv',[144,1]);

ref_files={'clm45evapdef','clm45hdr_maxlai_ref','cruclm45def','cruclm45hd_maxlai_ref'};
ref_files1={'cruclm45def','cruclm45def_t62','clm45evapcosby4','clm45evapnoilhan'};
legends={'FLUXNET-MTE','QIAN: CLM45','QIAN: CLM45-HD','CRU: CLM45','CRU: CLM45HD'};
legends1={'2-\sigma uncertainty','QIAN: CLM45','QIAN: CLM45-HD','CRU: CLM45','CRU: CLM45HD'};

fig=figure(1);
set(fig,'Unit','normalized','position',[.1,.1,.7,.9]);
ax=multipanel(fig,1,2,[.06,.1],[0.4,0.8],[0.07,0.05]);

h=zeros(5,1);
h1=zeros(5,1);
wt0=[31,28,31,30,31,30,31,31,30,31,30,31];
wt=repmat(wt0,[1,(year2-year1+1)]);    
set(fig,'CurrentAxes',ax(1));
    
h(1)=plot(lh_mte_bin_out_mean,fluxnet_mte.lat,'r','LineWidth',2);

hold on;

cc={'b','g','k','c'};

dt_std_fine=zeros(length(fluxnet_mte.lat),4);
for j=1:4  
    %obtain ET for reference runs    

    
    ncf_soil=[mdir,char(ref_files{j}),'/','EFLX_LH_TOT','.',char(ref_files{j}),'.51-60.nc'];
        
    mean_et_veg=LH_summary(ncf_soil,0);
            
    [mean_et_veg_lat_bined_mean,mean_et_veg_lat_bined_std]=latitude_bin_time(mean_et_veg,2,wt);
    %interp to the fine grid
    
    mean_et_veg_lat_bined_mean_fine=interp1(latv,mean_et_veg_lat_bined_mean,fluxnet_mte.lat);

    dt_std_fine(:,j)=interp1(latv,mean_et_veg_lat_bined_std,fluxnet_mte.lat);
    
    set(fig,'CurrentAxes',ax(1));       
        
    h(j+1)=plot(mean_et_veg_lat_bined_mean,latv,cc{fix(j)},'LineWidth',2);
        
    set(fig,'CurrentAxes',ax(2));
        
    h1(j+1)=plot(mean_et_veg_lat_bined_mean_fine-lh_mte_bin_out_mean,...
            fluxnet_mte.lat,cc{fix(j)},'LineWidth',2);
        
    hold on;
        
    
end
%compute the one-sigma uncertainty
mean_dt_std_fine=mean(dt_std_fine,2);
obs_err=sqrt((lh_mte_bin_out_std.^2+mean_dt_std_fine.^2)./2);
set(fig,'CurrentAxes',ax(2));

h1(1)=plot(obs_err.*2,fluxnet_mte.lat,'r','LineWidth',2);


fontsz=14;
legend(h,legends);
legend(h1,legends1);
set(fig,'CurrentAxes',ax(2));
ylabel('Latitude (dgree)','FontSize',fontsz);
line([0,0],[-90,90]);
set(ax,'Ylim',[-90,90]);
set(ax,'FontSize',14);
%set(ax(2),'YTickLabel','');
set(ax,'YTick',(-90:20:90));       

put_tag(fig,ax(1),[.1,.9],'(a)',fontsz);
%put_tag(fig,ax(2),[.1,.9],'(b)',fontsz);
set(fig,'CurrentAxes',ax(1));
xlabel('Latent heat (W m^-^2)','FontSize',fontsz);
ylabel('Latitude (dgree)','FontSize',fontsz);
set(fig,'CurrentAxes',ax(2));
xlabel('Latent heat difference (W m^-^2)','FontSize',fontsz);
return;

fig2=figure(2);
ax1(1)=subplot(1,2,1);
for j=1:2  
    %obtain ET for reference runs    

    
    ncf_soil=[mdir,char(ref_files1{j}),'/','EFLX_LH_TOT','.',char(ref_files1{j}),'.50-59.nc'];
        
    mean_et_veg=LH_summary(ncf_soil,0);
            
    [mean_et_veg_lat_bined_mean,mean_et_veg_lat_bined_std]=latitude_bin_time(mean_et_veg,2,wt);
    %interp to the fine grid
    
    mean_et_veg_lat_bined_mean_fine=interp1(latv,mean_et_veg_lat_bined_mean,fluxnet_mte.lat);

    dt_std_fine(:,j)=interp1(latv,mean_et_veg_lat_bined_std,fluxnet_mte.lat);
    
     
        
    plot(mean_et_veg_lat_bined_mean,latv,cc{fix(j)},'LineWidth',2);
        
    dt_mean(:,j)=mean_et_veg_lat_bined_mean;            
    hold on;
        
    
end

xlabel('Latent heat (W m^-^2)','FontSize',fontsz);
ylabel('Latitude (dgree)','FontSize',fontsz);
legend('CRU: CLM4.5','CRU: CLM4.5\_62');
ax1(2)=subplot(1,2,2);
plot(dt_mean(:,2)-dt_mean(:,1),latv,'b','LineWidth',2);
xlabel('Latent heat difference (W m^-^2)','FontSize',fontsz);
legend('CRU: CLM4.5\_62 - CLM4.5');
set(ax1,'Ylim',[-90,90]);
set(ax1,'FontSize',14);
set(ax1(2),'YTickLabel','');
set(ax1,'YTick',(-90:20:90)); 
put_tag(fig2,ax1(1),[.1,.9],'(a)',fontsz);
put_tag(fig2,ax1(2),[.1,.9],'(b)',fontsz);
