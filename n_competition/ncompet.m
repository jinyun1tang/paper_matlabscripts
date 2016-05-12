close all;
clear all;
clc;

%the following compares three different strategies in doing nutrient
%competition during om decomposition

%three state varabiles, om1, om2 and minn

x=[1,0,1d-2]; %initial of the state variables

Extra.vid.c1=1;
Extra.vid.c2=2;
Extra.vid.n=3;

Extra.par.rcn1=20;
Extra.par.rcn2=10; %cn ratio of the two om pools
Extra.par.f = 0.3;
Extra.par.k1=1d-3;
Extra.par.k2=1d-4;
t=0;

dxdt1=feval(@ncompet_fullscal,t,x,Extra);

dxdt2=feval(@ncompet_fullscal,t,x,Extra);
tend=8000;
Extra.dt=1;
[tout1,yout1]=ode_adpt_mbbks1(@ncompet_fullscal,x,Extra.dt,[0,tend],Extra);

[tout2,yout2]=ode_adpt_mbbks1(@ncompet_pscal,x,Extra.dt,[0,tend],Extra);

[tout3,yout3]=ode_adpt_mbbks1(@ncompet_clmscal,x,Extra.dt,[0,tend],Extra);

x=[1,0,1d-4];

[tout4,yout4]=ode_adpt_mbbks1(@ncompet_pscal,x,Extra.dt,[0,tend],Extra);

x=[1,0,1d-4];

[tout5,yout5]=ode_adpt_mbbks1(@ncompet_pscal1,x,Extra.dt,[0,tend],Extra);

%do second approach


vid = Extra.vid;


subplot(3,1,1);plot(tout1,yout1(:,vid.c1));hold on;
plot(tout2,yout2(:,vid.c1),'r');
plot(tout3,yout3(:,vid.c1),'k');
plot(tout4,yout4(:,vid.c1),'g');
plot(tout5,yout5(:,vid.c1),'c');
legend('full scale','partial scale N0.01','clm scale','partial scale N0.001','partial scale N0.0001');
%title(['N_0=',num2str(x(vid.n))]);

subplot(3,1,2);plot(tout1,yout1(:,vid.c2));hold on;
plot(tout2,yout2(:,vid.c2),'r');
plot(tout2,yout3(:,vid.c2),'k');
plot(tout4,yout4(:,vid.c2),'g');
plot(tout5,yout5(:,vid.c2),'c');

subplot(3,1,3);plot(tout1,yout1(:,vid.n));hold on;
plot(tout2,yout2(:,vid.n),'r');
plot(tout3,yout3(:,vid.n),'k');
plot(tout4,yout4(:,vid.n),'g');
plot(tout5,yout5(:,vid.n),'c');
