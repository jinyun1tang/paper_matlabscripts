function [umax,mq,u,q]=mic_growth_composite(S,par)
%composite model for microbial growth
%author: Jinyun Tang (jinyuntang@gmail.com)
%S: substrate concentration vector
%par: parameter structure
h_S=S./(par.KS+S);
umax=par.umax;
mq=par.mq;
u=par.umax.*h_S-par.mq.*(1.-h_S);
q=(u+par.mq)./par.YG;
end