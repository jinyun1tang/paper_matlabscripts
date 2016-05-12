function dxdt=ncompet_pscal1(t,x,Extra)
%do solver automated nutrient scaling

vid=Extra.vid;
par=Extra.par;

dxdt=zeros(size(x));

pd_c1=par.k1*x(vid.c1);
pd_c2=par.k2*x(vid.c2);

pr_c1=((1-par.f)/par.rcn2-1/par.rcn1)*pd_c1;

pd_n = pr_c1;

rtot=pd_n*Extra.dt;
if(x(vid.n)>rtot)
    alpha=1;
else    
    alpha = x(vid.n)/rtot;
end


dxdt(vid.c1) = -pd_c1*alpha;

dxdt(vid.c2) = (1-par.f)*pd_c1*alpha-pd_c2;

dxdt(vid.n ) = -pr_c1*alpha + pd_c2; 
    

end
