function vegetation_removal()
%here tests whether the inclusion of hd has reduced the ET bias
global mdir;
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';


%reference
chdir='clm45evapdef';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf2=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];
ncf3=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];

mean_et_def=ET_summary(ncf1, ncf2, ncf3,0);



%[c,h]=contourf(qet_ref_ave');set(h,'color','none');colorbar;
chdir='clm45evaphdr_ref';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
ncf2=[mdir,chdir,'/','QVEGE','.',chdir,'.50-59.nc'];
ncf3=[mdir,chdir,'/','QVEGT','.',chdir,'.50-59.nc'];


mean_et_hd=ET_summary(ncf1, ncf2, ncf3,0);



%load bare soil evaporation






chdir='clm45evapdef_bs';

ncf1=[mdir,chdir,'/','QSOIL','.',chdir,'.50-59.nc'];
mean_et_bs=ET_summary(ncf1, '', '',0);

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
[etdif_hdrbs_djf,etdif_hdrbs_mam,etdif_hdrbs_jja,etdif_hdrbs_son]=get_season_dif(etdif_hdrbs,dshft);

[etdif_defbs_djf,etdif_defbs_mam,etdif_defbs_jja,etdif_defbs_son]=get_season_dif(etdif_defbs,dshft);


fig=figure(2);
set(fig,'unit','normalized','position',[0.1,0.14,0.3,0.4]);
ax=multipanel(fig,4,2,[0.1,0.1],[0.37,0.17],[0.075,0.01]);

cm=flipud(othercolor('RdBu11'));

colormap(cm);
    
for j = 1 : 4
    set(fig,'CurrentAxes',ax((j-1)*2+1));
    m_proj('miller','lat',82);
    m_coast('color','k');hold on;

    if(j==1)
        [c,h]=m_contourf(lon,lat,etdif_hdrbs_mam');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
    elseif(j==2)
        [c,h]=m_contourf(lon,lat,etdif_hdrbs_jja');set(h,'Color','none');          
        m_grid('linestyle','none','box','fancy','tickdir','out','xtickalbel','','FontSize',12);
    elseif(j==4)
        [c,h]=m_contourf(lon,lat,etdif_hdrbs_djf');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out','FontSize',12);
    else
        [c,h]=m_contourf(lon,lat,etdif_hdrbs_son');set(h,'Color','none');            
        m_grid('linestyle','none','box','fancy','tickdir','out','XTicklabel','','FontSize',12);
        
    end
    caxis([-2, 2]); 
end


for j = 1 : 4
    set(fig,'CurrentAxes',ax(j*2));
    m_proj('miller','lat',82);
    m_coast('color','k');hold on;

    if(j==1)
        [c,h]=m_contourf(lon,lat,etdif_defbs_mam');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out',...
            'XTicklabel','','Ytickalbel','','FontSize',12);
    elseif(j==2)
        [c,h]=m_contourf(lon,lat,etdif_defbs_jja');set(h,'Color','none');          
        m_grid('linestyle','none','box','fancy','tickdir','out',...
            'XTicklabel','','Ytickalbel','','YTicklabel','','FontSize',12);
    elseif(j==4)
        [c,h]=m_contourf(lon,lat,etdif_defbs_djf');set(h,'Color','none');        
        m_grid('linestyle','none','box','fancy','tickdir','out',...
            'YTicklabel','','FontSize',12);
    else
        [c,h]=m_contourf(lon,lat,etdif_defbs_son');set(h,'Color','none');            
        m_grid('linestyle','none','box','fancy','tickdir','out',...
            'XTicklabel','','YTicklabel','','FontSize',12);
        
    end
    caxis([-2, 2]); 
end

tags={'(a1)MAM','(a2)MAM','(b1)JJA','(b2)JJA','(c1)SON','(c2)SON',...
    '(d1)DJF','(d2)DJF'};

for jj = 1 : 8
    put_tag(fig,ax(jj),[0.4,0.2],tags{jj},14);
end

%pos=get(ax(2),'pos');
hc=colorbar('location','eastoutside','position',[0.5 0.3 0.03 0.5]);
set(hc,'FontSize',14);
put_tag(fig,ax(3),[1.05,1.92],'\DeltaET (mm day^-^1)',12);


end


function  [etdif_hdr_djf,etdif_hdr_mam,etdif_hdr_jja,etdif_hdr_son]=get_season_dif(etdif_hdr,dshft)


%get the seasonal mean of the difference
w_djf=[31,28,0,0,0,0,0,0,0,0,0,31]./(31+28+31);
w_mam=[0,0,31,30,31,0,0,0,0,0,0,0]./(31+31+30);
w_jja=[0,0,0,0,0,30,31,31,0,0,0,0]./(31+31+30);
w_son=[0,0,0,0,0,0,0,0,30,31,30,0]./(31+30+30);

sz1=size(etdif_hdr,1);
sz2=size(etdif_hdr,2);
etdif_hdr_djf=zeros(sz1,sz2);
etdif_hdr_mam=zeros(sz1,sz2);
etdif_hdr_jja=zeros(sz1,sz2);
etdif_hdr_son=zeros(sz1,sz2);

for j1 = 1 : sz1
    for j2 = 1 : sz2
        etdif_hdr_djf(j1,j2)=mean(slidew_mean(etdif_hdr(j1,j2,:),12,w_djf));
        etdif_hdr_mam(j1,j2)=mean(slidew_mean(etdif_hdr(j1,j2,:),12,w_mam));
        etdif_hdr_jja(j1,j2)=mean(slidew_mean(etdif_hdr(j1,j2,:),12,w_jja));
        etdif_hdr_son(j1,j2)=mean(slidew_mean(etdif_hdr(j1,j2,:),12,w_son));        
    end
end



etdif_hdr_djf=double(circshift(etdif_hdr_djf,dshft));
etdif_hdr_mam=double(circshift(etdif_hdr_mam,dshft));
etdif_hdr_jja=double(circshift(etdif_hdr_jja,dshft));
etdif_hdr_son=double(circshift(etdif_hdr_son,dshft));

end

