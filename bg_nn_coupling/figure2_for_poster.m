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
ax1=multipanel(fig,3,3,[0.065,0.065],[0.275,0.25],[0.05,0.06]);



ax=ax1;

linewd=2;

fontsz=18;

%%
set(fig,'CurrentAxes',ax(1));

for jj = 1 : 6
    if(jj==1)
        plot(time,-nee(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        if(jj==3 || jj==2)
           % nee_plic=nee(:,3);
           % id=find(nee_plic<300);
           % plot(time(id),-nee(id,jj),clr{7-jj},'LineWidth',linewd);
        else
            plot(time,-nee(:,jj),clr{7-jj},'LineWidth',linewd);
        end
    end
end
ylim([-300,100]);
xlim([1850,2000]);
ylabel('Cumulative NEE (g C m^-^2)','FontSize',fontsz);
xlabel('Year','FontSize',fontsz);
%%
set(fig,'CurrentAxes',ax(2));
hdl=zeros(4,1);
kk=0;
for jj = 1 : 6
    if(jj==1)
        kk=kk+1;
        hdl(4-kk+1)=plot(lat,gpp(:,jj),'color',purple,'LineWidth',linewd);hold on;
    else
        if(jj~=3 && jj~=2)
            kk=kk+1;
            hdl(4-kk+1)=plot(lat,gpp(:,jj),clr{7-jj},'LineWidth',linewd);
        end
    end
end
ylabel('GPP (gC m^-^2 yr^-1)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);
h_lgd=legend(hdl,'MNL','NUL','PNL','Default');
set(h_lgd,'FontSize',24);

fprintf('%10s %10s %10s %10s %10s %10s\n','MNL','NUL','PNL','PNLIC','PNLO','Default');
fprintf('%10.3f %10.3f %10.3f %10.3f %10.3f %10.3f\n',nee(end,6:-1:1));
%%
set(fig,'CurrentAxes',ax(3));
for jj = 1 : 6
    if(jj==1)
        plot(lat,npp(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        if(jj~=3  && jj~=2)
            plot(lat,npp(:,jj),clr{7-jj},'LineWidth',linewd);
        end
    end
end
ylabel('NPP (gC m^-^2 yr^-1)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(4));
for jj = 1 : 6
    if(jj==1)
        plot(lat,lai(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        if(jj~=3  && jj~=2)
            plot(lat,lai(:,jj),clr{7-jj},'LineWidth',linewd);
        end
    end
end
ylabel('July leaf area index (None)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(5));
for jj = 1 : 6
    if(jj==1)
        plot(lat,lh(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        if(jj~=3  && jj~=2)
            plot(lat,lh(:,jj),clr{7-jj},'LineWidth',linewd);
        end
    end
end
ylabel('July latent heat flux (W m^-^2)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(6));
for jj = 1 : 6
    if(jj==1)
        plot(lat,somc(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        if(jj~=3  && jj~=2)
            plot(lat,somc(:,jj),clr{7-jj},'LineWidth',linewd);
        end
    end
end
ylabel('Total SOMC to 1 m (Pg C)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(7));
for jj = 1 : 6
    if(jj==1)
        plot(lat,somn(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        if(jj~=3)
            plot(lat,somn(:,jj),clr{7-jj},'LineWidth',linewd);
        end
    end
end
ylabel('Total SOMN to 1 m (Pg N)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(8));
for jj = 1 : 6
    if(jj==1)
        plot(lat,vegc(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        if(jj~=3  && jj~=2)
            plot(lat,vegc(:,jj),clr{7-jj},'LineWidth',linewd);
        end
    end
end
ylabel('Total Veg C (Pg C)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(9));
for jj = 1 : 6
    if(jj==1)
        plot(lat,vegn(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        if(jj~=3  && jj~=2)
            plot(lat,vegn(:,jj),clr{7-jj},'LineWidth',linewd);
        end
    end
end
ylabel('Total Veg N (Pg N)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);


set(ax,'FontSize',fontsz);
set(fig,'color','w');


tags={'a','b','c','d','e','f','g','h','i'};


for jj = 1 : 9
   put_tag(fig,ax(jj),[0.05,.1],tags{jj},fontsz); 
end
export_fig('poster_fig2.pdf','-pdf');
