function dydt=euler_fwd(t,y,extra)
%solve the ABC model using the forward euler scheme
vid=extra.vid;
par=extra.par;
dydt=zeros(size(y));
dt=extra.dt;
fa=par.ka*y(vid.id_a);
fbc=par.vmax*y(vid.id_b)*y(vid.id_c)/(par.kff+y(vid.id_b));
fc=par.kc*y(vid.id_c);
qloss=par.q*y(vid.id_b);

if(fa*dt>y(vid.id_a))
    fa=y(vid.id_a)/dt;
end
if((fbc+qloss)*dt>(y(vid.id_b)))
    ql=(y(vid.id_b))/((fbc+qloss)*dt);
    fbc=fbc.*ql;
    qloss=qloss.*ql;
end
if(fc*dt>y(vid.id_c))
    fc=y(id.id_c)/dt;
end

dydt(vid.id_a)=par.gamma*fc-fa;
dydt(vid.id_b)=par.alpha*fa-fbc-qloss;
dydt(vid.id_c)=par.beta*fbc-fc;
end