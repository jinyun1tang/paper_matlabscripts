close all;



%set up the simulation
nt=1;       %model clock
NSTOP=10;   %number of steps
dtime=3600; %numerical time step, seconds

%load default parameters
par0=resom_par();

pct_sand=20;
pct_clay=20;
fom=0.0;   %fraction of organic matter
zsoi=0.1;
envobj=EnvClass(pct_sand,pct_clay,fom,zsoi,par0);


while(nt<NSTOP)
% setup environmental variable
%
    dxdt=resom_tm(t,x,extra);
%get n    
end