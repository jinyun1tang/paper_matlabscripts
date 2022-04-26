close all;
clear all;

YRN=0.6;
YRV=0.6;
kmax=0.4/3600;
amax=0.6/3600;
mV=amax./10;
tauN=40.*3600;
fN=(0.0:0.05:1);
alpha=0.003;
c1=1./YRV;

c2=(1./YRN+alpha./(alpha.*kmax.*tauN.*YRN.*fN-1))...
    .*tauN.*YRN.*fN./(1-YRN.*fN);
A=(1-fN)./(1-YRN.*fN);

umax=A./(c1+c2.*amax).*(1-mV./(A.*YRV.*amax));
plot(fN,umax,'LineWidth',2);
set(gca,'FontSize',20);
ylabel('\mu_m_a_x_,_r/a_m_a_x_,_r','FontSize',24);
xlabel('f_N_,_r','FontSize',24);
ylim([0,0.6]);
