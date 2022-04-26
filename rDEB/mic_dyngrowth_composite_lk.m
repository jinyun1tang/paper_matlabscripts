function jcost=mic_dyngrowth_composite_lk(x,Extra)
%compute the cost function for the sdeb model
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
yb = interp1(t2,y2(:,par.vid.BD),Extra.obs_t1);

yq = interp1(t2,y2(:,par.vid.CO2),Extra.obs_t1);
%jcost=-sum((abs(yq-Extra.obs_yco2)./Extra.obs_std).^2);
jcost=-sum((abs(yq-Extra.obs_yco2)./1).^2)-...
    sum(abs(((yb)-(Extra.obs_yB))./1).^2)-...
    sum(abs(diff(yq)-diff(Extra.obs_yco2)).^2)-...
    sum(abs(diff(yb)-diff(Extra.obs_yB)).^2);

end