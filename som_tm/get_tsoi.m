function t_soi=get_tsoi(t0,tf,dt,extra)
%get_tsoi(t0,tf,dt, extra)
%set up temperature forcing
%t0: initial time
%tf: final time
%dt: time step, [day]
%extra: parameter structure
kend=tf/dt;
Tfrz=273.15;
switch (extra.ttype)
    case 'ideal_ds'
        A1=10;         %seasonal amplitude
        A2=8;          %daily amplitude
        w1=2.*pi/365;
        w2=2.*pi;
        kk=(1:kend);
        t=t0+(kk-0.5)*dt;
        t_soi=Tfrz+A1.*sin(w1.*t-pi/2)+A2.*sin(w2.*t);
    case 'ideal_s'
        A1=10;         %seasonal amplitude
        w1=2.*pi/365;
        kk=(1:kend);
        t=t0+(kk-0.5)*dt;
        t_soi=Tfrz+A1.*sin(w1.*t-pi/2);    
    case 'ideal_d'
        A2=8;          %daily amplitude
        w2=2.*pi;
        kk=(1:kend);
        t=t0+(kk-0.5)*dt;
        t_soi=Tfrz+A2.*sin(w2.*t);        
    case 'ideal_const'
        A1=10;
        A0=A1.*0.636;      
        kk=(1:kend);        
        t_soi=ones(size(kk)).*Tfrz+A0;
end

end