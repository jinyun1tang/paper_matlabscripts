close all;
clear all;
clc;

do_sierra=1;
if(do_sierra)
ncf1='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierra_clmdef/h2osoi_def_51-60.nc';
ncf2='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierra_maxlai_hd/h2osoi_maxlai_hd_51-60.nc';
ncf3='/Users/jinyuntang/work/data_collection/clm_output/hd_model/sierra/sierra_clmdef/prec_51-60.nc';
else
ncf1='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/tapajos_clmdef/h2osoi_def_51-60.nc';
ncf2='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/tapajos_maxlai_hd/h2osoi_maxlai_hd_51-60.nc';
ncf3='/Users/jinyuntang/work/data_collection/clm_output/hd_model/tapajos/tapajos_maxlai_hd/prec_51-60.nc';
end
fontsz=18;

watsat=[0.5033095,0.4678569,0.4454694,0.4358359,0.433149,0.4281748,...
    0.4295546,0.4252839,0.42348,0.42852,0.42852,0.42852,0.42852,...
  0.42852,0.42852 ;];
h2osoi1=netcdf(ncf1,'var','H2OSOI');
h2osoi2=netcdf(ncf2,'var','H2OSOI');

h2osoi11=h2osoi1(1:10,:);%./repmat(watsat(1:10)',[1,120]);
h2osoi21=h2osoi2(1:10,:);%./repmat(watsat(1:10)',[1,120]);
depz=getclmz(10);
nyr=6;
id=(1:365)+nyr*365;

%load precipitation data

rain=netcdf(ncf3,'var','RAIN');
snow=netcdf(ncf3,'var','SNOW');
prec=rain+snow;
fig=figure(1);
set(fig,'unit','normalized','position',[0.1,0.1,0.7,0.9],'color','w');
ax=multipanel(fig,2,1,[0.1,0.1],[0.7,0.4],[0.05,0.0]);
set(ax(2),'position',[0.1,0.1,0.7,0.6]);
set(ax(1),'position',[0.1,0.7,0.7,0.2]);

set(fig,'CurrentAxes',ax(1));
bar((1:length(id))-0.5,prec(id).*86400);
ylabel('Prec. (mm day^-^1)','FontSize',fontsz);
set(fig,'CurrentAxes',ax(2));
if(do_sierra)
[c,h]=contourf((1:length(id)),depz,100.*(h2osoi21(:,id)-h2osoi11(:,id)),100.*(-0.25:0.01:0.25));set(h,'color','none');colorbar;
caxis([-20,20]);
else
[c,h]=contourf((1:length(id)),depz,100.*(h2osoi21(:,id)-h2osoi11(:,id)));set(h,'color','none');colorbar;
caxis([-4,4]);
end
xlabel('Ordinal day','FontSize',fontsz);
ylabel('Depth (m)','FontSize',fontsz);
set(ax(2),'FontSize',fontsz);

set(ax(1),'XTickLabel','','FontSize',fontsz);
set(ax,'Xlim',[0,366]);

