function dxdt=ncompet_fullscal(t,x,Extra)
%do solver automated nutrient scaling

vid=Extra.vid;
par=Extra.par;

dxdt=zeros(size(x));


dxdt(vid.c1) = -par.k1*x(vid.c1);

dxdt(vid.c2) = (1-par.f)*par.k1*x(vid.c1)-par.k2*x(vid.c1);

dxdt(vid.n ) = -(1-par.f)*par.k1*x(vid.c1)/par.rcn2+dxdt(vid.c1)/par.rcn1...
    + par.k2*x(vid.c2)/par.rcn2;

end
