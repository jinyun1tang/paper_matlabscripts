function cumresp=twopool_modelwc(x,extra)
%compute respiration based on input parameter
%x, and auxillary parameter extra

%the model is defined as
%cumresp=Ctot*(f1*(1-exp(-k1*t)+f2*(1-exp(-k2*t)))
cumresp=x(extra.id_ctot).*(x(extra.id_f1).*(1.-exp(-x(extra.id_k1).*extra.t))+...
    x(extra.id_f2).*(1.-exp(-x(extra.id_k2).*t)));
end