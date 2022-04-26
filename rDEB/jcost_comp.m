function jcost=jcost_comp(x)
%compute the cost function for the sdeb model
global obs;
global par;
tend=500;
parcomp.umax= x(1);    
parcomp.mq  = x(2);
parcomp.KS  = x(3);     
parcomp.gmm = x(4); 
parcomp.YG  = x(5);
     
parcomp.vid.S=1;
parcomp.vid.B=2;
parcomp.vid.CO2=3;
parcomp.vid.BD=4;
par=parcomp;

y0=[43.43,x(6), 0,0];
ns=1000;
[t2,y2]=euler_driver_composite(y0,[0,tend],ns);

yq = interp1(t2,y2(:,par.vid.CO2),obs.t1);
jcost=sum((abs(yq-obs.yco2)./obs.std).^2);

end