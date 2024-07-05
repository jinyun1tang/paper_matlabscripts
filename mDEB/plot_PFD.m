%replot Figure 8 from Wu and Merchuk, 2001
close all;
clear all;
global par;
par=setpar();


I=(0:10:1000);
Me=0.05908*1;  %1/h


t=(0:0.1:30);



j_ph=par.rho_PSU.*I./(1./par.alpha+1./par.gamma.*(1+par.beta/par.alpha).*I+...
    (par.beta/(par.gamma*par.delta).*I.*I)).*3600-Me;



I=(t<=4).*250+(t>4 & t<=24).*180.*exp(3.*(cos(2.0.*pi.*(t+0.4))-1))...
    +(t>24).*100;

C_conc=990;  %uM
j_C=par.jm_AC.*C_conc./par.KC;  %1/d
j_ph=par.rho_PSU.*I./(1./par.alpha+1./par.gamma.*(1+par.beta/par.alpha).*I+...
    (par.beta/(par.gamma*par.delta).*I.*I)).*par.secs1day;  %1/d

jA_C=1./(0/par.jm_AC+1./j_C+1./j_ph-1./(j_ph+j_C));
figure;
subplot(2,1,1);
plot(t,jA_C);
N_conc=70;
jA_N=par.jm_AN*N_conc/(N_conc+par.KN).*ones(size(t));

subplot(2,1,2);
plot(t,jA_N);


