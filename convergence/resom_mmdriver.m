close all;
addpath(pwd);

par=resoms_pars('mm');

x=[1,1,1,1,1];
t=0.0;
dxdt=resom_mm(x,t,par);
