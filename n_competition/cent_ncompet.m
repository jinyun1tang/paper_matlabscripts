close all;
clear all;
clc;

icase=1;

Extra=cent_par();

vid=Extra.vid;

x=zeros(vid.nvars,1);
x(vid.lit1)=10;
x(vid.lit2)=10;
x(vid.lit3)=10;
x(vid.cwd )=10;
x(vid.som1)=10;
x(vid.som2)=0;
x(vid.som3)=0;
switch icase
    case 1
x(vid.minn)=10d0;
x(vid.minp)=10d0;
    case 2
x(vid.minn)=1d-1;
x(vid.minp)=10d0;
    case 3

x(vid.minn)=10d0;
x(vid.minp)=1d-2;
    case 4
x(vid.minn)=1d-4;
x(vid.minp)=1d-4;
end

Extra.dt=1;
t=0;
dxdt1=sombgc_cent(t,x,Extra);


dxdt2=sombgc_centclm(t,x,Extra);


dxdt3=sombgc_centode(t,x,Extra);

Extra.method='';
tend=86400*365*0.25;

options1 = odeset('RelTol',1e-4,'NonNegative',(1:9));
options = odeset('RelTol',1e-4);

Extra.dt=300;
[tout11,yout11]=ode_adpt_mbbks1(@sombgc_cent,x,Extra.dt,[0,tend],Extra);
tout11=tout11./86400/365;


Extra.dt=1800;
[tout21,yout21]=ode_adpt_mbbks1(@sombgc_centclm,x,Extra.dt,[0,tend],Extra);
tout21=tout21./86400/365;

Extra.method='screen';
[tout31,yout31]=ode_adpt_mbbks1(@sombgc_centode,x,Extra.dt,[0,tend],Extra);
tout31=tout31./86400/365;

Extra.method='';
Extra.dt=2*1800;
[tout12,yout12]=ode_adpt_mbbks1(@sombgc_cent,x,Extra.dt,[0,tend],Extra);
tout12=tout12./86400/365;

[tout22,yout22]=ode_adpt_mbbks1(@sombgc_centclm,x,Extra.dt,[0,tend],Extra);
tout22=tout22./86400/365;

Extra.method='screen';
[tout32,yout32]=ode_adpt_mbbks1(@sombgc_centode,x,Extra.dt,[0,tend],Extra);
tout32=tout32./86400/365;

subplot(4,1,1);
plot(tout11,yout11(:,vid.minn),'LineWidth',2);
hold on;
plot(tout12,yout12(:,vid.minn),'--','LineWidth',2);

plot(tout21,yout21(:,vid.minn),'r','LineWidth',2);
plot(tout22,yout22(:,vid.minn),'r--','LineWidth',2);

plot(tout31,yout31(:,vid.minn),'g','LineWidth',2);
plot(tout32,yout32(:,vid.minn),'g--','LineWidth',2);title('minn');


subplot(4,1,2);
plot(tout11,yout11(:,vid.minp),'LineWidth',2);
hold on;
plot(tout12,yout12(:,vid.minp),'--','LineWidth',2);

plot(tout21,yout21(:,vid.minp),'r','LineWidth',2);
plot(tout22,yout22(:,vid.minp),'r--','LineWidth',2);

plot(tout31,yout31(:,vid.minp),'g','LineWidth',2);
plot(tout32,yout32(:,vid.minp),'g--','LineWidth',2);title('minp');


subplot(4,1,3);
plot(tout11,sum(yout11(:,vid.lits),2),'LineWidth',2);
hold on;
plot(tout12,sum(yout12(:,vid.lits),2),'--','LineWidth',2);

plot(tout21,sum(yout21(:,vid.lits),2),'r','LineWidth',2);
plot(tout22,sum(yout22(:,vid.lits),2),'r--','LineWidth',2);

plot(tout31,sum(yout31(:,vid.lits),2),'g','LineWidth',2);
plot(tout32,sum(yout32(:,vid.lits),2),'g--','LineWidth',2);title('lit');

subplot(4,1,4);
plot(tout11,sum(yout11(:,vid.soms),2),'LineWidth',2);
hold on;
plot(tout12,sum(yout12(:,vid.soms),2),'--','LineWidth',2);

plot(tout21,sum(yout21(:,vid.soms),2),'r','LineWidth',2);
plot(tout22,sum(yout22(:,vid.soms),2),'r--','LineWidth',2);
plot(tout31,sum(yout31(:,vid.soms),2),'g','LineWidth',2);
plot(tout32,sum(yout32(:,vid.soms),2),'g--','LineWidth',2);title('som');


