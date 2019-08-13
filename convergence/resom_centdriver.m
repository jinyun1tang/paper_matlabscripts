close all;

addpath(pwd);


par=resoms_pars('cent');

x=[1,1,1,1];
t=0.0;
dxdt=resom_centm(t,x,par);
