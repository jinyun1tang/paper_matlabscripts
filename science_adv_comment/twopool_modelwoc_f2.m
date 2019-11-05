function [cumresp1,cumresp2]=twopool_modelwoc_f2(x,extra)
%compute respiration based on input parameter
%x, and auxillary parameter extra

%the model is defined as
%cumresp=Ctot*(f1*(1-exp(-k1*t)+f2*(1-exp(-k2*t)))

f1=extra.f1_0*x(extra.id_f1);
k1=extra.k1_0*x(extra.id_k1_tl);
k2=extra.k2_0*x(extra.id_k2_tl);
f2=1.-f1;

cumresp1=extra.ctot.*(f1.*(1.-exp(-k1.*extra.tl))+f2.*(1.-exp(-k2.*extra.tl)));


k1=extra.k1_0*x(extra.id_k1_th);
k2=extra.k2_0*x(extra.id_k2_th);

cumresp2=extra.ctot.*(f1.*(1.-exp(-k1.*extra.th))+f2.*(1.-exp(-k2.*extra.th)));


end