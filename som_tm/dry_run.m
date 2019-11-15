close all;
clear all;

%load default parameters
par0=resom_par();

pct_sand=20;
pct_clay=20;
fom=0.0;   %fraction of organic matter
zsoi=0.1;

envobj=EnvClass(pct_sand,pct_clay,fom,zsoi,par0);

soim=0.6; %normalized soil moisture
tsoi=283;
par=resom_envset(par0,tsoi,soim,zsoi,envobj);
par.debug=1;
vid=par.vid;
x=zeros(vid.vsz,1);
x(vid.o2)=8.3;
x(vid.micBX)=0.1;
x(vid.micBV)=0.1;
t=0;
[dxdt,errC]=massbal_run(t,x,par);