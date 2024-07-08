close all;
clear all;
clc;

sA=(0:0.1:10);
K0=1;
jA=10.*sA./(K0+sA);
Yv=0.6;

v0=10;
mu11=mDEB_grogK(jA,Yv,v0);
mu21=sDEB_gro(jA,Yv,v0);

v0=100;
mu12=mDEB_grogK(jA,Yv,v0);
mu22=sDEB_gro(jA,Yv,v0);

fig1=1;
ax1=multipanel(fig1,1,2,[.1,.1],[.4,.85],[.06,0.1]);
set_curAX(fig1,ax1(1));
h(1)=plot(sA,mu11,'--','LineWidth',2);
hold on;
h(2)=plot(sA,mu21,'LineWidth',2);
legend(h,'mDEB model','sDEB model','location','Southeast');
xlabel('Normalized substate availability (S/K_S)','FontSize',16);
ylabel('Normalized specific structural biomass growth rate (\mu/m_V)','FontSize',16);
ylim([-2,5]);
set_curAX(fig1,ax1(2));
h(1)=plot(sA,mu12,'--','LineWidth',2);
hold on;
h(2)=plot(sA,mu22,'LineWidth',2);
xlabel('Normalized substate availability (S/K_S)','FontSize',16);
ylabel('Normalized specific structural biomass growth rate (\mu/m_V)','FontSize',16);

set(fig1,'color','w');
set(ax1,'FontSize',16);
put_tag(fig1,ax1(1),[0.03,0.95],'(a) v_E=10m_V',18);
put_tag(fig1,ax1(2),[0.03,0.95],'(b) v_E=100m_V',18);

%%%
fig2=2;
ax=multipanel(fig2,2,2,[.1,.1],[.4,.4],[.06,0.06]);
v0=15;
[cue1,mu1]=cueYv_mDEBgK(v0);
[cue2,mu2]=cueYv_sDEB(v0);
set_curAX(fig2,ax(1));
h(1)=plot(mu1,cue1,'LineWidth',2);
hold on;
h(2)=plot(mu2,cue2,'LineWidth',2);
legend(h,'mDEB model','sDEB model','location','Northeast');
xlabel('Normalized specific growth rate (\mu/m_V)','FontSize',18);
ylabel('Normalized structural biomass yield (Y_\mu/Y_X)','FontSize',18);
ylim([0,1]);
[cue3,mu3]=cueYB_mDEBgK(Yv,v0);
[cue4,mu4]=cueYB_sDEB(Yv,v0);
set_curAX(fig2,ax(2));
plot(mu3,cue3,'LineWidth',2);
hold on;
plot(mu4,cue4,'LineWidth',2);
xlabel('Normalized specific growth rate (\mu/m_V)','FontSize',18);
ylabel('Normalized total biomass yield (Y_B/Y_X)','FontSize',18);
%%
v0=100;
[cue1,mu1]=cueYv_mDEBgK(v0);
[cue2,mu2]=cueYv_sDEB(v0);
set_curAX(fig2,ax(3));
h(1)=plot(mu1,cue1,'LineWidth',2);
hold on;
h(2)=plot(mu2,cue2,'LineWidth',2);
%legend(h,'mDEB model','sDEB model','location','Northeast');
xlabel('Normalized specific growth rate (\mu/m_V)','FontSize',18);
ylabel('Normalized structural biomass yield (Y_\mu/Y_X)','FontSize',18);
ylim([0,1]);
[cue3,mu3]=cueYB_mDEBgK(Yv,v0);
[cue4,mu4]=cueYB_sDEB(Yv,v0);
set_curAX(fig2,ax(4));
plot(mu3,cue3,'LineWidth',2);
hold on;
plot(mu4,cue4,'LineWidth',2);
xlabel('Normalized specific growth rate (\mu/m_V)','FontSize',18);
ylabel('Normalized total biomass yield (Y_B/Y_X)','FontSize',18);
%%

set(ax,'FontSize',16);
put_tag(fig2,ax(1),[0.03,0.9],'(a) v_E=15m_V',18);
put_tag(fig2,ax(2),[0.03,0.9],'(b) v_E=15m_V',18);
put_tag(fig2,ax(3),[0.03,0.9],'(c) v_E=100m_V',18);
put_tag(fig2,ax(4),[0.03,0.9],'(d) v_E=100m_V',18);




function mu=mDEB_grogK(jA,Yv,v0)
%eq. (21) 
%growth rate vs substrate
m=1;
v=v0*m;

mu=(m+v)./2.*(-1+sqrt(1+4.*v.*(jA.*Yv-m)./(m+v).^2));

end

function mu=sDEB_gro(jA,Yv,v0)
%growth rate vs reserve assimilate
%
m=1;
v=v0*m;

mu=(Yv.*jA-m)./(1+Yv.*jA./v);
end

function [cue,mu]=cueYv_mDEBgK(v0)
%mDEB model with K>>x
%structural biomass yield
%Eq. (19) in the paper
v=v0;
mu=(0:0.1:v-1);
m=1;
cue=mu./(mu+m).*(v./(v+mu));
end

function [cue,mu]=cueYB_mDEBgK(Yv,v0)
%mDEB total biomass CUE, with kappa=1
%cue/Yx
%Eq. (20)
v=v0;
m=1;
mu=(0:0.1:v-1);

cue=mu./(mu+m).*(Yv.*v+mu+m)./(v+mu);
end


function [cue,mu]=cueYv_sDEB(v0)
%sDEB model
%structural biomass yield
%Table 1
v=v0;
mu=(0:0.1:v-1);
m=1;
cue=mu./(mu+m).*((v-mu)./v);
end

function [cue,mu]=cueYB_sDEB(Yv,v0)
%sDEB model
%Total biomass yield
%Table 1
v=v0;
mu=(0:0.1:v-1);
m=1;
cue=mu./(mu+m).*((Yv*v+m+(1-Yv).*mu)./v);
end
