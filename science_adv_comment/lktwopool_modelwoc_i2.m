function fx=lktwopool_modelwoc_i2(x,extra)
%compute respiration based on input parameter
%x, and auxillary parameter extra

%the model is defined as
%cumresp=Ctot*(f1*(1-exp(-k1*t)+f2*(1-exp(-k2*t)))

f1=extra.f1_0*x(extra.id_f1);
k1=extra.k1_0*x(extra.id_k1_tl);
k2=extra.k2_0*x(extra.id_k2_tl);
f2=1.-f1;

cumresp=extra.ctot.*(f1.*(1.-exp(-k1.*extra.t))+f2.*(1.-exp(-k2.*extra.t)));

Err=(cumresp-extra.obs_csh_tl)./(extra.obs_csh_tl.*0.01);

fx=-sum(Err.^2)*0.5;

k1=extra.k1_0*x(extra.id_k1_th);
k2=extra.k2_0*x(extra.id_k2_th);

cumresp=extra.ctot.*(f1.*(1.-exp(-k1.*extra.t))+f2.*(1.-exp(-k2.*extra.t)));

Err=(cumresp-extra.obs_csh_th)./(extra.obs_csh_th.*0.01);

fx=fx-sum(Err.^2)*0.5;

end