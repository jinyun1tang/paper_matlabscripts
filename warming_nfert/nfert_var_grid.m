close all;
clear all;
%clc;
iscent=1;
varname={'TSOI_10CM','TG',...
         'SNOW_DEPTH','NET_NMIN',...
         'LITTERC_LOSS','SMINN',...
         'SOILC_HR','TOTSOMC',...
         'AR','ER',...
         'GPP','HR',...
         'NEE'};
     
titles={'(a)Mean TSOI-10CM GRS change (K)','(b)STD of TSOI-10CM GRS change (K)';
    '(a)Mean TG GRS change (K)','(b)STD of TG GRS change (K)';
    '(a)Mean winter snow depth (m)','(b)STD of winter snow depth (m)';
    '(a)Mean relative change in GRS NET-NMIN (%)','(b)STD of relative change in GRS NET-NMIN (%)';
    '(a)Mean relative change in GRS LITTERC-LOSS (%)','(b)STD of relative change in GRS LITTERC-LOSS (%)';
    '(a)Mean relative change in GRS SMINN (%)','(b)STD of relative change in GRS SMINN (%)';
    '(a)Mean relative change in GRS SOILC HR (%)','(b)STD of relative change in GRS SOILC HR (%)';
    '(a)Mean relative change in GRS TOTSOMC (%)','(b)STD of relative change in GRS TOTSOMC (%)';
    '(a)Mean relative change in GRS AR (%)','(b)STD of relative change in GRS AR (%)';
    '(a)Mean relative change in GRS ER (%)','(b)STD of relative change in GRS ER (%)';
    '(a)Mean relative change in GRS GPP (%)','(b)STD of relative change in GRS GPP (%)';
    '(a)Mean relative change in GRS HR (%)','(b)STD of relative change in GRS HR (%)';
    '(a)Mean relative change in GRS NEE (%)','(b)STD of relative change in GRS NEE (%)';};
www=[1,1,2,1,1,1,1,1,1,1,1,1,1];
diftype=[1,1,1,0,0,0,0,0,0,0,0,0,0];
kkk=13;
%for kkk=1 : length(www)


isweighted=1;%growing season
mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
if(iscent)
    ncf1=[mdir,'I1850-2000bgcvrt60N_control/',varname{kkk},'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
    ncf2=[mdir,'I1980-2000petbcent_T0.0_N.3/',varname{kkk},'.I1980-2000petbcent_T0.0_N.3.1980-2000.nc'];    
else
    ncf1=[mdir,'I1850-2000bgcvrt60N-CN_control/',varname{kkk},'.I1850-2000bgcvrt60N-CN_control.1980-2000.nc'];
    ncf2=[mdir,'I1980-2000bgc60N-CN_T0.0_N.3/',varname{kkk},'.I1980-2000bgc60N-CN_T0.0_N.3.1980-2000.nc'];
end

region=0;
[data_ctl,lon,lat]=flux_grid_extract(varname{kkk},ncf1,region);
[data_n01,lon,lat]=flux_grid_extract(varname{kkk},ncf2,region);


sz1=size(data_ctl,1);
sz2=size(data_ctl,2);
sz3=size(data_ctl,3)/12;
data_ctl_avg=zeros(sz1,sz2,sz3);
data_n01_avg=zeros(sz1,sz2,sz3);

w=[0,0,0,0,1,1,1,1,1,1,0,0;
   1,1,1,1,0,0,0,0,0,0,1,1 ]./6;

for j = 1 : sz1
    for k = 1 : sz2
        if(isweighted)
            data_ctl_avg(j,k,:)=slidew_mean(data_ctl(j,k,:),12,w(www(kkk),:));
            data_n01_avg(j,k,:)=slidew_mean(data_n01(j,k,:),12,w(www(kkk),:));    
        else
            data_ctl_avg(j,k,:)=slide_mean(data_ctl(j,k,:),12);
            data_n01_avg(j,k,:)=slide_mean(data_n01(j,k,:),12);    
        end     
    end
end
dat=zeros(size(data_ctl_avg,1),size(data_ctl_avg,2),size(data_ctl_avg,3),2);
dat(:,:,:,1)=data_ctl_avg;
dat(:,:,:,2)=data_n01_avg;
if(diftype(kkk))    
    dat_dif=mean(squeeze(dat(:,:,:,2)-dat(:,:,:,1)),3);
    dat_std=std(squeeze(dat(:,:,:,2)-dat(:,:,:,1)),0,3);
else
    data=(data_n01_avg./data_ctl_avg-1).*100;
    dat_dif=mean(data,3);
    dat_std=std(data,0,3);
end
fig=figure(1);
set(fig,'color','w','unit','normalized','position',[0.2,0.2,0.3,0.5]);
ax=multipanel(fig,1,2,[0.08,0.1],[0.4,0.8],[0.05,0.05]);
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


put_tag(fig,ax(1),[0.1,1.2],titles{kkk,1},14);
put_tag(fig,ax(2),[0.1,1.2],titles{kkk,1},14);
%end