function vegetation_removal_annual()
%here tests whether the inclusion of hd has reduced the ET bias
close all;
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

do_cru=0;
%reference
if(do_cru)
    chdir='cruclm45def';
else    
    chdir='clm45evapdef';
end
ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
ncf2=[mdir,chdir,'/','QVEGE','.',chdir,'.51-60.nc'];
ncf3=[mdir,chdir,'/','QVEGT','.',chdir,'.51-60.nc'];

mean_et_def=ET_summary(ncf1, ncf2, ncf3,1);

et_def=ET_summary(ncf1, ncf2, ncf3,0);


%[c,h]=contourf(qet_ref_ave');set(h,'color','none');colorbar;
if(do_cru)
    chdir='cruclm45hd_maxlai_ref';
else    
    chdir='clm45hdr_maxlai_ref';
end
ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
ncf2=[mdir,chdir,'/','QVEGE','.',chdir,'.51-60.nc'];
ncf3=[mdir,chdir,'/','QVEGT','.',chdir,'.51-60.nc'];


mean_et_hd=ET_summary(ncf1, ncf2, ncf3,1);


et_hd=ET_summary(ncf1, ncf2, ncf3,0);
%load bare soil evaporation


if(do_cru)
    chdir='cruclm45_baresoi';
else    
    chdir='clm45evapdef_bs';
end

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.51-60.nc'];
mean_et_bs=ET_summary(ncf1, '', '',1);

et_bs=ET_summary(ncf1, '', '',0);

etdif_hdrbs=mean_et_bs-mean_et_hd;

etdif_defbs=mean_et_bs-mean_et_def;





%load coordinate system
ncf_map=[mdir,'area_info.nc'];

lon=netcdf(ncf_map,'var','lon');
lat=netcdf(ncf_map,'var','lat');
id=find(lon>180);
lon(id)=lon(id)-360;
dshft=length(lon)-id(1)+1;
lon=circshift(lon,dshft);
%reset

etdif_hdrbs=double(circshift(etdif_hdrbs,dshft));
etdif_defbs=double(circshift(etdif_defbs,dshft));

fig=figure(1);
set(fig,'unit','normalized','position',[0.1,0.14,0.675,0.8]);
ax=multipanel(fig,2,2,[0.1,0.09],[0.5,0.4],[0.075,0.01]);
delete(ax(4));

set(ax(2),'position',[0.7,.09,.25,.8]);
cm=flipud(othercolor('RdBu11'));

colormap(cm);
    
for j = 1 : 2
    set(fig,'CurrentAxes',ax((j-1)*2+1));
    m_proj('miller','lat',82);
    m_coast('color','k');hold on;

    if(j==1)
        [c,h]=m_contourf(lon,lat,etdif_hdrbs');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
    elseif(j==2)
        [c,h]=m_contourf(lon,lat,etdif_defbs');set(h,'Color','none');          
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
    end
    caxis([-2, 2]); 
end

%do the latitudinal bin
year1=1991;
year2=2000;
wt0=[31,28,31,30,31,30,31,31,30,31,30,31];
wt=repmat(wt0,[1,(year2-year1+1)]); 



[delta_et_defbs_lat_bined_mean,delta_et_defbs_lat_bined_std]=latitude_bin_time(et_bs-et_def,2,wt);

[delta_et_hdbs_lat_bined_mean,delta_et_hdbs_lat_bined_std]=latitude_bin_time(et_bs-et_hd,2,wt);



set(fig,'CurrentAxes',ax(2));


hh1=herrorbar(delta_et_defbs_lat_bined_mean,lat,delta_et_defbs_lat_bined_std);

hold on;

hh2=herrorbar(delta_et_hdbs_lat_bined_mean,lat,delta_et_hdbs_lat_bined_std);

set(hh2,'color','r');
hh=[hh1(1),hh2(1)];
if(do_cru)
    legend(hh,'CLM4.5-CRU','CLM4.5RHR-TCI-CRU');
else
    legend(hh,'CLM4.5','CLM4.5RHR-TCI');
end
set(ax(2),'FontSize',14,'Ylim',[-90,90]);
ylabel('Latitude','FontSize',14);
xlabel('\deltaET (mm day^-^1)','FontSize',14);
if(do_cru)
    tags={'(a)CLM4.5RHR-TCI-CRU veg removal','(c)','(b)CLM4.5-CRU veg removal'};
else    
    tags={'(a)CLM4.5RHR-TCI veg removal','(c)','(b)CLM4.5 veg removal'};
end

for jj = 1 : 3
    if(mod(jj,2))    
        put_tag(fig,ax(jj),[0.35,0.2],tags{jj},14);
    else
        put_tag(fig,ax(jj),[0.05,0.02],tags{jj},14);        
    end
end



%pos=get(ax(2),'pos');
hc=colorbar('location','northoutside','position',[0.15 0.92 0.6 0.03]);
set(hc,'FontSize',14);
put_tag(fig,ax(1),[1.45,1.05],'\deltaET (mm day^-^1)',14);
id=find(~isnan(etdif_hdrbs));

fig1=figure(2);
set(fig1,'unit','normalized','position',[0.1,0.14,0.72,0.576]);
ax=multipanel(fig1,1,2,[.08,.15],[.4,.8],[.075,.05]);
set(fig1,'CurrentAxes',ax(1));

plot(etdif_defbs(id),etdif_hdrbs(id),'.');
axis square;
line([-1.5,1.5],[-1.5,1.5],'color','r','LineWidth',2);
line([-1.5,1.5],[0,0],'color','k','LineWidth',2);
line([0,0],[-1.5,1.5],'color','k','LineWidth',2);

set(ax(1),'FontSize',14,'Xlim',[-1.5,1.5],'Ylim',[-1.5,1.5]);
grid on;
if(do_cru)
    ylabel('CLM4.5RHR-TCI-CRU \deltaET (mm day^-^1)','FontSize',12);
    xlabel('CLM4.5-CRU \deltaET (mm day^-^1)','FontSize',12);
else    
    ylabel('CLM4.5RHR-TCI \deltaET (mm day^-^1)','FontSize',12);
    xlabel('CLM4.5 \deltaET (mm day^-^1)','FontSize',12);
end

set(fig1,'CurrentAxes',ax(2));
%do precipitation


ncf1=[mdir,chdir,'/','RAIN','.',chdir,'.51-60.nc'];
mean_rain=fluxvar_summary(ncf1,'RAIN');

ncf1=[mdir,chdir,'/','SNOW','.',chdir,'.51-60.nc'];
mean_snow=fluxvar_summary(ncf1,'SNOW');

mean_prec=mean_rain+mean_snow;

plot(mean_prec(id).*0.1,etdif_defbs(id),'.','MarkerSize',20);
hold on;
plot(mean_prec(id).*0.1,etdif_hdrbs(id),'ro');
set(gca,'Ylim',[0,1.5],'Xlim',[0,1.5],'XTickLabel',{'0','5','10','15'});
if(do_cru)
    legend('CLM4.5-CRU','CLM4.5RHR-TCI-CRU');
else
    legend('CLM4.5','CLM4.5RHR-TCI');
end
ylabel('\deltaET (mm day^-^1)','FontSize',12);
xlabel('Precipitation (mm day^-^1)','FontSize',12);
set(gca,'FontSize',14);
put_tag(fig1,ax(1),[.1,.9],'(a)',14);
put_tag(fig1,ax(2),[.1,.9],'(b)',14);
set(fig1,'color','w');
set(fig,'color','w');
end



