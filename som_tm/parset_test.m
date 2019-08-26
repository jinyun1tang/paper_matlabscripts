close all;
clear all;

par0=resom_par();
zsoi=0.1;
envobj=EnvClass(20,20,0.0,zsoi,par0);

tsoi=289;
ko2w=zeros(100,1);
ko2w0=zeros(100,1);
ko2g=zeros(100,1);
kep=zeros(100,1);
soims=zeros(100,1);
x_o2g=zeros(100,1);
for j = 1 : 100
    soim=0.01*j;
    soims(j)=soim;
    par=resom_envset(par0,tsoi,soim,zsoi,envobj);
    ko2w(j)=par.K_O2w;
    ko2g(j)=par.K_O2g;
    kep(j)=par.K0_EP;
    x_o2g(j)=par.x_o2g;
end

fact_mic=zeros(100,1);
fact_exoenz=zeros(100,1);
tsoi=zeros(100,1);
k9o2w=zeros(100,1);
k9o2w0=zeros(100,1);
k9o2g=zeros(100,1);
k5o2w=zeros(100,1);
k5o2w0=zeros(100,1);
k5o2g=zeros(100,1);
k5pE=zeros(100,1);
k9pE=zeros(100,1);
kpE0=zeros(100,1);
K5D=zeros(100,1);
K9D=zeros(100,1);
VEP=zeros(100,1);
VDB=zeros(100,1);
for j = 1 : 100

    tsoi(j)=-10+j*0.5+273.15;
    soim=0.9;
    par=resom_envset(par0,tsoi(j),soim,zsoi,envobj);
    k9o2w(j)=par.K_O2w;
    k9o2w0(j)=par.K0_O2w;
    k9o2g(j)=par.K_O2g;
    fact_mic(j)=par.fact_mic;
    fact_exoenz(j)=par.fact_exoenz;
    k9pE(j)=par.K_EP;
    K9D(j)=par.K_DB;
    kpE0(j)=par.K0_EP;
    soim=0.5;
    par=resom_envset(par0,tsoi(j),soim,zsoi,envobj);
    k5o2w(j)=par.K_O2w;
    k5o2w0(j)=par.K0_O2w;
    k5o2g(j)=par.K_O2g;
    k5pE(j)=par.K_EP;
    K5D(j)=par.K_DB;
    VEP(j)=par.V_EP;
    VDB(j)=par.V_DB;
end

fig=1;
ax=multipanel(fig,2,2,[0.1,.1],[0.4,0.4],[0.05,0.05]);

set(fig,'CurrentAxes',ax(1));
plot(tsoi,k9o2w,'r.');
hold on;
plot(tsoi,k5o2w,'r.-');
plot(tsoi,k9o2w0,'b.');
plot(tsoi,k5o2w0,'b.-');

legend({'s9 effective KO2w','s5 effective KO2w',...
    's9 reference KO2w','s5 reference KO2w'},'FontSize',14,...
    'location','best');
ylabel('mol O_2 m^-^3','FontSize',14);
set(fig,'CurrentAxes',ax(2));
plot(tsoi,k9pE,'r.');
hold on;
plot(tsoi,k5pE,'b.');
legend({'s9 effective KPE','s5 effecitve KPE'},'FontSize',14,...
    'location','best');
set(fig,'CurrentAxes',ax(3));
plot(tsoi,fact_mic,'r');
hold on;
plot(tsoi,fact_exoenz,'b');
legend({'Microbes','Enzymes'},'FontSize',14);
set(ax,'FontSize',14);
xlabel('Temperature (K)','FontSize',14);

set(fig,'CurrentAxes',ax(4));
plot(tsoi,K5D,'r');
hold on;
plot(tsoi,K9D,'b');
legend({'s5 effective KD','s9 effective KD'},'FontSize',14);
set(ax,'FontSize',14);
xlabel('Temperature (K)','FontSize',14);


fig=2;
ax=multipanel(fig,1,2,[0.061,.1],[0.4,0.8],[0.085,0.05]);
set_curAX(fig,ax(1));
plot(tsoi,k9pE,'r','LineWidth',2);hold on;
plot(tsoi,k5pE,'b','LineWidth',2);
set(gcf,'color','w');set(gca,'FontSize',18);
xlabel('Temperature (K)','FontSize',18);
ylabel('Hydrolysis affinity parameter (mol m^-^3)','FontSize',18);
legend('90% saturation','50% saturation','FontSize',18);

set_curAX(fig,ax(2));
plot(tsoi,K5D,'r','LineWidth',2);hold on;
plot(tsoi,K9D,'b','LineWidth',2);
set(gcf,'color','w');set(gca,'FontSize',18);
xlabel('Temperature (K)','FontSize',18);
ylabel('Microbial DOC affinity parameter (mol m^-^3)','FontSize',18);
legend('90% saturation','50% saturation','FontSize',18);


fig=3;
ax=multipanel(fig);
plot(tsoi,VEP,'b','LineWidth',2);
hold on;
plot(tsoi,VDB,'r','LineWidth',2);
set(ax,'FontSize',18);
ylabel('Maximum substrate processing rate (1/s)','FontSize',18);
xlabel('Temperature (K)','FontSize',18);
legend('Exoenzyme','Microbes','FontSize',18);

fig=4;
ax=multipanel(fig);
plot(soims,1./x_o2g);