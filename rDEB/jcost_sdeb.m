function jcost=jcost_sdeb(x)
%compute the cost function for the sdeb model
global obs;
global par;
tend=500;
parsdeb.kap0=x(1);
parsdeb.KS=x(2);
parsdeb.amax=x(3);
parsdeb.YRV=x(4);
parsdeb.YSR=x(5);
parsdeb.mV=x(6);%1.e-5;
parsdeb.gmm=x(7);
parsdeb.vid.S=1;
parsdeb.vid.BV=2;
parsdeb.vid.BR=3;
parsdeb.vid.CO2=4;
parsdeb.vid.BD=5;
par=parsdeb;

y0=[obs.S0, obs.B0*x(8), 0.1766*(1-x(8)), 0,0];
%[t2,y2]=ode23s(@mic_dyngrowth_sdeb,[0,tend],y0);
ns=1000;
[t2,y2]=euler_driver_sdeb(y0,[0,tend],ns);

yq = interp1(t2,y2(:,par.vid.CO2),obs.t1);
yb = interp1(t2,y2(:,par.vid.BD),obs.t2);
%jcost=sum(abs(((yq)-(obs.yco2))./(0.025*(obs.yco2))).^2)...
%    +sum(abs(((yb)-(obs.yB))./(0.025*(obs.yB))).^2);%+exp(8.*(x(3)-0.9))+exp(8*(x(4)-0.9));
%jcost=sum(abs(((yq)-(obs.yco2))./1).^2)+...
%    +sum(abs(((yb)-(obs.yB))./1).^2);%+exp(8.*(x(3)-0.9))+exp(8*(x(4)-0.9));
jcost=sum((abs(yq-obs.yco2)./obs.std).^2)+...
    +sum(abs(((yb)-(obs.yB))./1).^2);%+exp(8.*(x(3)-0.9))+exp(8*(x(4)-0.9));

%jcost=sum(abs(yq-obs.yco2)
%disp((exp(8.*(x(3)-1))+exp(8*(x(4)-1)))./jcost);
end