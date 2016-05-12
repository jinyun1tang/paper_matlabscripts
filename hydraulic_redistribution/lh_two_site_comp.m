close all;
clear all;
clc;
func_name='lh_two_site_comp.m';
%evaluating the simulated latent heat at Blodgett forest and Tajajos site
%compare CLM45 and HD enabled simulations (sequential and coupled).

mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
load('/Users/jinyuntang/work/data_collection/FLUXNET_MTE/fluxnet_mte.mat');
varname='EFLX_LH_TOT';
fontsz=14;
%amazon somewhere
lonp=297.5;
latp=-2.842105;
do_bare=1;
ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.65,.95]);
ax=multipanel(fig,2,1,[.1,.08],[0.6,0.42],[.05,0.04]);
linewidth=2;
sites={'sierra','tapajos'};

for jj = 1 : length(sites)
    site=sites{jj};
    fprintf('site=%s\n',site);
    if(strcmp(site,'sierra'))    
        lonp=240;    
        latp=38.84211;    
        load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/Blodgett_Forest.mat');
    elseif(strcmp(site,'tapajos'))
        %tapajos    
        lonp=305;    
        latp=-2.356021;    
        load('/Users/jinyuntang/work/data_collection/ameriflux/lh_flx/LBA_Tapajos_KM67_Mature_Forest.mat');
    end    
    [iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);
    w=[31,28,31,30,31,30,31,31,30,31,30,31]./365;
    window=12;
    mlht=nanmean(lht,2);
    
    set(fig,'CurrentAxes',ax(jj));
    
    chdir='clm45evapdef';    
    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_def=get_clm_sitedat(ncf1,iloc,jloc,varname);
    nyr=length(eflx_def)/12;
    eflx_def_yr=mean(reshape(eflx_def,[12,nyr]),2);    
    h_plot(1)=plot(eflx_def_yr,'b','LineWidth',linewidth);
    hold on;

    fprintf('def\n');
    linearfit(eflx_def_yr,mlht,'disp');
    
    chdir='clm45evapdef_bs';
    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_def=get_clm_sitedat(ncf1,iloc,jloc,varname);
    nyr=length(eflx_def)/12;
    eflx_def_yr=mean(reshape(eflx_def,[12,nyr]),2);    
    h_plot(2)=plot(eflx_def_yr,'b--','LineWidth',linewidth);
    hold on;
    
    chdir='clm45hdr_maxlai_ref';
    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_hd=get_clm_sitedat(ncf1,iloc,jloc,varname);
    eflx_hd_yr=mean(reshape(eflx_hd,[12,nyr]),2);
    h_plot(3)=plot(eflx_hd_yr,'r','LineWidth',linewidth);

    fprintf('cm\n');
    linearfit(eflx_hd_yr,mlht,'disp');

    chdir='clm45evaphdr_seq_maxlai';   

    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_hdr_seq=get_clm_sitedat(ncf1,iloc,jloc,varname);
    eflx_hdr_seq_yr=mean(reshape(eflx_hdr_seq,[12,nyr]),2);
    h_plot(4)=plot(eflx_hdr_seq_yr,'c-','LineWidth',linewidth);

    fprintf('seq\n');
    linearfit(eflx_hdr_seq_yr,mlht,'disp');

    chdir='clm45evaphdr_maxlai_kx10';
    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_hdr_seq=get_clm_sitedat(ncf1,iloc,jloc,varname);
    eflx_hdr_seq_yr=mean(reshape(eflx_hdr_seq,[12,nyr]),2);
    h_plot(5)=plot(eflx_hdr_seq_yr,'r--','LineWidth',linewidth);    
    fprintf('cmkx10\n');
    linearfit(eflx_hdr_seq_yr,mlht,'disp');    

    chdir='clm45hdr_maxlai_uroot';
    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_hdr_seq=get_clm_sitedat(ncf1,iloc,jloc,varname);
    eflx_hdr_seq_yr=mean(reshape(eflx_hdr_seq,[12,nyr]),2);
    h_plot(6)=plot(eflx_hdr_seq_yr,'c--','LineWidth',linewidth);    
    fprintf('uroot\n');
    linearfit(eflx_hdr_seq_yr,mlht,'disp');    
    


    
    %now put fluxnet mte

    year0=1982;


    %use the 10 year mean for comparison


    year1=1991;

    year2=2000;


    id1=(year1-year0)*12+1;

    id2=(year2-year0+1)*12;    

    lonp=lonp-360; 
    [iloc_fluxnet_mte,jloc_fluxnet_mte]=find_siteloc(fluxnet_mte.lon,fluxnet_mte.lat,lonp,latp);

    lh_dat=squeeze(fluxnet_mte.LH_mean(iloc_fluxnet_mte,jloc_fluxnet_mte,id1:id2)).*1d6./86400;

    

    lh_dat_mat=reshape(lh_dat,[12,numel(lh_dat)/12]);
    hh1=errorbar((1:12),mean(lh_dat_mat,2),std(lh_dat_mat,0,2));

    set(hh1,'color','k','LineWidth',2);
    h_plot(8)=hh1(1);
    
    %plot data
    %hh=plot(lht,'ko','MarkerFaceColor','k');
    boxplot(lht','medianstyle','target');  
    h_plot(9) = plot(median_nan(lht,2),'g-o','LineWidth',2); 
    
    ylabel('Latent heat (W m^-^2)','FontSize',fontsz);
end

ncf='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/tapajos_qian_prec_corrected_nohd/EFLX_LH_TOT.tapajos_qian_prec_corrected_nohd.51-60.nc';

dat=netcdf(ncf,'var',varname);   
nyr=length(dat)/12;
lht_correct_hd_yr=mean(reshape(dat,[12,nyr]),2);

h_plot(7)=plot(lht_correct_hd_yr,'m-','LineWidth',linewidth);


legend(h_plot,'CLM4.5','CLM4.5-BSOI','CLM4.5RHR-TCI','CLM4.5RHR-SCI','CLM4.5RHR-TCI-K10','CLM4.5RHR-TCI-UROOT','CLM4.5RHR-TCI-prec-Adjust','FLUXNET-MTE','AmeriFlux','location','eastoutside');

set(ax,'Xlim',[0,13],'Fontsize',fontsz);
set(ax(1),'Ylim',[0,180]);
set(ax(2),'Ylim',[60,140]);

xlabel('Month','FontSize',fontsz);

tags={'(a) Blodgett Forest','(b) Tapajos Forest'};

for jj = 1 : 2
    put_tag(fig,ax(jj),[.025,.85],tags{jj},fontsz);
end
set(fig,'color','white');

return;

%plot out the precipitation
load('mat/gpcp_clm.mat');
fig1=figure(2);
set(fig1,'unit','normalized','position',[.1,.1,.8,.8]);
ax=multipanel(fig1,2,1,[0.1,0.1],[0.8,0.4],[0.05,.05]);
cc={'b-','b-'};
sites={'sierra','tapajos'};
loc={'SouthEast','NorthEast'};
for jj = 1 : length(sites)
    set(fig1,'currentAxes',ax(jj));

    site=sites{jj};
    if(strcmp(site,'sierra'))    
        lonp=240;    
        latp=38.84211;    
        load('mat/blodgett_swc.mat');
    elseif(strcmp(site,'tapajos'))
        %tapajos    
        lonp=305;    
        latp=-2.356021;   
        clear prec;
        load('mat/tapajos_km67_swc.mat');        
    end    

    prec.v=double(prec.v);
    [iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);
    boxplot(prec.v','medianstyle','target');    
    hold on;
    plot(median(prec.v,2),'r-','LineWidth',linewidth);hold on;
   
    chdir='clm45evapdef';
    varname='RAIN';
    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_def=get_clm_sitedat(ncf1,iloc,jloc,varname);
    nyr=length(eflx_def)/12;
    eflx_def_yr=mean(reshape(eflx_def,[12,nyr]),2);    
    rain=eflx_def_yr;
    varname='SNOW';
    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_def=get_clm_sitedat(ncf1,iloc,jloc,varname);
    snow=mean(reshape(eflx_def,[12,nyr]),2);        

    prec1=(snow+rain).*86400;
    plot(prec1,cc{jj},'LineWidth',linewidth);
    hold on;
    clear chdir;
    chdir='cruclm45def';
    varname='RAIN';
    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_def=get_clm_sitedat(ncf1,iloc,jloc,varname);
    nyr=length(eflx_def)/12;
    eflx_def_yr=mean(reshape(eflx_def,[12,nyr]),2);    
    rain=eflx_def_yr;
    
    varname='SNOW';
    ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
    eflx_def=get_clm_sitedat(ncf1,iloc,jloc,varname);
    snow=mean(reshape(eflx_def,[12,nyr]),2);        
    
    prec1=(snow+rain).*86400;
    plot(prec1,'--','LineWidth',linewidth);   
    ylabel('Mean precipitation (mm H_2O day^-^1)','FontSize',fontsz);    
    
    precg=mean(reshape(squeeze(gpcp.prec_gpcp2clm(iloc,jloc,:)),[12,nyr]),2);
    
    plot(precg./30,'k','LineWidth',linewidth);
    set(ax(jj),'Xlim',[0,13],'FontSize',fontsz); 
    if(jj==1)
        legend('AmeriFlux','QIAN prec.','CRUNCEP prec.','GPCP','location',loc{jj});
        set(ax(1),'Ylim',[-2,8],'XTickLabel','');
    end
 
    median(prec.v,2)./prec1



    txt = findobj(ax(jj),'Type','text');

    set(txt,'FontSize', fontsz);    
end


  

xlabel('Month','FontSize',fontsz);
put_tag(fig1,ax(1),[.025,.9],'(a) Blodgett Forest',fontsz);
put_tag(fig1,ax(2),[.025,.9],'(b) Tapajos Forest',fontsz);
set(fig1,'color','white');

