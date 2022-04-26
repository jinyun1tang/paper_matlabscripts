function jcost=mic_dyngrowth_sdeb2_lk(x,Extra)
%compute the cost function for the sdeb model
global par;
tend=500;
parsdeb.kap0=x(1);
parsdeb.KS=x(2);
parsdeb.amax=x(3);
parsdeb.YRV=x(4);
parsdeb.YSR=x(5);
parsdeb.mV=x(6);%1.e-5;
parsdeb.gmm=x(7);
parsdeb.YDR=x(9);
parsdeb.vid.S=1;
parsdeb.vid.BV=2;
parsdeb.vid.BR=3;
parsdeb.vid.CO2=4;
parsdeb.vid.BD=5;
par=parsdeb;

y0=[Extra.S0, Extra.B0*x(8), Extra.B0*(1-x(8)), 0,0];
%[t2,y2]=ode23s(@mic_dyngrowth_sdeb,[0,tend],y0);
ns=1000;
[t2,y2]=euler_driver_sdeb2(y0,[0,tend],ns);

yq = interp1(t2,y2(:,par.vid.CO2),Extra.obs_t1);
yb = interp1(t2,y2(:,par.vid.BD),Extra.obs_t1);
jcost=sum(abs(((yq)-(Extra.obs_yco2))./1).^2)+...
    +sum(abs(((yb)-(Extra.obs_yB))./1).^2);%+...
%    sum(abs((diff(yq)-diff(Extra.obs_yco2))./1).^2)+...
%    +sum(abs((diff(yb)-diff(Extra.obs_yB))./1).^2);   
%jcost=sum(abs(((yq)-(Extra.obs_yco2))./(0.025*(Extra.obs_yco2))).^2)...
%    +sum(abs(((yb)-(Extra.obs_yB))./(0.025*(Extra.obs_yB))).^2);%+exp(8.*(x(3)-0.9))+exp(8*(x(4)-0.9));
jcost=-jcost;
%jcost=sum(abs(yq-obs.yco2)
%disp((exp(8.*(x(3)-1))+exp(8*(x(4)-1)))./jcost);
end