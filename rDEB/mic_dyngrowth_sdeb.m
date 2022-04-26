function dydt=mic_dyngrowth_sdeb(t,y)
%standard deb model for microbial growth
%author: Jinyun Tang (jinyuntang@gmail.com)
%S: substrate concentration vector
%par: parameter structure
global par;
dydt=zeros(size(y));vid=par.vid;
%obtain substrate concentration
S=y(vid.S);XR=y(vid.BR);XV=y(vid.BV);
%compute reserve density
xR=XR./XV;
%update the flux variables
%substrate uptake
JA=par.amax*S/(par.KS+S);

%apply uptake
dydt(par.vid.S)=-JA;
dydt(par.vid.BR)=JA*par.YSR;
dydt(par.vid.CO2)=JA*(1.-par.YSR);

%growth rate
gVg=(par.kap0*xR-par.mV/par.YRV)/(1./par.YRV+xR);

%apply growth
jM=par.gmm;
if(gVg>=0.)
    %active growth
    JRN=(par.kap0-gVg)*XR;
    dydt(par.vid.BV)=dydt(par.vid.BV)+gVg*XV;
    dydt(par.vid.BR)=dydt(par.vid.BR)-JRN;    
    dydt(par.vid.CO2)=dydt(par.vid.CO2)+((par.mV+gVg)/par.YRV-gVg)*XV;
else
    %penalty mortality
    JRN=par.kap0*XR;
    jM=jM-gVg;    
    dydt(par.vid.BR)=dydt(par.vid.BR)-JRN;
    dydt(par.vid.CO2)=dydt(par.vid.CO2)+JRN;
end
%apply mortality
dydt(par.vid.BD)=jM*(XV+XR);
dydt(par.vid.BV)=dydt(par.vid.BV)-jM*XV;
dydt(par.vid.BR)=dydt(par.vid.BR)-jM*XR;
end