close all;
clear all;
clc;



%calculate the 

pct_sand=30;
pct_clay=40;
[sat,chb]=clapp_hornberg_par(pct_sand,pct_clay);


epsi=(100:-.1:1)./100-eps;
theta=sat.*(1-epsi);
epsi=sat-theta;
[taug,tauw]=moldrup_tau(sat,epsi,theta,chb);

alpha_o2=0.032;%solubility at 298.15 K

D_w=2.6d-9;
D_g=2.11d-5;

Dbw=theta.*D_w.*tauw+epsi./alpha_o2.*D_g.*taug;


Dsw0=1d-9;
Dsw=Dsw0.*theta;

subplot(3,1,1);
plotyy(theta,Dbw,theta,Dsw);


legend('O_2','DOC');


Eb=0.05;
Ks_o2=3.1d-5;
Ks_dom=8.1d-5;
Ks_o2m=(Ks_o2.*0+1.5d-5.*D_w./Dbw).*1d3;

Ks_docm=(Ks_dom.*0+4d-5.*Dsw0./Dsw).*1d0;

subplot(3,1,2);
plotyy(theta,Ks_o2m, theta,Ks_docm);
%now affinity of doc

s1=8*alpha_o2*1d-2;
s2=1d-1;
m=0;

    
par.k2=4.8d-6;

par.Kbs1=Ks_o2m;

par.Kbs2=Ks_docm;

par.Kms1=1d0;

par.kbs1=par.k2./par.Kbs1;

par.kbs2=par.k2./par.Kbs2;

    
cplx_ec=supeca_model1(par,[s1,s2,Eb,m]);
subplot(3,1,3);
plot(theta./sat,cplx_ec.*par.k2.*theta);

m=1000;
cplx_ec=supeca_model1(par,[s1,s2,Eb,m]);
hold on;
plot(theta./sat,cplx_ec.*par.k2.*theta,'r');
xlabel('\theta/\theta_s_a_t');