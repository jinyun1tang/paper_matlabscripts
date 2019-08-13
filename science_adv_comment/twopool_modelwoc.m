function cumresp=twopool_modelwoc(x,extra)
%compute respiration based on input parameter
%x, and auxillary parameter extra

%the model is defined as
%cumresp=Ctot*(f1*(1-exp(-k1*t)+f2*(1-exp(-k2*t)))


f1=extra.f1_0*x(extra.id_f1);
k1=extra.k1_0*x(extra.id_k1);
k2=extra.k2_0*x(extra.id_k2);
f2=1.-f1;

cumresp=extra.ctot.*(f1.*(1.-exp(-k1.*extra.t))+f2.*(1.-exp(-k2.*extra.t)));
end