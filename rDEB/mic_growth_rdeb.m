function [umax,mq,u,q,YG1]=mic_growth_rdeb(S,par)
%revised deb model for microbial growth
%author: Jinyun Tang (jinyuntang@gmail.com)
%S: substrate concentration vector
%par: parameter structure
scalar=par.tauN*par.YRN*par.fN;
a=1./par.YRV+par.KR./(par.kapmax*scalar-1.);
b=(1./par.YRN+par.alpha/(par.kapmax*scalar-1))*(scalar*par.amax)...
    /(1-par.YRN*par.fN);
rapb=1./(a+b);
mq=par.mV/(par.YRV*a);
um1=(1-par.fN)/(1-par.YRN*par.fN)*par.amax*rapb;
um2=a*rapb*mq;
umax=um1-um2;
fprintf('rdeb: um1=%f,um2=%f\n',um1,um2);
KS1=par.KS*a*rapb;
hS=S./(KS1+S);
A=(1-par.fN)/(1-par.YRN*par.fN)*par.amax;

u=umax.*hS-mq.*(1-hS);
YG1=par.YSR.*(A-b.*u)./(a*par.amax);
q=(u+mq)./YG1;
%fprintf('a=%f\n',a);
%fprintf('b=%f\n',b);
%fprintf('b1=%f\n',(1./par.YRN+par.alpha/(par.kapmax*par.tauN*par.YRN*par.fN-1)));
%fprintf('b2=%e\n',(par.tauN*par.YRN*par.fN*par.amax)/(1-par.YRN*par.fN));

%fprintf('x=%f\n',(A-b*umax)/(a*par.amax));
end