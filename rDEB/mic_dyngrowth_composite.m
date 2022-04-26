function dydt=mic_dyngrowth_composite(t,y)
%composite model for microbial growth
%author: Jinyun Tang (jinyuntang@gmail.com)
%S: substrate concentration vector
%par: parameter structure
global par;
dydt=zeros(size(y));vid=par.vid;
%obtain substrate concentration
S=y(vid.S);
%update the flux variables
h_S=S./(par.KS+S);
u=par.umax.*h_S-par.mq.*(1.-h_S);
q=(u+par.mq)./par.YG;
%update the temporal tendencies
dydt(par.vid.S)=-q*y(vid.B);%+par.gmm*y(vid.B);
dydt(par.vid.B)=(u-par.gmm)*y(vid.B);
dydt(par.vid.CO2)=(q-u)*y(vid.B);
dydt(par.vid.BD)=par.gmm*y(vid.B);
end