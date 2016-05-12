function dat = heat_analysis_cent(varname,region,isweighted)
%varname='NEE';

mdir='/Volumes/Macintosh-HD2/work_space/data_collection/clm_output/warming_nfert/';
ncf1=[mdir,'I1850-2000bgcvrt60N_control/',varname,'.I1850-2000bgcvrt60N_control.1980-2000.nc'];
ncf2=[mdir,'I1980-2000petbcent_T2.0_N0.0/',varname,'.I1980-2000petbcent_T2.0_N0.0.1980-2000.nc'];
ncf3=[mdir,'I1980-2000petbcent_T2.5_N0.0/',varname,'.I1980-2000petbcent_T2.5_N0.0.1980-2000.nc'];
ncf4=[mdir,'I1980-2000petbcent_T3.0_N0.0/',varname,'.I1980-2000petbcent_T3.0_N0.0.1980-2000.nc'];
ncf5=[mdir,'I1980-2000petbcent_T3.5_N0.0/',varname,'.I1980-2000petbcent_T3.5_N0.0.1980-2000.nc'];
ncf6=[mdir,'I1980-2000petbcent_T4.0_N0.0/',varname,'.I1980-2000petbcent_T4.0_N0.0.1980-2000.nc'];



gpp_ctl=flux_extract(varname,ncf1,region);
gpp_n01=flux_extract(varname,ncf2,region);
gpp_n02=flux_extract(varname,ncf3,region);
gpp_n03=flux_extract(varname,ncf4,region);
gpp_n04=flux_extract(varname,ncf5,region);
gpp_n05=flux_extract(varname,ncf6,region);

sz1=size(gpp_ctl,1);
sz2=size(gpp_ctl,2)/12;
gpp_ctl_avg=zeros(sz1,sz2);
gpp_n01_avg=zeros(sz1,sz2);
gpp_n02_avg=zeros(sz1,sz2);
gpp_n03_avg=zeros(sz1,sz2);
gpp_n04_avg=zeros(sz1,sz2);
gpp_n05_avg=zeros(sz1,sz2);
w=[0,0,0,0,1,1,1,1,1,1,0,0]./6;
for j = 1 : sz1
    if(isweighted)
        gpp_ctl_avg(j,:)=slidew_mean(gpp_ctl(j,:),12,w);
        gpp_n01_avg(j,:)=slidew_mean(gpp_n01(j,:),12,w);    
        gpp_n02_avg(j,:)=slidew_mean(gpp_n02(j,:),12,w);    
        gpp_n03_avg(j,:)=slidew_mean(gpp_n03(j,:),12,w);    
        gpp_n04_avg(j,:)=slidew_mean(gpp_n04(j,:),12,w);    
        gpp_n05_avg(j,:)=slidew_mean(gpp_n05(j,:),12,w);   
    else
        gpp_ctl_avg(j,:)=slide_mean(gpp_ctl(j,:),12);
        gpp_n01_avg(j,:)=slide_mean(gpp_n01(j,:),12);    
        gpp_n02_avg(j,:)=slide_mean(gpp_n02(j,:),12);    
        gpp_n03_avg(j,:)=slide_mean(gpp_n03(j,:),12);    
        gpp_n04_avg(j,:)=slide_mean(gpp_n04(j,:),12);    
        gpp_n05_avg(j,:)=slide_mean(gpp_n05(j,:),12);    
    end      
end
dat=zeros(size(gpp_ctl_avg,1),size(gpp_ctl_avg,2),6);
dat(:,:,1)=gpp_ctl_avg;
dat(:,:,2)=gpp_n01_avg;
dat(:,:,3)=gpp_n02_avg;
dat(:,:,4)=gpp_n03_avg;
dat(:,:,5)=gpp_n04_avg;
dat(:,:,6)=gpp_n05_avg;
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




