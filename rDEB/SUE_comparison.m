close all;
clear all;
par.umax=1.e-6;
par.mq=1.e-8;
par.KS=1.e-5;
par.YG=0.6;
S=(3.e-8:1.e-8:4.e-3);

[u,q]=mic_growth_composite(S,par);
subplot(3,1,1);plot(u,u./q,'-','LineWidth',2);

pardeb.kap0=5.e-6;
pardeb.KS=1.e-5;
pardeb.amax=1.e-5;
pardeb.YRV=0.6;
pardeb.YSR=0.8;
pardeb.mV=1.e-8;
[u,q,YG2]=mic_growth_sdeb(S,pardeb);
subplot(3,2,3);plot(u,u./q,'-','LineWidth',2);
subplot(3,2,4);plot(u,YG2,'LineWidth',2);


pardeb.YRV=0.6;
pardeb.YRN=0.6;
pardeb.YSR=0.8;
pardeb.fN=0.2;
pardeb.tauN=1800;
pardeb.alpha=0.12;
pardeb.KS=1.e-6;
pardeb.amax=1.e-5;
pardeb.mV=1.e-9;
pardeb.KR=1.e-5;
pardeb.kapmax=5.e-6;
[u,q,YG1]=mic_growth_rdeb(S,pardeb);
subplot(3,2,5);plot(u,u./(q+eps),'-','LineWidth',2);
subplot(3,2,6);plot(u,YG1,'-','LineWidth',2);



