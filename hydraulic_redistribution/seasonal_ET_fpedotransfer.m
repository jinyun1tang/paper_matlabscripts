close all;
clear all;
clc;
%comparison of ET using different pedotransfer functions

plot_opts={'meandif','stdev','meanval','corr_mon','corr_mondif'};
kj=1;
plot_opt=plot_opts{kj};
%plot_opt='meanval';
load('fluxnet_mte_clm.mat');

%use the 10 year mean for comparison
year1=1991;
year2=2000;

id1=(year1-year0)*12+1;
id2=(year2-year0+1)*12;

lh_subset=lh_mean2clm(:,:,id1:id2);

%get the mean season cycle


MJ2mm=1./2.501;
if(strcmp(plot_opt,'corr_mon') || strcmp(plot_opt,'corr_mondif'))
    [lh_month_mean,lh_month_std]=multiyear_mean_month(lh_subset);

else
    
    [lh_season_mean,lh_season_std]=multiyear_mean_season(lh_subset);

    lh_season_mean=lh_season_mean.*MJ2mm;
    lh_season_std=lh_season_std.*MJ2mm;
end
%now load the clm data
mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';
ncf_map=[mdir,'area_info.nc'];
latv=netcdf(ncf_map,'var','lat');
lonv=netcdf(ncf_map,'var','lon');

id=find(lonv>180);
lonv(id)=lonv(id)-360;
dshft=length(lonv)-id(1)+1;
lonv=circshift(lonv,dshft);
ref_files={'clm45evapcosby4','clm45evapdef','clm45evapnoilhan'};


js=[1,2,3];

%mean ET difference
cm=colormap(flipud(othercolor('RdYlBu_11b')));
if(strcmp(plot_opt,'meandif'))

    fig=figure(1);

    ax=multipanel(fig,4,3,[0.1,0.1],[0.25,0.2],[0.06,0.01]);

    for j1=1:3    
        j=js(j1);

    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.50-59.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.50-59.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.50-59.nc'];
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);

    [model_season_mean,model_season_std]=multiyear_mean_season(mean_et_veg);

    
    for jj= 1 : 4

        set(fig,'CurrentAxes',ax((jj-1)*3+j1));
    
        model_data_dif_mean=squeeze(model_season_mean(:,:,jj)-lh_season_mean(:,:,jj));
    
        model_data_dif_mean=double(circshift(model_data_dif_mean,dshft));

    
        m_proj('miller','lat',82);
    
        m_coast('color','k');hold on;
    
        colormap(cm);        
        [c,h]=m_contourf(lonv,latv,squeeze(model_data_dif_mean'),(-1.5:0.1:1.5));

        set(h,'color','none');%colorbar;

        if(jj<4)        
            if(j1>1)
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'XTicklabel','','YTicklabel','','FontSize',10);
            else                
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'XTicklabel','','FontSize',10);
            end
        else            
            if(j1>1)
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'YTicklabel','','FontSize',10);
            else
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'FontSize',10);
            end
        end
    end
end
colorbar;
tags={'(a1)','(b1)','(c1)','(a2)','(b2)','(c2)','(a3)','(b3)','(c3)','(a4)','(b4)','(c4)'};
for kk=1:12
    put_tag(fig,ax(kk),[0.05,0.15],tags{kk},12);
end
put_tag(fig,ax(3),[.1,1.2],'\DeltaET(mm day^-^1)',12);
elseif(strcmp(plot_opt,'meanval'))
fig=figure(1);
ax=multipanel(fig,4,3,[0.1,0.1],[0.25,0.2],[0.06,0.01]);
    
for j1=1:3
    j=js(j1);

    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.50-59.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.50-59.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.50-59.nc'];
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);

    [model_season_mean,model_season_std]=multiyear_mean_season(mean_et_veg);

    
    for jj= 1 : 4

        set(fig,'CurrentAxes',ax((jj-1)*3+j1));
    
        model_data_dif_mean=squeeze(model_season_mean(:,:,jj));
    
        model_data_dif_mean=double(circshift(model_data_dif_mean,dshft));

    
        m_proj('miller','lat',82);
    
        m_coast('color','k');hold on;
    
        colormap(cm);        
        [c,h]=m_contourf(lonv,latv,squeeze(model_data_dif_mean'),(-0.1:0.5:7));

        set(h,'color','none');%colorbar;

        if(jj<4)        
            if(j1>1)
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'XTicklabel','','YTicklabel','','FontSize',10);
            else                
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'XTicklabel','','FontSize',10);
            end
        else            
            if(j1>1)
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'YTicklabel','','FontSize',10);
            else
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'FontSize',10);
            end
        end
    end
end
colorbar;
tags={'(a1)','(b1)','(c1)','(a2)','(b2)','(c2)','(a3)','(b3)','(c3)','(a4)','(b4)','(c4)'};
for kk=1:12
    put_tag(fig,ax(kk),[0.05,0.15],tags{kk},12);
end
put_tag(fig,ax(3),[.1,1.2],'ET (mm day^-^1)',12);

elseif(strcmp(plot_opt,'stdev'))
%standard deviation ratio
fig=figure(1);
ax=multipanel(fig,4,3,[0.1,0.1],[0.25,0.2],[0.06,0.01]);

for j1=1:3
    j=js(j1);

    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.50-59.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.50-59.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.50-59.nc'];
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);

    [model_season_mean,model_season_std]=multiyear_mean_season(mean_et_veg);

    
    for jj= 1 : 4

        set(fig,'CurrentAxes',ax((jj-1)*3+j1));
        
        m_proj('miller','lat',82);
    
        m_coast('color','k');hold on;
    
        colormap(cm);       


        model_data_dif_std=squeeze(sqrt(model_season_std(:,:,jj).^2+lh_season_std(:,:,jj).^2));

        model_data_dif_mean=squeeze(model_season_mean(:,:,jj)-lh_season_mean(:,:,jj));
    
        model_data_dif_mean=double(circshift(model_data_dif_mean,dshft));        

        model_data_dif_std=double(circshift(model_data_dif_std,dshft));
        
        ratio=normalized_std2mean_ratio(model_data_dif_std,model_data_dif_mean);

        [c,h]=m_contourf(lonv,latv,squeeze(ratio'));

        set(h,'color','none');%colorbar;

        if(jj<4)        
            if(j1>1)
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'XTicklabel','','YTicklabel','','FontSize',10);
            else                
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'XTicklabel','','FontSize',10);
            end
        else            
            if(j1>1)
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'YTicklabel','','FontSize',10);
            else
                m_grid('linestyle','none','box','on',...
                    'XTick',(-180:180:180),'FontSize',10);
            end
        end
    end
end
colorbar;
tags={'(a1)','(b1)','(c1)','(a2)','(b2)','(c2)','(a3)','(b3)','(c3)','(a4)','(b4)','(c4)'};
for kk=1:12
    put_tag(fig,ax(kk),[0.05,0.15],tags{kk},12);
end



elseif(strcmp(plot_opt,'corr_mon'))
%correlation of seasonal cycle
fig=figure(1);
ax=multipanel(fig,3,1,[0.1,0.1],[0.8,0.25],[0.05,0.05]);
for j1=1:3
    j=js(j1);

    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.50-59.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.50-59.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.50-59.nc'];
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);

    [model_month_mean,model_month_std]=multiyear_mean_month(mean_et_veg);
    coef=corr_coefm3d(model_month_mean,lh_month_mean);
    set(fig,'CurrentAxes',ax(j1));
        m_proj('miller','lat',82);
    
        m_coast('color','k');hold on;
    
        colormap(cm);     
    coef=double(circshift(coef,dshft));
    [c,h]=m_contourf(lonv,latv,squeeze(coef'),(-0.9:0.05:0.9));
    set(h,'color','none');%colorbar;
    if(j1<3)
        m_grid('linestyle','none','box','on',...
                    'XTicklabel','','FontSize',10);        
    else
        m_grid('linestyle','none','box','on','FontSize',10);          
    end
end
colorbar;
tags={'(a)','(b)','(c)'};
for kk=1:3
    put_tag(fig,ax(kk),[0.05,0.15],tags{kk},12);
end

elseif(strcmp(plot_opt,'corr_mondif'))
fig=figure(1);
ax=multipanel(fig,2,1,[0.1,0.1],[0.8,0.35],[0.05,0.05]);
for j1=1:1
    j=js(j1);

    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.50-59.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.50-59.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.50-59.nc'];
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);

    [model_month_mean,model_month_std]=multiyear_mean_month(mean_et_veg);
    coef=corr_coefm3d(model_month_mean,lh_month_mean);
 
    coef_ref=double(circshift(coef,dshft));
end

for j1=2:3
    j=js(j1);

    %obtain ET for reference runs
    ncf_soil=[mdir,ref_files{j},'/','QSOIL','.',ref_files{j},'.50-59.nc'];
    ncf_vegt=[mdir,ref_files{j},'/','QVEGT','.',ref_files{j},'.50-59.nc'];
    ncf_vege=[mdir,ref_files{j},'/','QVEGE','.',ref_files{j},'.50-59.nc'];
    mean_et_veg=ET_summary(ncf_soil, ncf_vege, ncf_vegt,0);

    [model_month_mean,model_month_std]=multiyear_mean_month(mean_et_veg);
    coef=corr_coefm3d(model_month_mean,lh_month_mean);
    set(fig,'CurrentAxes',ax(j1-1));
        m_proj('miller','lat',82);
    
        m_coast('color','k');hold on;
    
        colormap(cm);     
    coef=double(circshift(coef,dshft))-coef_ref;
    [c,h]=m_contourf(lonv,latv,squeeze(coef'));
    set(h,'color','none');%colorbar;
    if(j1<2)
        m_grid('linestyle','none','box','on',...
                    'XTicklabel','','FontSize',10);        
    else
        m_grid('linestyle','none','box','on','FontSize',10);          
    end
end
colorbar;
end


