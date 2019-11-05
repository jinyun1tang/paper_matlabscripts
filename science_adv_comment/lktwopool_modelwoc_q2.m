function fx=lktwopool_modelwoc_q2(x,extra)
%compute respiration based on input parameter
%x, and auxillary parameter extra

%the model is defined as
%cumresp=Ctot*(f1*(1-exp(-k1*t)+f2*(1-exp(-k2*t)))

f1=extra.f1_0*x(extra.id_f1);
k1=extra.k1_0*x(extra.id_k1_tl);
k2=extra.k2_0*x(extra.id_k2_tl);
k1_l=k1;k2_l=k2;
if(k1<=5*k2)
    fx=-1.e10;
    return;
end
f2=1.-f1;

cumresp=extra.ctot.*(f1.*(1.-exp(-k1.*extra.tl))+f2.*(1.-exp(-k2.*extra.tl)));

Err=(cumresp-extra.obs_csh_tl)./(extra.err_tl);

fx=-sum(Err.^2)*0.5;

k1=extra.k1_0*x(extra.id_k1_th);
k2=extra.k2_0*x(extra.id_k2_th);
qi=1;
if(k1<=5*k2 || k1 > k1_l*extra.qrange*qi || k2 > k2_l * extra.qrange)

    fx=-1.e10;
    return;
end

cumresp=extra.ctot.*(f1.*(1.-exp(-k1.*extra.th))+f2.*(1.-exp(-k2.*extra.th)));

Err=(cumresp-extra.obs_csh_th)./(extra.err_th);

fx=fx-sum(Err.^2)*0.5;

end