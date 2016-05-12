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
data_ctl=flux_extract(varname,ncf1,region);
data_n01=flux_extract(varname,ncf2,region);

sz1=size(data_ctl,1);
sz2=size(data_ctl,2);
data_ctl_avg=zeros(sz1,sz2/12);
data_n01_avg=zeros(sz1,sz2/12);

w=[1,1,1,1,0,0,0,0,0,0,1,1]./6;

for j = 1 : sz1
    data_ctl_avg(j,:)=slidew_mean(data_ctl(j,:),12,w);
    data_n01_avg(j,:)=slidew_mean(data_n01(j,:),12,w); 
end

dif_cum=data_n01_avg-data_ctl_avg;
gray=[139,137,137]./256;
subplot(2,1,1);
plot(data_ctl_avg','color',gray);
box_stat=prctile(data_ctl_avg,[2.5,25,50,75,97.5]);
hold on;
h=plot(box_stat','LineWidth',2);legend(h,'2.5%','25%','50%','75%','97.5%');
set(gca,'FontSize',fontsz);
xlabel('Year','FontSize',fontsz);
ylabel('Mean snow depth in winter half year(m)','FontSize',fontsz);
title(ttl,'FontSize',fontsz);
subplot(2,1,2);
plot(dif_cum','color',gray);
box_stat=prctile(dif_cum,[2.5,25,50,75,97.5]);
hold on;
h=plot(box_stat','LineWidth',2);legend(h,'2.5%','25%','50%','75%','97.5%');
xlabel('Year','FontSize',fontsz);
ylabel('Change in mean snow depth in winter half year(m)','FontSize',fontsz);
set(gca,'FontSize',fontsz);
savefile=['figure/',nfls{k},'_',varname,'.png'];
export_fig(savefile);
end