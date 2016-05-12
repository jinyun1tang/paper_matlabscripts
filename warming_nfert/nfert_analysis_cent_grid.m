function [dat,lon,lat] = nfert_analysis_cent_grid(varname,isweighted)
%varname='NEE';

mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
ncf1=[mdir,'I1850-2000bgcvrt60N_control/',varname,'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
ncf2=[mdir,'I1980-2000petbcent_T0.0_N.02/',varname,'.I1980-2000petbcent_T0.0_N.02.1980-2000.nc'];
ncf3=[mdir,'I1980-2000petbcent_T0.0_N.1/',varname,'.I1980-2000petbcent_T0.0_N.1.1980-2000.nc'];
ncf4=[mdir,'I1980-2000petbcent_T0.0_N.2/',varname,'.I1980-2000petbcent_T0.0_N.2.1980-2000.nc'];
ncf5=[mdir,'I1980-2000petbcent_T0.0_N.3/',varname,'.I1980-2000petbcent_T0.0_N.3.1980-2000.nc'];
ncf6=[mdir,'I1980-2000petbcent_T0.0_N.4/',varname,'.I1980-2000petbcent_T0.0_N.4.1980-2000.nc'];
ncf7=[mdir,'I1980-2000petbcent_T0.0_N.5/',varname,'.I1980-2000petbcent_T0.0_N.5.1980-2000.nc'];



region=0;
[gpp_ctl,lon,lat]=flux_grid_extract(varname,ncf1,region);
[gpp_n01,lon,lat]=flux_grid_extract(varname,ncf2,region);
[gpp_n02,lon,lat]=flux_grid_extract(varname,ncf3,region);
[gpp_n03,lon,lat]=flux_grid_extract(varname,ncf4,region);
[gpp_n04,lon,lat]=flux_grid_extract(varname,ncf5,region);
[gpp_n05,lon,lat]=flux_grid_extract(varname,ncf6,region);
[gpp_n06,lon,lat]=flux_grid_extract(varname,ncf7,region);

sz1=size(gpp_ctl,1);
sz2=size(gpp_ctl,2);
sz3=size(gpp_ctl,3)/12;
gpp_ctl_avg=zeros(sz1,sz2,sz3);
gpp_n01_avg=zeros(sz1,sz2,sz3);
gpp_n02_avg=zeros(sz1,sz2,sz3);
gpp_n03_avg=zeros(sz1,sz2,sz3);
gpp_n04_avg=zeros(sz1,sz2,sz3);
gpp_n05_avg=zeros(sz1,sz2,sz3);
gpp_n06_avg=zeros(sz1,sz2,sz3);

w=[0,0,0,0,1,1,1,1,1,1,0,0]./6;
for j = 1 : sz1
    for k = 1 : sz2
        if(isweighted)
            gpp_ctl_avg(j,k,:)=slidew_mean(gpp_ctl(j,k,:),12,w);
            gpp_n01_avg(j,k,:)=slidew_mean(gpp_n01(j,k,:),12,w);    
            gpp_n02_avg(j,k,:)=slidew_mean(gpp_n02(j,k,:),12,w);    
            gpp_n03_avg(j,k,:)=slidew_mean(gpp_n03(j,k,:),12,w);    
            gpp_n04_avg(j,k,:)=slidew_mean(gpp_n04(j,k,:),12,w);    
            gpp_n05_avg(j,k,:)=slidew_mean(gpp_n05(j,k,:),12,w);              
            gpp_n06_avg(j,k,:)=slidew_mean(gpp_n06(j,k,:),12,w);               
        else
            gpp_ctl_avg(j,k,:)=slide_mean(gpp_ctl(j,k,:),12);
            gpp_n01_avg(j,k,:)=slide_mean(gpp_n01(j,k,:),12);    
            gpp_n02_avg(j,k,:)=slide_mean(gpp_n02(j,k,:),12);    
            gpp_n03_avg(j,k,:)=slide_mean(gpp_n03(j,k,:),12);    
            gpp_n04_avg(j,k,:)=slide_mean(gpp_n04(j,k,:),12);    
            gpp_n05_avg(j,k,:)=slide_mean(gpp_n05(j,k,:),12);   
            gpp_n06_avg(j,k,:)=slide_mean(gpp_n06(j,k,:),12);              
        end    
    end
end
dat=zeros(size(gpp_ctl_avg,1),size(gpp_ctl_avg,2),size(gpp_ctl_avg,3),7);
dat(:,:,:,1)=gpp_ctl_avg;
dat(:,:,:,2)=gpp_n01_avg;
dat(:,:,:,3)=gpp_n02_avg;
dat(:,:,:,4)=gpp_n03_avg;
dat(:,:,:,5)=gpp_n04_avg;
dat(:,:,:,6)=gpp_n05_avg;
dat(:,:,:,7)=gpp_n06_avg;
end
    
    %subplot(2,1,1);
%plot(mean(gpp_n01_avg,1)./mean(gpp_ctl_avg,1));
%hold on;
%plot(mean(gpp_n02_avg,1)./mean(gpp_ctl_avg,1),'r');
%plot(mean(gpp_n03_avg,1)./mean(gpp_ctl_avg,1),'g');
%plot(mean(gpp_n04_avg,1)./mean(gpp_ctl_avg,1),'k');
%plot(mean(gpp_n05_avg,1)./mean(gpp_ctl_avg,1),'c');

%subplot(2,5,6);
%hist(mean(gpp_n01_avg,2)./mean(gpp_ctl_avg,2),40);
%subplot(2,5,7);
%hist(mean(gpp_n02_avg,2)./mean(gpp_ctl_avg,2),40);
%subplot(2,5,8);
%hist(mean(gpp_n03_avg,2)./mean(gpp_ctl_avg,2),40);
%subplot(2,5,9);
%hist(mean(gpp_n04_avg,2)./mean(gpp_ctl_avg,2),40);
%subplot(2,5,10);
%hist(mean(gpp_n05_avg,2)./mean(gpp_ctl_avg,2),40);




