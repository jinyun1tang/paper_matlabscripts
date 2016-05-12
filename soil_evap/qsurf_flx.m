close all;
clear all;
clc;
ncfile1='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/pch_beta_analysis.nc';
ncfile2='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/pch_analysis.nc';
ncfile3='/Users/jinyuntang/work/data_collection/clm_output/SoilEvap/pchbet_analysis.nc';
ncf_map='/Users/jinyuntang/work/data_collection/clm_output/DiffBound/map_info.nc';
%read map info
area=netcdf(ncf_map,'var','area');
lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');

var='QOVER';
flx=netcdf(ncfile1,'var',var);id=find(flx>1d20);flx(id)=0./0.;flx=flx(:,:,1:60);
q0_lat=zeros(length(lat),size(flx,3));
for j = 1 : length(lat)
    q0_lat(j,:)=wmean(squeeze(flx(:,j,:)),area(:,j),1);
end

flx=netcdf(ncfile2,'var',var);id=find(flx>1d20);flx(id)=0./0.;flx=flx(:,:,1:60);
q1_lat=zeros(length(lat),size(flx,3));
for j = 1 : length(lat)
    q1_lat(j,:)=wmean(squeeze(flx(:,j,:)),area(:,j),1);
end

flx=netcdf(ncfile3,'var',var);id=find(flx>1d20);flx(id)=0./0.;flx=flx(:,:,1:60);
q2_lat=zeros(length(lat),size(flx,3));
for j = 1 : length(lat)
    q2_lat(j,:)=wmean(squeeze(flx(:,j,:)),area(:,j),1);
end

for j = 1 : size(q0_lat,1)
    dt=q1_lat(j,:)-q0_lat(j,:);
    dt=reshape(dt,[12,5]);

    q1_djf_mn(j)=mean(reshape(dt([1,2,12],:),[15,1]));
    q1_djf_sd(j)=std(reshape(dt([1,2,12],:),[15,1]));
    
    q1_mam_mn(j)=mean(reshape(dt([3,4,5],:),[15,1]));
    q1_mam_sd(j)=std(reshape(dt([3,4,5],:),[15,1]));

    q1_jja_mn(j)=mean(reshape(dt([6,7,8],:),[15,1]));
    q1_jja_sd(j)=std(reshape(dt([6,7,8],:),[15,1]));

    q1_son_mn(j)=mean(reshape(dt([9,10,11],:),[15,1]));
    q1_son_sd(j)=std(reshape(dt([9,10,11],:),[15,1]));

    
    dt=q2_lat(j,:)-q0_lat(j,:);
    dt=reshape(dt,[12,5]);
    q2_djf_mn(j)=mean(reshape(dt([1,2,12],:),[15,1]));
    q2_djf_sd(j)=std(reshape(dt([1,2,12],:),[15,1]));
    
    q2_mam_mn(j)=mean(reshape(dt([3,4,5],:),[15,1]));
    q2_mam_sd(j)=std(reshape(dt([3,4,5],:),[15,1]));

    q2_jja_mn(j)=mean(reshape(dt([6,7,8],:),[15,1]));
    q2_jja_sd(j)=std(reshape(dt([6,7,8],:),[15,1]));

    q2_son_mn(j)=mean(reshape(dt([9,10,11],:),[15,1]));
    q2_son_sd(j)=std(reshape(dt([9,10,11],:),[15,1]));

    dt=q0_lat(j,:);
    dt=reshape(dt,[12,5]);

    q0_djf_mn(j)=mean(reshape(dt([1,2,12],:),[15,1]));
    q0_djf_sd(j)=std(reshape(dt([1,2,12],:),[15,1]));
    
    q0_mam_mn(j)=mean(reshape(dt([3,4,5],:),[15,1]));
    q0_mam_sd(j)=std(reshape(dt([3,4,5],:),[15,1]));

    q0_jja_mn(j)=mean(reshape(dt([6,7,8],:),[15,1]));
    q0_jja_sd(j)=std(reshape(dt([6,7,8],:),[15,1]));

    q0_son_mn(j)=mean(reshape(dt([9,10,11],:),[15,1]));
    q0_son_sd(j)=std(reshape(dt([9,10,11],:),[15,1]));


end
line_width=2;
subplot(2,1,1);
hh(1)=plot(lat,q1_djf_mn.*q0_djf_mn./(q0_djf_mn.^2+1d-12).*100,'r','LineWidth',line_width);
hold on;
hh(2)=plot(lat,q1_mam_mn.*q0_mam_mn./(q0_mam_mn.^2+1d-12).*100,'g','LineWidth',line_width);
hh(3)=plot(lat,q1_jja_mn.*q0_jja_mn./(q0_jja_mn.^2+1d-12).*100,'b','LineWidth',line_width);
hh(4)=plot(lat,q1_son_mn.*q0_son_mn./(q0_son_mn.^2+1d-12).*100,'k','LineWidth',line_width);
xlim([-90,90]);ylabel('Relative Change (%)','FontSize',14);ylim([-6,6]);set(gca,'FontSize',14,'XTick',(-90:30:90),'XTickLabel','','YTick',[-6,-3,0,3,6]);
put_tag(gcf,gca,[0.05,0.9],'(a)',14);
subplot(2,1,2);
plot(lat,q2_djf_mn.*q0_djf_mn./(q0_djf_mn.^2+1d-12).*100,'r','LineWidth',line_width);
hold on;
plot(lat,q2_mam_mn.*q0_mam_mn./(q0_mam_mn.^2+1d-12).*100,'g','LineWidth',line_width);
plot(lat,q2_jja_mn.*q0_jja_mn./(q0_jja_mn.^2+1d-12).*100,'b','LineWidth',line_width);
plot(lat,q2_son_mn.*q0_son_mn./(q0_son_mn.^2+1d-12).*100,'k','LineWidth',line_width);
xlim([-90,90]);ylabel('Relative Change (%)','FontSize',14);ylim([-6,6]);xlabel('Latitude','FontSize',14);set(gca,'FontSize',14,'XTick',(-90:30:90),'YTick',[-6,-3,0,3,6]);
put_tag(gcf,gca,[0.05,0.9],'(b)',14);
legend(hh,'DJF','MAM','JJA','SON');
%legend_str=['DJF';'MAM';'JJA';'SON'];
%columnlegend(2,hh,legend_str,'southeast');



