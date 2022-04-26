function [a,b,c,r2]=nlRregress(x,y)
%nonlinear regression using the respiration function from the DEB model
%
global extra;
extra.mu=x;
extra.rb=y;
x0=[1,1,mean(y)];
options = optimset('MaxFunEvals',300*5);

x1 = fminsearch(@errfunc,x0,options);
a=x1(1);
b=x1(2);
c=x1(3);
mu=extra.mu;
rb=extra.rb;
dn=1.-b.*mu;
rbh=(a./dn-1.).*mu+c./dn;

r2=1.-var(rbh-rb)/var(rb);
end


function res=errfunc(x)
global extra;
mu=extra.mu;
rb=extra.rb;
dn=1.-x(2).*mu;
rbh=(x(1)./dn-1.).*mu+x(3)./dn;

res=sum((rb-rbh).^2);
end