close all;
clear all;
clc;
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
varname='EFLX_LH_TOT';
fontsz=14;
%amazon somewhere
lonp=297.5;
latp=-2.842105;
site='sierra';
%site='tapajos';
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
ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

w=[31,28,31,30,31,30,31,31,30,31,30,31]./365;
window=12;
chdir='clm45hdr_maxlai_ref';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
eflx_hd=get_clm_sitedat(ncf1,iloc,jloc,varname);
nyr=length(eflx_hd)/12;
eflx_hd_yr=mean(reshape(eflx_hd,[12,nyr]),2);
h_plot(1)=plot(eflx_hd_yr,'LineWidth',2);


%chdir='clm45evaphdr_kx10';

%ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
%eflx_hd=get_clm_sitedat(ncf1,iloc,jloc,varname);
%nyr=length(eflx_hd)/12;
%eflx_hd_yr=mean(reshape(eflx_hd,[12,nyr]),2);
%hold on;
%h_plot(2)=plot(eflx_hd_yr,'g','LineWidth',2);


chdir='clm45evapdef';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];

eflx_def=get_clm_sitedat(ncf1,iloc,jloc,varname);
nyr=length(eflx_def)/12;
eflx_def_yr=mean(reshape(eflx_def,[12,nyr]),2);
hold on;
h_plot(3)=plot(eflx_def_yr,'r');

chdir='clm45evapcosby4';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
eflx_cosby4=get_clm_sitedat(ncf1,iloc,jloc,varname);
eflx_cosby4_yr=mean(reshape(eflx_cosby4,[12,nyr]),2);
h_plot(4)=plot(eflx_cosby4_yr,'k');


chdir='clm45evapnoilhan';
ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
eflx_noilhan=get_clm_sitedat(ncf1,iloc,jloc,varname);
eflx_noilhan_yr=mean(reshape(eflx_noilhan,[12,nyr]),2);

h_plot(5)=plot(eflx_noilhan_yr,'g');


chdir='clm45evapdef_bs';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
eflx_def_bs=get_clm_sitedat(ncf1,iloc,jloc,varname);
eflx_def_bs_yr=mean(reshape(eflx_def_bs,[12,nyr]),2);
h_plot(6)=plot(eflx_def_bs_yr,'r--');

chdir='clm45evapcosby4_bs';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
eflx_cosby4_bs=get_clm_sitedat(ncf1,iloc,jloc,varname);
eflx_cosby4_bs_yr=mean(reshape(eflx_cosby4_bs,[12,nyr]),2);
h_plot(7)=plot(eflx_cosby4_bs_yr,'g--');
chdir='clm45evapnoilhan_bs';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.50-59.nc'];
eflx_noilhan_bs=get_clm_sitedat(ncf1,iloc,jloc,varname);
eflx_noilhan_bs_yr=mean(reshape(eflx_noilhan_bs,[12,nyr]),2);
h_plot(8)=plot(eflx_noilhan_bs_yr,'k--');

chdir='clm45evaphdr_seq_maxlai';

ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];
eflx_hdr_seq=get_clm_sitedat(ncf1,iloc,jloc,varname);
eflx_hdr_seq_yr=mean(reshape(eflx_hdr_seq,[12,nyr]),2);
h_plot(9)=plot(eflx_hdr_seq_yr,'c-','LineWidth',2);

hh=plot(lht,'bo');
h_plot(10)=hh(1);
if(strcmp(site,'sierra'))
    %no drainage
    lh_nodrain=netcdf('/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/clm45hd_nodrain/LH_hdnodrain.nc','var',varname);
    eflx_nodrain_yr=mean(reshape(lh_nodrain,[12,nyr]),2);
    h_plot(11)=plot(eflx_nodrain_yr,'ro');
    %increase rooting depth to 3.9
    lh_hddepz=netcdf('/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd_depz_3.9/LH_hd_depz3.9.nc','var',varname);
    eflx_hddep_yr=mean(reshape(lh_hddepz,[12,nyr]),2);
    h_plot(12)=plot(eflx_hddep_yr,'rd');
    %increase btran 50%
    lh_hd_btran=netcdf('/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierr_hd_btran1.5/LH_btran1.5.nc','var',varname);
    eflx_hdbtran_yr=mean(reshape(lh_hd_btran,[12,nyr]),2);
    h_plot(13)=plot(eflx_hdbtran_yr,'cd');    
    %increase root conductivity to 60 times higher
    lh_hd_kx60=netcdf('/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/clm45hd_kx60/LH_kx60.nc','var',varname);
    eflx_hdkx60_yr=mean(reshape(lh_hd_kx60,[12,nyr]),2);
    h_plot(14)=plot(eflx_hdkx60_yr,'ro','MarkerFaceColor','r');    
    %
    %reduce convective velocity by 50%
    lh_hd_wc05=netcdf('/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra//sierr_hd_wc0.5/LH_WC0.5.nc','var',varname);
    eflx_hdwc05_yr=mean(reshape(lh_hd_wc05,[12,nyr]),2);
    h_plot(15)=plot(eflx_hdwc05_yr,'ko','MarkerFaceColor','k');    
    
end

legend(h_plot,'HD','HD-Kx10','CLM45','Cosby-Eq4','Noilhan','CLM45-bare',...
    'Cosby-Eq4 bare','Noilhan-bare','HD-Seq','FluxNet','HD-no drainage',...
    'HD-root 3.9m','HD-btranx1.5','HD-Kx60','HD-WC half');
ylabel('Latent heat (W m^-^2)','FontSize',fontsz);
set(gca,'Fontsize',fontsz);
xlabel('Month','FontSize',fontsz);