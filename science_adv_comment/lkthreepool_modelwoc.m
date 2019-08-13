function  fx=lkthreepool_modelwoc(x,extra)
%cumres=threepool_model(x,extra)
%compute cumulative respiration of three pool model
f1=extra.f1_0*x(extra.id_f1);
f2=extra.f2_0*x(extra.id_f2);
k1=extra.k1_0*x(extra.id_k1);
k2=extra.k2_0*x(extra.id_k2);
k3=extra.k3_0*x(extra.id_k3);

f12=extra.f12_0*x(extra.id_f12);
f13=extra.f13_0*x(extra.id_f13);
f21=extra.f21_0*x(extra.id_f21);
f31=extra.f31_0*x(extra.id_f31);
f32=extra.f32_0*x(extra.id_f32);

K=diag([k1,k2,k3]);
A=[-1,f12,f13;f21,-1,0;f31,f32,0];
G=eye(3)/(eye(3)-A*K.*extra.dt);

C0=[f1,f2,1-f1-f2]'.*extra.Ctot;
if(C0(3)<0. || (f12+f13)>1. || f21>1. || (f31+f32)>1.)
    fx=-1.e100;
else
    Co=C0;
    nstep=ceil(extra.t(end)/extra.dt);
    cumresp=zeros(1,nstep);
    for j = 1 : nstep
        Cn=G*Co;
        cumresp(j)=sum(C0-Cn);
        Co=Cn;
    end
    Err=(cumresp-extra.obs_csh)./(extra.obs_csh.*0.01);

    fx=-sum(Err.^2)*0.5;
end
end