close all;
clear all;
clc;
fontsz=14;
iscent=0;
mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
varname='SNOW_DEPTH';
if(iscent)
    ncf1=[mdir,'I1850-2000bgcvrt60N_control/',varname,'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
    ttl='CENTURY-like BGC';
    nfls={'I1980-2000petbcent_OTC','I1980-2000petbcent_T0.0_N.1',...
'I1980-2000petbcent_T0.0_N.2','I1980-2000petbcent_T0.0_N.3',...
'I1980-2000petbcent_T0.0_N.4','I1980-2000petbcent_T0.0_N.5',...
'I1980-2000petbcent_T2.0_N0.0','I1980-2000petbcent_T2.5_N0.0',...
'I1980-2000petbcent_T3.0_N0.0','I1980-2000petbcent_T3.5_N0.0',...
'I1980-2000petbcent_T4.0_N0.0';};
else
    ncf1=[mdir,'I1850-2000bgcvrt60N-CN_control/',varname,'.I1850-2000bgcvrt60N-CN_control.1980-2000.nc'];
    ttl='CN BGC';
    nfls={'I1980-2000bgc60N-CN_OTC',...
'I1980-2000bgc60N-CN_T0.0_N.1','I1980-2000bgc60N-CN_T0.0_N.2',...
'I1980-2000bgc60N-CN_T0.0_N.3','I1980-2000bgc60N-CN_T0.0_N.4',...
'I1980-2000bgc60N-CN_T0.0_N.5','I1980-2000bgc60N-CN_T2.0_N0.0',...
'I1980-2000bgc60N-CN_T2.5_N0.0','I1980-2000bgc60N-CN_T3.0_N0.0',...
'I1980-2000bgc60N-CN_T3.5_N0.0','I1980-2000bgc60N-CN_T4.0_N0.0'};  
end

for k = 1 : length(nfls)

fig=figure('color','w');
set(fig,'unit','normalized','position',[0.1,0.1,0.25,0.4]);
ncf2=[mdir,nfls{k},'/',varname,'.',nfls{k},'.1980-2000.nc'];

region=0;
[data_ctl,lon,lat]=flux_grid_extract(varname,ncf1,region);
[data_n01,lon,lat]=flux_grid_extract(varname,ncf2,region);

sz1=size(data_ctl,1);
sz2=size(data_ctl,2);
sz3=size(data_ctl,3);
data_ctl_avg=zeros(sz1,sz2,sz3/12);
data_n01_avg=zeros(sz1,sz2,sz3/12);

w=[1,1,1,1,0,0,0,0,0,0,1,1]./6;

for j = 1 : sz1
    for k1 = 1 : sz2
        data_ctl_avg(j,k1,:)=slidew_mean(data_ctl(j,k1,:),12,w);
        data_n01_avg(j,k1,:)=slidew_mean(data_n01(j,k1,:),12,w); 
    end
end


data_ctl_avg_grd=mean(data_ctl_avg,3);
subplot(2,1,1);
m_proj('stereographic','lat',90,'long',30,'radius',30);
m_grid('xtick',14,'tickdir','out','ytick',[70,80],'linest','-');
m_coast('color','k');
hold on;
[c,h]=m_contourf(lon,lat,data_ctl_avg_grd',(0:0.2:2));colorbar;set(h,'color','none');
put_tag(fig,gca,[-0.3,1.15],[ttl,': winter half year mean snow depth (m)'],14);
subplot(2,1,2);
dif_cum=mean(data_n01_avg-data_ctl_avg,3);
m_proj('stereographic','lat',90,'long',30,'radius',30);
m_grid('xtick',14,'tickdir','out','ytick',[70,80],'linest','-');
m_coast('color','k');
hold on;
[c,h]=m_contourf(lon,lat,dif_cum',(-0.2:0.05:0.2));colorbar;set(h,'color','none');
put_tag(fig,gca,[-0.3,1.15],[ttl,': change in winter half year snow depth (m)'],14);
savefile=['figure/',nfls{k},'_',varname,'_grid.png'];
export_fig(savefile);
end