close all;
clear all;
clc;



mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

varname='H2OSOI';
chdir='clm45evapdef';
ncf1=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];


chdir='clm45hdr_maxlai_ref';
ncf2=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];

chdir='clm45evaphdr_seq_maxlai';
ncf3=[mdir,chdir,'/',varname,'.',chdir,'.51-60.nc'];

ncf4=[mdir,'def_soihydp.nc'];
fontsz=14;
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.8,.9]);
ax=multipanel(fig,4,2,[.1,.1],[.4,.185],[.05,.025]);

for sierra=1 :2
%sierra    
if(sierra==1)
    lonp=240;
    latp=38.84211;

    load('mat/blodgett_swc.mat');
    
    %10 cm and 20 cm
    obs_sat=[.46,.50];
else    
    %tapajos
    lonp=305;
    latp=-2.356021;
    obs_sat=[0.52,0.52];
    load('mat/tapajos_km83_swc.mat');
    %10 cm and 20 cm
end

id=find(m1.v==0);m1.v(id)=0./0.;
id=find(m2.v==0);m2.v(id)=0./0.;
m1.v=m1.v./100;
m2.v=m2.v./100;



ncf_map=[mdir,'area_info.nc'];
lonv=netcdf(ncf_map,'var','lon');
latv=netcdf(ncf_map,'var','lat');
[iloc,jloc]=find_siteloc(lonv,latv,lonp,latp);

%get saturated moisture content

h2osoi_ref=get_clm_sitedat(ncf1,iloc,jloc,varname);

h2osoi_cm=get_clm_sitedat(ncf2,iloc,jloc,varname);

h2osoi_sm=get_clm_sitedat(ncf3,iloc,jloc,varname);

h2osoi_watsat=get_clm_sitedat(ncf4,iloc,jloc,'WATSAT');

j0=(sierra-1)*2;
for j = 1 : 2

    %j=1: 10 cm, j=2: 20cm
    set(fig,'CurrentAxes',ax((j+j0)*2-1));
    dat=h2osoi_ref(3+j,:);
    dat=reshape(dat,[12,length(dat)/12]);
    hh=errorbar((1:12),mean(dat,2),std(dat,0,2));
    set(hh,'LineWidth',2);
    hold on;
    
    
    dat=h2osoi_cm(3+j,:);
    dat=reshape(dat,[12,length(dat)/12]);
    hh=errorbar((1:12),mean(dat,2),std(dat,0,2));
    set(hh,'LineWidth',2,'color','r');
    
    dat=h2osoi_sm(3+j,:);
    dat=reshape(dat,[12,length(dat)/12]);
    hh=errorbar((1:12),mean(dat,2),std(dat,0,2));
    set(hh,'LineWidth',2,'color','k');
    if(j==1)    
        boxplot(m1.v');
    else        
        boxplot(m2.v');
    end
    if(j0==0)
        ylim([0.,0.4]);
    else       
        ylim([0.2,0.61]);
    end
    txt = findobj(ax((j+j0)*2-1),'Type','text');

    set(txt,'FontSize', fontsz);      
    ylabel('Soil moisture (v/v)','FontSize', fontsz);
    
    
    set(fig,'CurrentAxes',ax((j+j0)*2));
    dat=h2osoi_ref(3+j,:)./h2osoi_watsat(3+j);
    dat=reshape(dat,[12,length(dat)/12]);
    hh=errorbar((1:12),mean(dat,2),std(dat,0,2));
    set(hh,'LineWidth',2);
    hold on;

    dat=h2osoi_cm(3+j,:)./h2osoi_watsat(3+j);
    dat=reshape(dat,[12,length(dat)/12]);
    hh=errorbar((1:12),mean(dat,2),std(dat,0,2));
    set(hh,'LineWidth',2,'color','r');

    dat=h2osoi_sm(3+j,:)./h2osoi_watsat(3+j);
    dat=reshape(dat,[12,length(dat)/12]);
    hh=errorbar((1:12),mean(dat,2),std(dat,0,2));
    set(hh,'LineWidth',2,'color','k');    
    
    if(j==1)    
        boxplot(m1.v'./obs_sat(j));
    else        
        boxplot(m2.v'./obs_sat(j));
    end
    txt = findobj(ax((j+j0)*2),'Type','text');

    ylim([0.2,1.0]);
    set(txt,'FontSize', fontsz);      
    ylabel('\theta/\theta_s_a_t','FontSize', fontsz);   
end

end
set(ax(1:6),'XTick',(1:12),'XTickLabel','');
set(ax(7),'XTick',(1:12),'XTickLabel',num2cellstr((1:12)));
set(fig,'CurrentAxes',ax(7));
xlabel('Month','FontSize',fontsz);
set(fig,'CurrentAxes',ax(8));
xlabel('Month','FontSize',fontsz);

set(ax,'FontSize', fontsz);
legend('CLM4.5','CLM4.5RHR-TCI','CLM4.5RHR-SCI');

put_tag(fig,ax(1),[.025,.1],'(a1) Blodgett Forest, 10 cm deep',fontsz);
put_tag(fig,ax(3),[.025,.1],'(b1) Blodgett Forest, 20 cm deep',fontsz);
put_tag(fig,ax(5),[.025,.85],'(c1) Tapajos Forest, 10 cm deep',fontsz);
put_tag(fig,ax(7),[.025,.1],'(d1) Tapajos Forest, 20 cm deep',fontsz);


put_tag(fig,ax(2),[.025,.1],'(a2) Blodgett Forest, 10 cm deep',fontsz);
put_tag(fig,ax(4),[.025,.1],'(b2) Blodgett Forest, 20 cm deep',fontsz);
put_tag(fig,ax(6),[.025,.85],'(c2) Tapajos Forest, 10 cm deep',fontsz);
put_tag(fig,ax(8),[.025,.1],'(d2) Tapajos Forest, 20 cm deep',fontsz);


set(fig,'color','w');



