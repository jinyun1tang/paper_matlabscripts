close all;
clear all;
clc;
iscent=0;
varname='TSOI_10CM';
%varname='TG';

isweighted=1;%growing season
mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
if(iscent)
    ncf1=[mdir,'I1850-2000bgcvrt60N_control/',varname,'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
    ncf2=[mdir,'I1980-2000petbcent_OTC/',varname,'.I1980-2000petbcent_OTC.1980-2000.nc'];    
else
    ncf1=[mdir,'I1850-2000bgcvrt60N-CN_control/',varname,'.I1850-2000bgcvrt60N-CN_control.1980-2000.nc'];
    ncf2=[mdir,'I1980-2000bgc60N-CN_OTC/',varname,'.I1980-2000bgc60N-CN_OTC.1980-2000.nc'];
end

region=0;
[data_ctl,lon,lat]=flux_grid_extract(varname,ncf1,region);
[data_n01,lon,lat]=flux_grid_extract(varname,ncf2,region);


sz1=size(data_ctl,1);
sz2=size(data_ctl,2);
sz3=size(data_ctl,3)/12;
data_ctl_avg=zeros(sz1,sz2,sz3);
data_n01_avg=zeros(sz1,sz2,sz3);

w=[0,0,0,0,1,1,1,1,1,1,0,0]./6;
for j = 1 : sz1
    for k = 1 : sz2
        if(isweighted)
            data_ctl_avg(j,k,:)=slidew_mean(data_ctl(j,k,:),12,w);
            data_n01_avg(j,k,:)=slidew_mean(data_n01(j,k,:),12,w);    
        else
            data_ctl_avg(j,k,:)=slide_mean(data_ctl(j,k,:),12);
            data_n01_avg(j,k,:)=slide_mean(data_n01(j,k,:),12);    
        end     
    end
end
dat=zeros(size(data_ctl_avg,1),size(data_ctl_avg,2),size(data_ctl_avg,3),2);
dat(:,:,:,1)=data_ctl_avg;
dat(:,:,:,2)=data_n01_avg;

dat_dif=mean(squeeze(dat(:,:,:,2)-dat(:,:,:,1)),3);
dat_std=std(squeeze(dat(:,:,:,2)-dat(:,:,:,1)),0,3);

fig=figure(1);
set(fig,'color','w');
ax=multipanel(fig,1,2,[0.1,0.1],[0.4,0.8],[0.05,0.05]);
set(fig,'CurrentAxes',ax(1));
m_proj('stereographic','lat',90,'long',30,'radius',30);
m_grid('xtick',12,'tickdir','out','ytick',[70 80],'linest','-');
m_coast('color','k');
hold on;
[c,h]=m_contourf(lon,lat,dat_dif');set(h,'color','none');colorbar;

set(fig,'CurrentAxes',ax(2));
m_proj('stereographic','lat',90,'long',30,'radius',30);
m_grid('xtick',12,'tickdir','out','ytick',[70 80],'linest','-');
m_coast('color','k');
hold on;
[c,h]=m_contourf(lon,lat,dat_std');set(h,'color','none');colorbar;caxis([0,0.6]);


put_tag(fig,ax(1),[0.1,1.2],'(a)TG Mean GRS warming (K)',14);
put_tag(fig,ax(2),[0.1,1.2],'(b)TG GRS warming STD (K)',14);