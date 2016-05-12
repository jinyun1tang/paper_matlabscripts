close all;
clear all;
clc;
%zhang's curve
p=(200:3500);
forest=(1+2*1410./p)./(1+2.*1410./p+p./1410).*p;
grass=(1+0.5*1100./p)./(1+0.5*1100./p+p./1100).*p;

fig=figure(1);
set(fig,'unit','normalized','position',[0.2,0.2,0.5,0.7]);
ax=multipanel(fig,2,2,[0.11,0.1],[0.4,0.4],[0.05,0.075]);delete(ax(4));

tsum=86400.*365.0;
wt=[31,28,31,30,31,30,31,31,30,31,30,31]';
wt=repmat(wt,[5,1]);
%load beta simulaiton
pft=netcdf('/Users/jinyuntang/work//data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_itype_veg');
pft_lunit=netcdf('/Users/jinyuntang/work//data_collection/clm_output/DiffBound/pft_info.nc','var','pfts1d_itype_lunit');
data=netcdf('/Users/jinyuntang/work//data_collection/clm_output/SoilEvap/qsoi_pch_ch_beta_pft.nc','var','QSOIL');
tarr=[[6,7,8,9,10,11],[6,7,8,9,10,11]+12,[6,7,8,9,10,11]+24,[6,7,8,9,10,11]+36,[6,7,8,9,10,11]+48];
%tarr=[[1,2,3,4,5,12],[1,2,3,4,5,12]+12,[1,2,3,4,5,12]+24,[1,2,3,4,5,12]+36,[1,2,3,4,5,12]+48];

data1=data(:,tarr);
wt=wt(tarr);
qsoil_beta=wmean(data1,wt',2).*tsum;

data=netcdf('/Users/jinyuntang/work//data_collection/clm_output/SoilEvap/qveg_pch_ch_beta_pft_new.nc','var','QVEGE');
data1=data(:,tarr);
qvege_beta=wmean(data1,wt',2);
data=netcdf('/Users/jinyuntang/work//data_collection/clm_output/SoilEvap/qveg_pch_ch_beta_pft_new.nc','var','QVEGT');
data1=data(:,tarr);
qvegt_beta=wmean(data1,wt',2);

data=netcdf('/Users/jinyuntang/work//data_collection/clm_output/SoilEvap/qsoi_pch_chbet_pft_new.nc','var','QSOIL');
data1=data(:,tarr);
qsoil_new=wmean(data1,wt',2).*tsum;

data=netcdf('/Users/jinyuntang/work//data_collection/clm_output/SoilEvap/qveg_pch_chbet_pft_new.nc','var','QVEGE');
data1=data(:,tarr);
qvege_new=wmean(data1,wt',2);
data=netcdf('/Users/jinyuntang/work//data_collection/clm_output/SoilEvap/qveg_pch_chbet_pft_new.nc','var','QVEGT');
data1=data(:,tarr);
qvegt_new=wmean(data1,wt',2);

qveg_beta=(qvege_beta+qvegt_beta).*tsum;
qveg_new =(qvege_new +qvegt_beta).*tsum;
load('../diffuse_boundary/prec_pft.mat');
prec_pft=prec_pft.*tsum;
id=find(pft==0 & pft_lunit==1);
id1=find(abs(qsoil_beta(id))<1d10 & abs(qsoil_beta(id))>0d2 );

%plot 1
set(fig,'CurrentAxes',ax(1));

h(1)=plot(prec_pft(id(id1)),qsoil_beta(id(id1)),'kx','MarkerSize',4);hold on;
rsoi_beta=qsoil_beta(id(id1))./prec_pft(id(id1));
h(2)=plot(prec_pft(id(id1)),qsoil_new(id(id1)),'g.','MarkerSize',4);
rsoi_new=qsoil_new(id(id1))./prec_pft(id(id1));
h(3)=plot(p,forest,'LineWidth',2);hold on;
h(4)=plot(p,grass,'r','LineWidth',2);
xlabel('Precipitation (mm yr^-^1)','FontSize',14);
ylabel('Evapotranspiration (mm yr^-^1)','FontSize',14);
set(gca,'FontSize',14,'Ylim',[-200,6000],'XTickLabel','');
prec_soi=prec_pft(id(id1));
%legend(h,'CLM4 default','CLM4-New','Forest','Grass','Location','Northeast');
%plot 2
clear h;
set(fig,'CurrentAxes',ax(2));
id=find(pft>=1 & pft <=8);
id1=find(abs(qveg_beta(id))<1d10 & abs(qveg_beta(id))>0d2);



h(1)=plot(prec_pft(id(id1)),qveg_beta(id(id1)),'kx','MarkerSize',4);hold on;
h(2)=plot(prec_pft(id(id1)),qveg_new(id(id1)),'g.','MarkerSize',4);
h(3)=plot(p,forest,'LineWidth',2);
h(4)=plot(p,grass,'r','LineWidth',2);
rfor_beta=qveg_beta(id(id1))./prec_pft(id(id1));
rfor_new=qveg_new(id(id1))./prec_pft(id(id1));
prec_for=prec_pft(id(id1));
xlabel('Precipitation (mm yr^-^1)','FontSize',14);
%ylabel('Evapo-transpiration (mm/yr)','FontSize',14);
set(gca,'FontSize',14,'Ylim',[-200,6000],'YTickLabel','');

%legend(h,'Forest','Grass','CLM4 default','CLM4-New','Location','Southeast');
%plot 3
clear h;
set(fig,'CurrentAxes',ax(3));

id=find(pft>=12 & pft <=16);
id1=find(abs(qveg_beta(id))<1d10 & abs(qveg_beta(id))>0d2);



plot(prec_pft(id(id1)),qveg_beta(id(id1)),'kx','MarkerSize',4);hold on;
plot(prec_pft(id(id1)),qveg_new(id(id1)),'g.','MarkerSize',4);
h(1)=plot(6000,6002,'kx','MarkerSize',10);
h(2)=plot(6000,6002,'g.','MarkerSize',10);
h(3)=plot(p,forest,'LineWidth',2);hold on;
h(4)=plot(p,grass,'r','LineWidth',2);
prec_grs=prec_pft(id(id1));
rgrs_beta=qveg_beta(id(id1))./prec_pft(id(id1));
rgrs_new =qveg_new(id(id1))./prec_pft(id(id1));
xlabel('Precipitation (mm yr^-^1)','FontSize',14);
ylabel('Evapotranspiration (mm yr^-^1)','FontSize',14);
set(gca,'FontSize',14,'Ylim',[-200,6000]);

hh=legend(h,'CLM4 Default','CLM4 New','Forest','Grass');
hc = get(hh,'children');

tags={'(a) Bare soil','(b) Forest','(c) Grass'};
for j = 1 : 3
    set(fig,'CurrentAxes',ax(j));
    plot((0:6000),(0:6000),'k-','LineWidth',2);
    put_tag(fig,ax(j),[0.1,0.9],tags{j},14);    
end
set(hh,'position',[0.7,0.1,0.15,0.2]);

fig2=2;
figure(fig2);
set(fig2,'unit','normalized','position',[0.2,0.2,0.5,0.7]);
ax=multipanel(fig2,2,2,[0.11,0.1],[0.4,0.38],[0.075,0.1]);delete(ax(4));

set(fig2,'CurrentAxes',ax(1));
[n1,x1]=hist(rsoi_beta,100);
bar(x1,n1./sum(n1),'FaceColor','none','EdgeColor','b');
hold on;
[n2,x2]=hist(rsoi_new,100);
bar(x2,n2./sum(n2),'FaceColor','none','EdgeColor','r');

%h1=findobj(ax(1),'Type','Patch');
%set(h1,'FaceColor','none');
%set(h1(1),'EdgeColor','b','FaceColor','none');
%set(h1(2),'EdgeColor','r');
xlim([-2,4]);
set(fig2,'CurrentAxes',ax(2));
[n1,x1]=hist(rfor_beta,100);
bar(x1,n1./sum(n1),'FaceColor','none','EdgeColor','b');
hold on;
[n1,x1]=hist(rfor_new,100);
bar(x1,n1./sum(n1),'FaceColor','none','EdgeColor','r');
h1=findobj(ax(2),'Type','Patch');
%set(h1,'FaceColor','none');
%set(h1(1),'EdgeColor','b','FaceColor','none');
%set(h1(2),'EdgeColor','r');
xlim([-2,4]);
set(fig2,'CurrentAxes',ax(3));
[n1,x1]=hist(rgrs_beta,100);
bar(x1,n1./sum(n1),'FaceColor','none','EdgeColor','b','LineStyle','--');
hold on;
[n1,x1]=hist(rgrs_new,100);
bar(x1,n1./sum(n1),'FaceColor','none','EdgeColor','r','LineStyle','-.');

%h1=findobj(ax(3),'Type','Patch');
%set(h1,'FaceColor','none');
%set(h1(1),'EdgeColor','b','FaceColor','none');
%set(h1(2),'EdgeColor','r');
xlim([-2,4]);

lh=legend('CLM4-Default','CLM4-New');
set(lh,'position',[0.7,0.1,0.15,0.2]);
for j = 1 : 3
    set(fig2,'CurrentAxes',ax(j));
    set(ax(j),'FontSize',14);
    xlabel('ET/Prec','FontSize',14);
    ylabel('Relative frequency','FontSize',14);
    put_tag(fig2,ax(j),[0.01,0.9],tags{j},14);    
end
fprintf('base soil: ');
[H,P,KSSTAT]=kstest2(rsoi_beta,rsoi_new);
fprintf('H=%d,P=%f,KSSTAT=%f\n',H,P,KSSTAT);
fprintf('forest: ');
[H,P,KSSTAT]=kstest2(rfor_beta,rfor_new);
fprintf('H=%d,P=%f,KSSTAT=%f\n',H,P,KSSTAT);
fprintf('grass: ');
[H,P,KSSTAT]=kstest2(rgrs_beta,rgrs_new);
fprintf('H=%d,P=%f,KSSTAT=%f\n',H,P,KSSTAT);
