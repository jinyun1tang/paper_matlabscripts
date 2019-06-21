function dxdt=t1n2p1d(t,x,model_par)
%dxdt=t1n2p1d(t,x,model_par)
%t: time
%x: state vector
%model_par: model parameters
%a trophic model with one resource, two consumer and one predator

%obtain the varaible id vector
vid=model_par.vid;
dxdt=zeros(size(x));


r=x(vid.mr)/model_par.mr;
p=x(vid.mp)/model_par.mp;
c=x(vid.mc)/model_par.mc;
%nutrient uptake by rod
Frn=model_par.murn/model_par.Yrn*(x(vid.n)*x(vid.mr)/(model_par.Krn+x(vid.n)));

%nutrient uptake by cocci
Fcn=model_par.mucn/model_par.Ycn*(x(vid.n)*x(vid.mc)/(model_par.Kcn+x(vid.n)));

%predation of rod
Fpr=model_par.mupr/model_par.Ypr*(x(vid.mr)*p)/model_par.Kpr...
    /(1.0+r/model_par.Kpr+c/model_par.Kpc+p/model_par.Kpr);

%predation of cocci
Fpc=model_par.mupc/model_par.Ypc*(x(vid.mc)*p)/model_par.Kpc...
    /(1.0+r/model_par.Kpr+c/model_par.Kpc+p/model_par.Kpc);

%tendency of nutrient 
dxdt(vid.n)=model_par.D*(model_par.n0-x(vid.n))-Frn-Fcn;

%tendency of rod bacteria
dxdt(vid.mr)=Frn*model_par.Yrn-Fpr-model_par.D*x(vid.mr);

%tendency of cocci bacteria
dxdt(vid.mc)=Fcn*model_par.Ycn-Fpc-model_par.D*x(vid.mc);

%tendency of predator
dxdt(vid.mp)=(Fpr*model_par.Ypr+Fpc*model_par.Ypc)*model_par.mp-...
    model_par.D*x(vid.mp);

end