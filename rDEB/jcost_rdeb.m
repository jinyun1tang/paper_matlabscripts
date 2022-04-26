function jcost=jcost_rdeb(x)
%compute the cost function for the sdeb model
global obs;
global par;
tend=500;
parrdeb.YRV=x(1);
parrdeb.YRN=x(2);
parrdeb.YSR=x(3);
parrdeb.fN=x(4);
parrdeb.KS=x(5);
parrdeb.amax=x(6);
parrdeb.mV=x(7);
parrdeb.kapmax=x(8);
parrdeb.gmm=x(9);
parrdeb.tauN=x(12);
parrdeb.alpha=0.003;
parrdeb.KR=1.;
parrdeb.phiV=0.1;
parrdeb.KR0=4.7e-13*12/3600*(1-parrdeb.phiV)/parrdeb.phiV*x(8);
parrdeb.dN=1.15;
parrdeb.dR=0.8;
parrdeb.vid.S=1;
parrdeb.vid.BV=2;
parrdeb.vid.BR=3;
parrdeb.vid.BN=4;
parrdeb.vid.CO2=5;
parrdeb.vid.BD=6;
par=parrdeb;

y0=[43.43, 0.1766*x(10), 0.1766*(1-x(10))*x(11), 0.1766*(1.-x(10))*(1.-x(11)),0,0];
ns=1000;
[t2,y2]=euler_driver_rdeb(y0,[0,tend],ns);

yq = interp1(t2,y2(:,par.vid.CO2),obs.t2);
yb = interp1(t2,y2(:,par.vid.BD),obs.t2);
jcost=sum((abs(yq-obs.yco2)./1).^2)+...
    +sum(abs(((yb)-(obs.yB))./1).^2);%+exp(8.*(x(3)-0.9))+exp(8*(x(4)-0.9));

%disp((exp(8.*(x(3)-1))+exp(8*(x(4)-1)))./jcost);
end