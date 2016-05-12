close all;
clear all;
clc;


fontsz=14;

mdir ='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

qianclm=[mdir,'climatology/qian.climatology.51-60.nc'];
cruclm=[mdir,'climatology/cru.climatology.51-60.nc'];
    
dat_qian=netcdf(qianclm,'var','RAIN');


dat = netcdf(qianclm,'var','SNOW');

dat_qian = dat_qian + dat;

dat_cru=netcdf(cruclm,'var','RAIN');

dat = netcdf(cruclm,'var','SNOW');

dat_cru=dat_cru + dat;
    
dat_qian=dat_qian.*dayseconds();
    
dat_cru=dat_cru.*dayseconds();

dat_qian=rm_nan(dat_qian);
dat_cru=rm_nan(dat_cru);


%
load('mat/gpcp_clm.mat');


%obtain the mean seasonal cycle
sz1=size(dat_qian,1);
sz2=size(dat_qian,2);

qian_meansea= zeros(sz1,sz2,12);
cru_meansea = zeros(sz1,sz2,12);
gpcp_meansea= zeros(sz1,sz2,12);

for j1 = 1 : sz1
    for j2 = 1 : sz2
        dat=squeeze(dat_qian(j1,j2,:));          dat1=reshape(dat,[numel(dat)/12,12]);qian_meansea(j1,j2,:)=mean(dat1-repmat(mean(dat1,2),[1,12]),1);
        dat=squeeze(dat_cru(j1,j2,:));           dat1=reshape(dat,[numel(dat)/12,12]);cru_meansea(j1,j2,:)=mean(dat1-repmat(mean(dat1,2),[1,12]),1);
        dat=squeeze(gpcp.prec_gpcp2clm(j1,j2,:));dat1=reshape(dat,[numel(dat)/12,12]);gpcp_meansea(j1,j2,:)=mean(dat1-repmat(mean(dat1,2),[1,12]),1);        
    end
end



mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
ncf_map=[mdir,'area_info.nc'];
latv=netcdf(ncf_map,'var','lat');
lonv=netcdf(ncf_map,'var','lon');

id=find(lonv>180);
lonv(id)=lonv(id)-360;
dshft=length(lonv)-id(1)+1;
lonv=circshift(lonv,dshft);

coef_qian_gpcp=corr_coefm3d(qian_meansea,gpcp_meansea);
coef_cru_gpcp=corr_coefm3d(cru_meansea,gpcp_meansea);

coef_qian_gpcp=double(circshift(coef_qian_gpcp,dshft));
coef_cru_gpcp=double(circshift(coef_cru_gpcp,dshft));




%plot
cm=flipud(othercolor('RdBu11'));
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.8,.9]);
ax=multipanel(fig,2,2,[.1,.1],[.4,.4],[.05,.05]);
jj=1;
        
set(fig,'CurrentAxes',ax(jj));
        
m_proj('miller','lat',82);
            
m_coast('color','k');hold on;
                
colormap(cm);   
            
[c,h]=m_contourf(lonv,latv,squeeze(coef_qian_gpcp'),(-0.9:0.05:0.9));
            
set(h,'color','none');%colorbar;

m_grid('linestyle','none','box','on','XTicklabel','','FontSize',fontsz);  


jj = 2;        
set(fig,'CurrentAxes',ax(jj));
        
m_proj('miller','lat',[-20 15],'long',[-90 -30]);
           
m_coast('color','k');hold on;
            
colormap(cm);     
                    
[c,h]=m_contourf(lonv,latv,squeeze(coef_qian_gpcp'),(-0.9:0.05:0.9));
    
set(h,'color','none');%colorbar;
                   
m_grid('linestyle','none','box','on','XTicklabel','','YTicklabel','','FontSize',fontsz);        
                                       
set(gca,'FontSize',fontsz);
       
caxis([-.9,0.9]);


jj=3;
        
set(fig,'CurrentAxes',ax(jj));
        
m_proj('miller','lat',82);
            
m_coast('color','k');hold on;
                
colormap(cm);   
            
[c,h]=m_contourf(lonv,latv,squeeze(coef_cru_gpcp'),(-0.9:0.05:0.9));
            
set(h,'color','none');%colorbar;

m_grid('linestyle','none','box','on','FontSize',fontsz);  

jj = 4;        
set(fig,'CurrentAxes',ax(jj));
        
m_proj('miller','lat',[-20 15],'long',[-90 -30]);
           
m_coast('color','k');hold on;
            
colormap(cm);     
                    
[c,h]=m_contourf(lonv,latv,squeeze(coef_cru_gpcp'),(-0.9:0.05:0.9));
    
set(h,'color','none');%colorbar;
                   
m_grid('linestyle','none','box','on','YTicklabel','','FontSize',fontsz);        
                                       
set(gca,'FontSize',fontsz);
       
caxis([-.9,0.9]);


   
pos=get(gca,'pos');

h=colorbar('location','southoutside','position',[pos(1)-0.75*pos(3) pos(2)-0.05 pos(3)*1.5, 0.02 ]);

set(h,'FontSize',fontsz);
set(fig,'color','w');

    
tags={'(a) QIAN vs GPCP','(b) QIAN vs GPCP','(c) CRU vs GPCP','(d) CRU vs GPCP'};

yco=[0.12,0.075,0.12,0.075];
for kk=1:4
    
    put_tag(fig,ax(kk),[0.025,yco(kk)],tags{kk},fontsz);
    
end
