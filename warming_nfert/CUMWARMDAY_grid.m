close all;
clear all;
clc;
fontsz=14;
iscent=0;
varname='CUMWARMDAY';

mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
if(iscent)
    ttl='CENTURY-like BGC';
    nfls={'I1980-2000petbcent_OTC','I1980-2000petbcent_T0.0_N.1',...
'I1980-2000petbcent_T0.0_N.2','I1980-2000petbcent_T0.0_N.3',...
'I1980-2000petbcent_T0.0_N.4','I1980-2000petbcent_T0.0_N.5',...
'I1980-2000petbcent_T2.0_N0.0','I1980-2000petbcent_T2.5_N0.0',...
'I1980-2000petbcent_T3.0_N0.0','I1980-2000petbcent_T3.5_N0.0',...
'I1980-2000petbcent_T4.0_N0.0';};
    ncf1=[mdir,'I1850-2000bgcvrt60N_control/',varname,'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
    
else
    ttl='CN BGC';
    nfls={'I1980-2000bgc60N-CN_OTC',...
'I1980-2000bgc60N-CN_T0.0_N.1','I1980-2000bgc60N-CN_T0.0_N.2',...
'I1980-2000bgc60N-CN_T0.0_N.3','I1980-2000bgc60N-CN_T0.0_N.4',...
'I1980-2000bgc60N-CN_T0.0_N.5','I1980-2000bgc60N-CN_T2.0_N0.0',...
'I1980-2000bgc60N-CN_T2.5_N0.0','I1980-2000bgc60N-CN_T3.0_N0.0',...
'I1980-2000bgc60N-CN_T3.5_N0.0','I1980-2000bgc60N-CN_T4.0_N0.0'};

ncf1=[mdir,'I1850-2000bgcvrt60N-CN_control/',varname,'.I1850-2000bgcvrt60N-CN_control.1980-2000.nc'];
    
end
for j = 1 : length(nfls)
fig=figure('color','w');
set(fig,'unit','normalized','position',[0.1,0.1,0.25,0.4]);
ncf2=[mdir,nfls{j},'/',varname,'.',nfls{j},'.1980-2000.nc'];
region=0;
[data_ctl,lon,lat]=flux_grid_extract(varname,ncf1,region);
[data_n01,lon,lat]=flux_grid_extract(varname,ncf2,region);
data_ctl_ave=mean(data_ctl,3);
subplot(2,1,1);
m_proj('stereographic','lat',90,'long',30,'radius',30);
m_grid('xtick',14,'tickdir','out','ytick',[70,80],'linest','-');
m_coast('color','k');
hold on;
[c,h]=m_contourf(lon,lat,data_ctl_ave');colorbar;set(h,'color','none');
put_tag(fig,gca,[-0.3,1.15],[ttl,': mean growing season length (days)'],14);
subplot(2,1,2);
dif_cum=mean(data_n01-data_ctl,3);
m_proj('stereographic','lat',90,'long',30,'radius',30);
m_grid('xtick',14,'tickdir','out','ytick',[70,80],'linest','-');
m_coast('color','k');
hold on;
[c,h]=m_contourf(lon,lat,dif_cum');colorbar;set(h,'color','none');
put_tag(fig,gca,[-0.3,1.15],[ttl,': change in mean growing season length (days)'],14);

savefile=['figure/',nfls{j},'_',varname,'_grid.png'];
export_fig(savefile);
close(fig);
end;