close all;
addpath(pwd);

par=resoms_pars('simple');

y0=[1,1,1,1,100];

tf=1800.*48.*365.*20;
tspan=[0,tf];
odefun=@(t,y)resom_simple(t,y,par);

[t,y]=ode45(odefun,tspan,y0);



subplot(2,1,1);plot(t./86400,y(:,1),'LineWidth',2);
subplot(2,1,2);plot(t./86400,y(:,2:4),'LineWidth',2);
legend(par.vid.varnames{2:4});