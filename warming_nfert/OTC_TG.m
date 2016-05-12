close all;
clear all;
clc;
iscent=1;
varname='TG';
isweighted=0;%growing season
mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
if(iscent)
    ncf1=[mdir,'I1850-2000bgcvrt60N_control/',varname,'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
    ncf2=[mdir,'I1980-2000petbcent_OTC/',varname,'.I1980-2000petbcent_OTC.1980-2000.nc']; 
    %ncf2=[mdir,'I1980-2000petbcent_T3.0_N0.0/',varname,'.I1980-2000petbcent_T3.0_N0.0.1980-2000.nc'];     
else
    ncf1=[mdir,'I1850-2000bgcvrt60N-CN_control/',varname,'.I1850-2000bgcvrt60N-CN_control.1980-2000.nc'];
    ncf2=[mdir,'I1980-2000bgc60N-CN_OTC/',varname,'.I1980-2000bgc60N-CN_OTC.1980-2000.nc'];
    %ncf2=[mdir,'I1980-2000bgc60N-CN_T3.0_N0.0/',varname,'.I1980-2000bgc60N-CN_T3.0_N0.0.1980-2000.nc'];
end

region=0;
data_ctl=flux_extract(varname,ncf1,region);
data_n01=flux_extract(varname,ncf2,region);


sz1=size(data_ctl,1);
sz2=size(data_ctl,2);
data_ctl_avg=zeros(sz1,sz2);
data_n01_avg=zeros(sz1,sz2);

w=[0,0,0,0,1,1,1,1,1,1,0,0]./6;
for j = 1 : sz1
    if(isweighted)
        data_ctl_avg(j,:)=slidew_mean(data_ctl(j,:),12,w);
        data_n01_avg(j,:)=slidew_mean(data_n01(j,:),12,w);    
   
    else
        %data_ctl_avg(j,:)=slide_mean(data_ctl(j,:),12);
        %data_n01_avg(j,:)=slide_mean(data_n01(j,:),12);    
        data_ctl_avg(j,:)=data_ctl(j,:);
        data_n01_avg(j,:)=data_n01(j,:);        
    end   
end
dat=zeros(size(data_ctl_avg,1),size(data_ctl_avg,2),2);
dat(:,:,1)=data_ctl_avg;
dat(:,:,2)=data_n01_avg;
dTG=dat(:,:,2)'-dat(:,:,1)';
mdTG=mean(dTG,2);
figure;
h1=plot(dTG);
hold on;
h=plot(mdTG,'k','LineWidth',2);
legend(h,'mean');


