close all;
clear all;
clc;

area_grd=load('area.txt');%km^2

area_lat=zeros(96,1);

for j = 1 : 96
    for k = 1 : 144
        if(abs(area_grd(k,j))<1d10)
            area_lat(j)=area_grd(k,j);
        end
    end
end

lat=load('figure2_txt/latitude_1991-2000.txt');
time=load('figure2_txt/time_ts.txt');
dat=load('figure2_txt/gpp_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;gpp=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/npp_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;npp=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/lh_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;lh=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/somc_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;somc=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/somn_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;somn=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/litc_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;somc=somc+reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/litn_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;somn=somn+reshape(dat,[numel(dat)/6,6]);

dat=load('figure2_txt/vegc_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;vegc=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/vegn_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;vegn=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/tlai_lat_1991-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;lai=reshape(dat,[numel(dat)/6,6]);
dat=load('figure2_txt/nee_ts_1850-2000.txt');id=(abs(dat)>1d10);dat(id)=0./0.;nee=reshape(dat,[numel(dat)/6,6]);

clr={'b','k','r','c','g'};

purple= [0.5 0 0.5];

%in reverse order, sims={'MNL','NUL','PNL','PNLIC','PNLO','Default'};
%
sims_switch=[true,false,false,false,false,true];

fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,.7,.9]);
ax=multipanel(fig,3,3,[0.065,0.065],[0.25,0.25],[0.075,0.06]);



fontsz=24;
linewd=2;

nact_sim=sum(sims_switch);

%%
set(fig,'CurrentAxes',ax(1));

for jj = 1 : 6
    if(~sims_switch(jj))
        continue
    end
    if(jj==1)
        plot(time,-nee(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(time,-nee(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylim([-300,100]);
xlim([1850,2000]);
ylabel('Cumulative NEE (Pg C)','FontSize',fontsz);
set(fig,'CurrentAxes',ax(1));

xlabel('Year','FontSize',fontsz);


%%
set(fig,'CurrentAxes',ax(2));
hdl=zeros(nact_sim,1);
kk=0;
for jj = 1 : 6
    if(~sims_switch(jj))
        continue
    else
        kk=kk+1;
    end    
    if(jj==1)
        hdl(nact_sim-kk+1)=plot(lat,gpp(:,jj),'color',purple,'LineWidth',linewd);hold on;
    else
        hdl(nact_sim-kk+1)=plot(lat,gpp(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('GPP (gC m^-^2 yr^-1)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);
legend(hdl,'MNL','Default');
%[legh,objh,outh,outm]=legend(hdl,'MNL','NUL','PNL','Default');
%set(objh,'linewidth',4);
%set(legh,'FontSize',fontsz);
fprintf('%10s %10s %10s %10s %10s %10s\n','MNL','NUL','PNL','PNLIC','PNLO','Default');
fprintf('%10.3f %10.3f %10.3f %10.3f %10.3f %10.3f\n',nee(end,6:-1:1));
%%
set(fig,'CurrentAxes',ax(3));
for jj = 1 : 6
    if(~sims_switch(jj))
        continue
    end    
    if(jj==1)
        plot(lat,npp(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,npp(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('NPP (gC m^-^2 yr^-1)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(4));
for jj = 1 : 6
    if(~sims_switch(jj))
        continue
    end    
    if(jj==1)
        plot(lat,lai(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,lai(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('July leaf area index (None)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(5));
for jj = 1 : 6
    if(~sims_switch(jj))
        continue
    end    
    if(jj==1)
        plot(lat,lh(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,lh(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('July latent heat flux (W m^-^2)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(6));
for jj = 1 : 6
    if(~sims_switch(jj))
        continue
    end    
    if(jj==1)
        plot(lat,somc(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,somc(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('Total SOMC to 1 m (Pg C)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(7));
for jj = 1 : 6
    if(~sims_switch(jj))
        continue
    end    
    if(jj==1)
        plot(lat,somn(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,somn(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('Total SOMN to 1 m (Pg N)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(8));
for jj = 1 : 6
    if(~sims_switch(jj))
        continue
    end    
    if(jj==1)
        plot(lat,vegc(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,vegc(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('Total Veg C (Pg C)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);

%%
set(fig,'CurrentAxes',ax(9));
for jj = 1 : 6
    if(~sims_switch(jj))
        continue
    end    
    if(jj==1)
        plot(lat,vegn(:,jj),'color',purple,'LineWidth',linewd);hold on;

    else
        plot(lat,vegn(:,jj),clr{7-jj},'LineWidth',linewd);
    end
end
ylabel('Total Veg N (Pg N)','FontSize',fontsz);
xlabel('Latitude','FontSize',fontsz);


set(ax,'FontSize',fontsz);
set(fig,'color','w');


tags={'a','b','c','d','e','f','g','h','i'};

for jj = 1 : 9
   put_tag(fig,ax(jj),[0.05,.95],tags{jj},fontsz); 
end

tsomc=zeros(6,1);
tvegc=zeros(6,1);
for j = 1 : 96
    if(~isnan(vegc(j,1)))
        tvegc=tvegc+vegc(j,:)';
    end
    if(~isnan(somc(j,1)))
        tsomc=tsomc+somc(j,:)';
    end
end

fprintf('%10s %10s %10s %10s %10s %10s\n','MNL','NUL','PNL','PNLIC','PNLO','Default');
fprintf('SOMC\n');
fprintf('%10.3f %10.3f %10.3f %10.3f %10.3f %10.3f\n',tsomc(6:-1:1));
fprintf('VEGC\n');
fprintf('%10.3f %10.3f %10.3f %10.3f %10.3f %10.3f\n',tvegc(6:-1:1));

