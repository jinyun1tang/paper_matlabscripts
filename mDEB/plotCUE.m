close all;
clear all;
clc;

K=0.1;v=10;
[cue1,mu1]=cuem(K,v);
[cue2,mu2]=cuet(K,v);
subplot(3,1,1);
plot(mu1,cue1);
hold on;
plot(mu2,cue2);

K=5;v=20;
[cue1,mu1]=cuem(K,v);
[cue2,mu2]=cuet(K,v);

subplot(3,1,2);
plot(mu1,cue1);
hold on;
plot(mu2,cue2);

s=(0:0.1:10);
jA=10.*s./(1+s);
mu=growth(jA);
subplot(3,1,3);
plot(s,mu);

[cue1,mu1]=mDEBgK();
[cue2,mu2]=sDEB();

figure;
plot(mu1,cue1);
hold on;
plot(mu2,cue2);

function [cue,mu]=cuem(K,v)
Yv=0.5;

m=1;
mu=(0:0.02:4-eps);

cue=mu./(mu+m).*(Yv.*v-m-mu)./(Yv.*v-m-mu+Yv.*K.*mu);
end

function [cue,mu]=cuet(K,v)
Yv=0.5;
m=1;
mu=(0:0.02:4-eps);

cue=mu./(mu+m).*(Yv.*v-(m+mu).*(1-K))./(Yv.*v-m-mu+Yv.*K.*mu);
end

function mu=growth(jA)
m=1;
v=10*m;
Yv=0.5;

mu=(m+v)./2.*(-1+sqrt(1+4.*v.*(jA.*Yv-m)./(m+v).^2));

end

function [cue,mu]=mDEBgK()

v=10;
mu=(0:0.1:8);
m=1;
cue=mu./(mu+m).*(v./(v+mu));
end


function [cue,mu]=sDEB()

v=10;
mu=(0:0.1:8);
m=1;
cue=mu./(mu+m).*((v-mu)./v);
end