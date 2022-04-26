function [t,y]=euler_driver(y0,tspan,ns,extra)

extra.dt=(tspan(2)-tspan(1))/ns;
y1=y0;
t=(tspan(1):extra.dt:tspan(2));
nel=numel(t);
n=0;
y=zeros(nel,numel(y0));
while(n<nel)
    y(n+1,:)=y1;
    y1=add_dep(t(n+1),y1,extra);
    dydt2=euler_fwd(t(n+1),y1,extra);
    y1=y1+dydt2.*extra.dt;
    n=n+1;
end
end