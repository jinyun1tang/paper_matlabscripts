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
'I1980-2000bgc60N-CN_T0.0_N.5'};
nfls={'I1980-2000bgc60N-CN_T2.0_N0.0',...
'I1980-2000bgc60N-CN_T2.5_N0.0','I1980-2000bgc60N-CN_T3.0_N0.0',...
'I1980-2000bgc60N-CN_T3.5_N0.0','I1980-2000bgc60N-CN_T4.0_N0.0'}

ncf1=[mdir,'I1850-2000bgcvrt60N-CN_control/',varname,'.I1850-2000bgcvrt60N-CN_control.1980-2000.nc'];
    
end
for j = 1 : length(nfls)
fig=figure('color','w');
set(fig,'unit','normalized','position',[0.1,0.1,0.25,0.4]);
ncf2=[mdir,nfls{j},'/',varname,'.',nfls{j},'.1980-2000.nc'];
region=0;
data_ctl=flux_extract(varname,ncf1,region);
data_n01=flux_extract(varname,ncf2,region);
dif_cum=data_n01-data_ctl;
gray=[139,137,137]./256;
subplot(2,1,1);
plot(data_ctl','color',gray);
box_stat=prctile(data_ctl,[2.5,25,50,75,97.5]);
hold on;
h=plot(box_stat','LineWidth',2);legend(h,'2.5%','25%','50%','75%','97.5%');
set(gca,'FontSize',fontsz);
xlabel('Year','FontSize',fontsz);
ylabel('NO. of days when chamber is on','FontSize',fontsz);
title(ttl,'FontSize',fontsz);
subplot(2,1,2);
plot(dif_cum','color',gray);
box_stat=prctile(dif_cum,[2.5,25,50,75,97.5]);
hold on;
h=plot(box_stat','LineWidth',2);legend(h,'2.5%','25%','50%','75%','97.5%');
xlabel('Year','FontSize',fontsz);
ylabel('Change in NO. of days when chamber is on','FontSize',fontsz);
set(gca,'FontSize',fontsz);
savefile=['figure/',nfls{j},'_',varname,'.png'];
export_fig(savefile);
close(fig);
end;