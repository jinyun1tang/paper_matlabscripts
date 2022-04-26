function dydt=mic_dyngrowth_rDEB(t,y)
%revised DEB model for microbial growth
%author: Jinyun Tang (jinyuntang@gmail.com)
%S: substrate concentration vector
%par: parameter structure
global par;
dydt=zeros(size(y));vid=par.vid;
%obtain substrate concentration
S=y(vid.S);
%obtain the model parameters
kapmax = par.kapmax;
amax   = par.amax;
alpha  = par.alpha;
KS     = par.KS;
mV     = par.mV;
gmm    = par.gmm;
tauN   = par.tauN;
fN     = par.fN;
KR0    = par.KR0;
YRV    = par.YRV;
YRN    = par.YRN;
YSR    = par.YSR;
phiV   = par.phiV;
dN     = par.dN;
dR     = par.dR;
%determine the reserve biomass density
xR=y(vid.BR)/y(vid.BV);
%determine the non-structural biomass density
xN=y(vid.BN)/y(vid.BV);
%compute KR, equation (
KR=KR0*(max(1-phiV*(1+xN*dN+xR*dR),1.e-5)).^(-2);
%compute reserve mobilization rate, equation (10)
kapa=kapmax*xN/(KR+xR+alpha*xN);
%compute specific growth rate
gV=((1.-fN)*kapa*xR-mV/YRV)/(1./YRV+(1-fN)*xR);

if(gV<=0)
    gmm=gmm-gV;
    gV=0;
    respV=(1.-fN)*kapa*xR;
else
    respV=mV./YRV+gV*(1./YRV-1.);
end
%compute substrate uptake
JA=amax*S/(KS+S)*y(vid.BV);
%compute reserve mobilization rate
JRN=(kapa-gV)*y(vid.BR);
%update reserve biomass
dydt(vid.BR)=JA*YSR-JRN-gmm*y(vid.BR)+1./tauN*y(vid.BN);
%update non-structural biomass
dydt(vid.BN)=YRN*fN*JRN-gmm*y(vid.BN)-1./tauN*y(vid.BN);
%update structural biomass
dydt(vid.BV)=(gV-gmm)*y(vid.BV);
%compute respiration
dydt(vid.CO2)=JA*(1-YSR)+respV*y(vid.BV)+fN*(1.-YRN)*JRN;
%update substate
dydt(vid.S)=-JA;
dydt(vid.BD)=gmm*(y(vid.BV)+y(vid.BR)+y(vid.BN));
end