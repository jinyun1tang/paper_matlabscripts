close all;
clear all;
clc;



lat=load('figure2_txt/latitude_1991-2000.txt');
time=load('figure2_txt/time_ts.txt');
dat=load('figure2_txt/gpp_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;gpp=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/npp_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;npp=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/lh_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;lh=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/somc_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;somc=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/somn_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;somn=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/vegc_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;vegc=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/vegn_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;vegn=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/tlai_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;lai=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/nee_ts_1850-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;nee=reshape(dat,[numel(dat)/6,6]);

clr={'b','g','r','c','k'};

purple= [0.5 0 0.5];



fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.7,.9]);
ax1=multipanel(fig,3,3,[0.065,0.065],[0.25,0.25],[0.075,0.06]);



ax=zeros(10,1);

ax(3:10)=ax1(2:9);

pos1=get(ax1(1),'position');
delete(ax1(1));

linewd=1.2;

ax(1)=subplot(5,3,1);

ax(2)=subplot(5,3,4);


set(ax(1),'position',[pos1(1),pos1(2),pos1(3),pos1(4)/2]);
set(ax(2),'position',[pos1(1),pos1(2)+pos1(4)/2,pos1(3),pos1(4)/2]);
%%
set(fig,'CurrentAxes',ax(2));

for jj = 1 : 6
    if(jj==1)
        plot(time,-nee(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(time,-nee(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylim([-300,100]);
ylabel('Cumulative NEE (g C m^-^2)','FontSize',14);
set(fig,'CurrentAxes',ax(1));
nee_plic=nee(:,3);
id=(nee_plic>300);
plot(time(id),-nee_plic(id),clr{4},'LineWidth',linewd);
ylim([-1600,-300]);
xlabel('Year','FontSize',14);

set(ax(2),'XTickLabel','');
%%
set(fig,'CurrentAxes',ax(3));
hdl=zeros(6,1);
for jj = 1 : 6
    if(jj==1)
        hdl(6-jj+1)=plot(lat,gpp(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        hdl(6-jj+1)=plot(lat,gpp(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('GPP (gC m^-^2 yr^-1)','FontSize',14);
xlabel('Latitude','FontSize',14);
legend(hdl,'MNL','NUL','PNL','PNLIC','PNLO','Default');

fprintf('%10s %10s %10s %10s %10s %10s\n','MNL','NUL','PNL','PNLIC','PNLO','Default');
fprintf('%10.3f %10.3f %10.3f %10.3f %10.3f %10.3f\n',nee(end,6:-1:1));
%%
set(fig,'CurrentAxes',ax(4));
for jj = 1 : 6
    if(jj==1)
        plot(lat,npp(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,npp(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('NPP (gC m^-^2 yr^-1)','FontSize',14);
xlabel('Latitude','FontSize',14);

%%
set(fig,'CurrentAxes',ax(5));
for jj = 1 : 6
    if(jj==1)
        plot(lat,lai(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,lai(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('July leaf area index (None)','FontSize',14);
xlabel('Latitude','FontSize',14);

%%
set(fig,'CurrentAxes',ax(6));
for jj = 1 : 6
    if(jj==1)
        plot(lat,lh(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,lh(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('July latent heat flux (W m^-^2)','FontSize',14);
xlabel('Latitude','FontSize',14);

%%
set(fig,'CurrentAxes',ax(7));
for jj = 1 : 6
    if(jj==1)
        plot(lat,somc(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,somc(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('Total SOMC to 1 m (Pg C)','FontSize',14);
xlabel('Latitude','FontSize',14);

%%
set(fig,'CurrentAxes',ax(8));
for jj = 1 : 6
    if(jj==1)
        plot(lat,somn(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,somn(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('Total SOMN to 1 m (Pg N)','FontSize',14);
xlabel('Latitude','FontSize',14);

%%
set(fig,'CurrentAxes',ax(9));
for jj = 1 : 6
    if(jj==1)
        plot(lat,vegc(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,vegc(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('Total Veg C (Pg C)','FontSize',14);
xlabel('Latitude','FontSize',14);

%%
set(fig,'CurrentAxes',ax(10));
for jj = 1 : 6
    if(jj==1)
        plot(lat,vegn(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,vegn(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('Total Veg N (Pg N)','FontSize',14);
xlabel('Latitude','FontSize',14);


set(ax,'FontSize',14);
set(fig,'color','w');


tags={'a','b','c','d','e','f','g','h','i'};

put_tag(fig,ax(1),[0.05,.2],tags{1},14); 
for jj = 2 : 9
   put_tag(fig,ax(jj+1),[0.05,.1],tags{jj},14); 
end

