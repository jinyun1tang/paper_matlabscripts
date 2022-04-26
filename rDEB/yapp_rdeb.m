function [u,umax,yapp]=yapp_rdeb(par)
c1=1./par.YRV+par.KR/(par.kapmax*par.tauN*par.YRN*par.fN-1);
c3=(1+par.alpha*par.YRN/(par.kapmax*par.tauN*par.YRN*par.fN-1))...
    *par.fN*par.tauN/(1-par.fN);
umax=1./c3;
mq=par.mV/(par.YRV*c1);
fprintf('umax=%f,mq=%f\n',umax,mq);
u=(0:10).*mq;
yapp=u./(u+mq).*(1-c3.*u)*(1-par.fN)/(1-par.YRN*par.fN)*par.YSR/c1;

end