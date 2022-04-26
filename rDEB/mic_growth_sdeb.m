function [umax,mq,u,q,YG2]=mic_growth_sdeb(S,par)
%standard deb model for microbial growth
%author: Jinyun Tang (jinyuntang@gmail.com)
%S: substrate concentration vector
%par: parameter structure
scalar=par.kap0/(par.kap0+par.amax*par.YRV);
KSb=par.KS*scalar;
umax=par.YRV*par.amax*scalar-par.mV*scalar;
h2S=S./(KSb+S);
mq=par.mV;
u=umax.*h2S-par.mV.*(1.-h2S);
YG2=par.YSR*par.YRV.*(1.-u./par.kap0);
q=(u+par.mV)./YG2;


end