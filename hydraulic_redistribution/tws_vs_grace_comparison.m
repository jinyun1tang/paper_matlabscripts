close all;
clear all;
clc;



load('crudef_tws.mat');
dat_def=dat_g;

load('mat/cruclm45hdr_maxlai_ref.mat');

dat_hdr=dat_g;
clear dat_g;

load('grace.csr.mat');cnt='CSR';

%site level comparison
id=(2003-2000)*12+(1:72);
%site='sierra';

lonp=240;
latp=38.84211;

[iloc,jloc]=find_siteloc(lon_g,lat_g,lonp,latp);
tws_ser_def=squeeze(dat_def(jloc,iloc,:)).*1d-3;
tws_ser_hdr=squeeze(dat_hdr(jloc,iloc,:)).*1d-3;
tws_ser_grace=squeeze(lwe_thickness(iloc,jloc,:)).*scalf(iloc,jloc).*1d-2;

err_ser_grace=tot_err(iloc,jloc).*1d-2;

%tapajos
lonp=305;
latp=-2.356021;
[iloc,jloc]=find_siteloc(lon_g,lat_g,lonp,latp);
tws_tap_def=squeeze(dat_def(jloc,iloc,:)).*1d-3;
tws_tap_hdr=squeeze(dat_hdr(jloc,iloc,:)).*1d-3;
tws_tap_grace=squeeze(lwe_thickness(iloc,jloc,:)).*scalf(iloc,jloc).*1d-2;
err_tap_grace=tot_err(iloc,jloc).*1d-2;
%plot out the time series
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.7,.8]);
ax= multipanel(fig,2,1,[.1,.1],[.8,.4],[.05,.05]);
linw=2;
set(fig,'CurrentAxes',ax(1));
yr=(1:120)./12+2001;

%define the anomaly
tws_ser_def=tws_ser_def-mean(tws_ser_def(id));
tws_ser_hdr=tws_ser_hdr-mean(tws_ser_hdr(id));
tws_tap_def=tws_tap_def-mean(tws_tap_def(id));
tws_tap_hdr=tws_tap_hdr-mean(tws_tap_hdr(id));
hdl=zeros(3,1);
hh=shadedErrorBar(target_mon+2002,tws_ser_grace,err_ser_grace.*ones(size(target_mon)),'k',1);
set(hh.mainLine,'LineWidth',linw);
hdl(1)=hh.mainLine;
hold on;
hdl(2)=plot(yr,tws_ser_def,'linewidth',linw);
hdl(3)=plot(yr,tws_ser_hdr,'r','linewidth',linw);


ylabel('TWSA (m)','FontSize',14);
set(ax(1),'XTickLabel','');

legend(hdl,['GRACE-',cnt],'CLM4.5-CRU','CLM4.5RHR-TCI-CRU');
ylim([-0.4-eps,0.6+eps]);

set(fig,'CurrentAxes',ax(2));

hh=shadedErrorBar(target_mon+2002,tws_tap_grace,err_tap_grace.*ones(size(target_mon)),'k',1);
set(hh.mainLine,'LineWidth',linw);
hold on;
plot(yr,tws_tap_def,'linewidth',linw);
plot(yr,tws_tap_hdr,'r','linewidth',linw);

ylabel('TWSA (m)','FontSize',14);
xlabel('Year','FontSize',14);

set(ax,'FontSize',14,'Xlim',[2001-eps,2011+eps]);
put_tag(fig,ax(1),[.02,.85],'(a) Blodgett Forest',14);
put_tag(fig,ax(2),[.02,.85],'(b) Tapajos Forest',14);
set(fig,'color','w');

%doing statistics
%sierra
id1=find(target_mon+2002<2011);
%interp to measurement temporal grid
tws_ser_def_int=interp1(yr,tws_ser_def,target_mon(id1)+2002);
tws_ser_hdr_int=interp1(yr,tws_ser_hdr,target_mon(id1)+2002);

tws_tap_def_int=interp1(yr,tws_tap_def,target_mon(id1)+2002);
tws_tap_hdr_int=interp1(yr,tws_tap_hdr,target_mon(id1)+2002);

w_def=linearfit(tws_ser_def_int,tws_ser_grace(id1));
w_hdr=linearfit(tws_ser_hdr_int,tws_ser_grace(id1));

fprintf('sierra\n');
fprintf('def:obs=%f*model+%f,rms=%f,r2=%f,p=%f,cor=%f\n',w_def(1),w_def(3),w_def(5),w_def(6),w_def(7:8));
fprintf('hdr:obs=%f*model+%f,rms=%f,r2=%f,p=%f,cor=%f\n',w_hdr(1),w_hdr(3),w_hdr(5),w_hdr(6),w_hdr(7:8));
w_def=linearfit(tws_tap_def_int,tws_tap_grace(id1));
w_hdr=linearfit(tws_tap_hdr_int,tws_tap_grace(id1));

fprintf('tapajos\n');
fprintf('def:obs=%f*model+%f,rms=%f,r2=%f,p=%f,cor=%f\n',w_def(1),w_def(3),w_def(5),w_def(6),w_def(7:8));
fprintf('hdr:obs=%f*model+%f,rms=%f,r2=%f,p=%f,cor=%f\n',w_hdr(1),w_hdr(3),w_hdr(5),w_hdr(6),w_hdr(7:8));

%%
% do global assessment
%
%remove bad vlaues from grace data

id2=find(lwe_thickness>2d4);
lwe_thickness(id2)=0./0.;
%now create the target regrided global time series
tws_def=zeros([size(dat_def,1),size(dat_def,2),length(id1)]);
tws_hdr=tws_def;
%sweep the loops
for j1 =  1 : size(dat_def,1)
    for j2 = 1 : size(dat_def,2)
        if(~any(isnan(dat_def(j1,j2,:))))        
            %extract the grid time series
            ts_def=squeeze(dat_def(j1,j2,:));
            ts_hdr=squeeze(dat_hdr(j1,j2,:));
            %remove the 2004:2009 mean
            ts_def=ts_def-mean(ts_def(id));
            ts_hdr=ts_hdr-mean(ts_hdr(id));
            %interpolate to the target grid
            tws_def(j1,j2,:)=interp1(yr,ts_def,target_mon(id1)+2002).*1d-3;
            tws_hdr(j1,j2,:)=interp1(yr,ts_hdr,target_mon(id1)+2002).*1d-3;     
        else
            tws_def(j1,j2,:)=0./0.;
            tws_hdr(j1,j2,:)=0./0.;
        end
    end
end
%obtain the grace data matrix
tws_grace=zeros(size(lwe_thickness,2),size(lwe_thickness,1),length(id1));




for j1 = 1 : length(id1)
    tws_grace(:,:,j1)=(lwe_thickness(:,:,id1(j1)).*scalf.*1d-2)';
end
clear lwe_thickness;
%calculate correlation for each grid
rcorr_def=zeros([size(tws_def,2),size(tws_def,1)]);
rcorr_hdr=zeros([size(tws_def,2),size(tws_def,1)]);
rms_def=zeros([size(tws_def,2),size(tws_def,1)]);
rms_hdr=zeros([size(tws_def,2),size(tws_def,1)]);

for j1 =  1 : size(tws_def,1)
    for j2 = 1 : size(tws_def,2)
        if(any(isnan(tws_def(j1,j2,:))) || any(isnan(tws_grace(j1,j2,:))) || j1<30)  
            rcorr_def(j2,j1)=0./0.;
            rcorr_hdr(j2,j1)=0./0.;
            rms_def(j2,j1)=0./0.;
            rms_hdr(j2,j1)=0./0.;

        else
            rcorr_def(j2,j1)=corr_coefv(squeeze(tws_def(j1,j2,:)),squeeze(tws_grace(j1,j2,:)));
            rcorr_hdr(j2,j1)=corr_coefv(squeeze(tws_hdr(j1,j2,:)),squeeze(tws_grace(j1,j2,:)));
            
            rms_def(j2,j1)=rms_ts(squeeze(tws_def(j1,j2,:)),squeeze(tws_grace(j1,j2,:)))./(tot_err(j2,j1).*1d-2);
            rms_hdr(j2,j1)=rms_ts(squeeze(tws_hdr(j1,j2,:)),squeeze(tws_grace(j1,j2,:)))./(tot_err(j2,j1).*1d-2);

        end
    end
end

idxx=find(rms_def>3);
rms_def(idxx)=0./0.;
rms_hdr(idxx)=0./0.;
rcorr_def(idxx)=0./0.;
rcorr_hdr(idxx)=0./0.;
lon_g=lon_g';
lat_g=lat_g';

id=find(lon_g>180);
lon_g(id)=lon_g(id)-360;

dshft=length(lon_g)-id(1)+1;

lon_g=circshift(lon_g,dshft);

fig=figure(2);
fontsz=14;

set(fig,'unit','normalized','position',[.1,.1,.7,.6]);

ax=multipanel(fig,1,2,[0.1,0.12],[0.4,0.8],[0.05,0.05]);
for jj = 1 : 2
        
    set(fig,'CurrentAxes',ax(jj));
    
    
    
    m_proj('miller','lat',82);
        
    
    
    m_coast('color','k');hold on;
            
    switch jj
        case 1
            rcorr_def=double(circshift(rcorr_def,dshft));
            
            [c,h]=m_contourf(lon_g,lat_g,rcorr_def',(-1.:0.05:1.0));    
            m_grid('linestyle','none','box','on',...
                    'FontSize',fontsz);    
        case 2
            rcorr_hdr=double(circshift(rcorr_hdr,dshft));
            [c,h]=m_contourf(lon_g,lat_g,rcorr_hdr',(-1.:0.05:1.0));   
             m_grid('linestyle','none','box','on',...
                    'YTicklabel','','FontSize',fontsz);            
        case 3
            rms_def=double(circshift(rms_def,dshft));
            [c,h]=m_contourf(lon_g,lat_g,rms_def',(0:0.025:1));    
               m_grid('linestyle','none','box','on',...
                    'FontSize',fontsz);          
            
        otherwise
            rms_hdr=double(circshift(rms_hdr,dshft));
            [c,h]=m_contourf(lon_g,lat_g,rms_hdr',(0:0.025:1));   
              m_grid('linestyle','none','box','on',...
                    'YTicklabel','','FontSize',fontsz);           
    end

    caxis([-1.0,1.0]);
    set(h,'color','none');%colorbar;
end

pos=get(gca,'pos');


h=colorbar('location','southoutside','position',[pos(1)-0.75*pos(3) pos(2)-0.005 pos(3)*1.5, 0.05 ]);


set(h,'FontSize',fontsz);

put_tag(fig,ax(1),[.02,.125],'(a) CLM4.5-CRU',14);
put_tag(fig,ax(2),[.02,.125],'(b) CLM4.5RHR-TCI-CRU',14);

set(fig,'color','w');

%%%
fig=figure(3);
set(fig,'unit','normalized','position',[.1,.1,.75,.9]);

ax=multipanel(fig,2,2,[0.1,0.08],[0.4,0.375],[0.075,0.032]);
for jj = 1 : 4
        
    set(fig,'CurrentAxes',ax(jj));
    
    
    if(jj<=2)    
        m_proj('miller','lat',82);                    
        m_coast('color','k');hold on;
    end
            
    switch jj
          
        case 1
            rms_def=double(circshift(rms_def,dshft));
            [c,h]=m_contourf(lon_g,lat_g,rms_def',(0:0.1:3));    
               m_grid('linestyle','none','box','on',...
                    'FontSize',fontsz);          
            
        case 2
            rms_hdr=double(circshift(rms_hdr,dshft));
            [c,h]=m_contourf(lon_g,lat_g,rms_hdr',(0:0.1:3));   
              m_grid('linestyle','none','box','on',...
                    'YTicklabel','','FontSize',fontsz);    

        case 3
            %histogram
            id=find(~isnan(rms_def));
            [N,X]=hist(rms_def(id),100);
            h=bar(X,N);
            set(h,'FaceColor','w','EdgeColor','b');
            hold on;
            [N,X]=hist(rms_hdr(id),100);
            h=bar(X,N);
            set(h,'FaceColor','w','EdgeColor','r');
            
            xlim([-0.01,10.]);

            set(gca,'FontSize',14);
            xlabel('Mean RMSE of predicted TWSA (m)','FontSize',14);
            legend('CLM4.5-CRU','CLM4.5RHR-TCI-CRU');            
        otherwise
            bin_out_mean=latitude_bin(rms_def,2);
            plot(lat_g,bin_out_mean,'LineWidth',linw);
            hold on;
            bin_out_mean=latitude_bin(rms_hdr,2);
            plot(lat_g,bin_out_mean,'r','LineWidth',linw);    
            ylabel('Mean RMSE of predicted TWSA (m)','FontSize',14);     
            xlabel('Latitude (degree north)','FontSize',14);
            xlim([-90,90]);
            set(gca,'FontSize',14);
            legend('CLM4.5-CRU','CLM4.5RHR-TCI-CRU');
    end
    if(jj<=2)   
        caxis([0.0,3]);    
        set(h,'color','none');%colorbar;
    end
end

pos=get(ax(2),'pos');

hc=colorbar('location','southoutside','position',[0.25 0.88 0.5 0.04]);    
set(hc,'FontSize',14);

%h=colorbar('location','southoutside','position',[pos(1)-0.75*pos(3) pos(2)-0.005 pos(3)*1.5, 0.05 ]);
caxis([0,3]);


put_tag(fig,ax(1),[.02,.125],'(a) CLM4.5-CRU',14);
put_tag(fig,ax(2),[.02,.125],'(b) CLM4.5RHR-TCI-CRU',14);
put_tag(fig,ax(3),[.02,.935],'(c) ',14);
put_tag(fig,ax(4),[.02,.935],'(d) ',14);
put_tag(fig,ax(2),[-.2,1.3],'Normalized RMSE of predicted TWSA',14);

set(fig,'color','w');

fig=figure(4);
set(fig,'unit','normalized','position',[.1,.1,.5,.6]);        
m_proj('miller','lat',82);                    

m_coast('color','k');hold on;
            
[c,h]=m_contourf(lon_g,lat_g,rms_hdr'-rms_def',(-3:0.1:3));   set(h,'color','none');%colorbar;

m_grid('linestyle','none','box','on','FontSize',fontsz);  
hc=colorbar('location','southoutside','position',[0.25 0.88 0.5 0.04]);    
set(hc,'FontSize',14);
caxis([-3,3]);
set(gcf,'color','w');
xlabel('Change in mean RMSE of predicted TWSA (m)','FontSize',14);
