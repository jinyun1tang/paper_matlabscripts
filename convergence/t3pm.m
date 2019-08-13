function [t,x]=t3pm(tf,x0,extra)
%dxdt=t3pm(t,x,extra)
%the 3-pool model with internal transfers
%t: time
%x: pools x1, x2, and x3

tspan=[0,tf];
odefun=@(t,y)t3pmf(t,y,extra);

[t,x]=ode45(odefun,tspan,x0);

end



function dxdt=t3pmf(t,x,extra)

dxdt=extra.amat*diag(extra.kf)*x;

end