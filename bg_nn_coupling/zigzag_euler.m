close all;
clear all;
clc;


x=zeros(101,1);
x(1)=1;
dt=0.125;
k=15;
x0=0.05;
%implicit scheme 1
for j = 2 : 101;
    xt=(k.*dt.*x0+x(j-1))/(1+k*dt);
    if(xt<0);
        xt=0;
    end
    x(j)=xt;
end
plot((0:100).*dt,x,'c','LineWidth',2);

hold on;

%implicit scheme 2
dt=dt*0.5;
x=zeros(201,1);
x(1)=1;

for j = 2 : 101;
    xt=(k.*dt.*x0+x(j-1))/(1+k*dt);
    if(xt<0);
        xt=0;
    end
    x(j)=xt;
end
plot((0:200).*dt,x,'g','LineWidth',2);


%forward scheme 1
x=zeros(101,1);
x(1)=1;
dt=0.125;

for j = 2 : 101;
    xt=x(j-1)*(1-k*dt)+k.*dt.*x0;
    if(xt<0);
        xt=0;
    end
    x(j)=xt;
end

plot((0:100).*dt,x,'b','LineWidth',2);

%forward scheme 2
dt=dt*0.5;
x=zeros(201,1);
x(1)=1;
for j = 2 : 201;
    xt=x(j-1)*(1-k*dt)+k.*dt.*x0;
    if(xt<0);
        xt=0;
    end
    x(j)=xt;
end
plot((0:200).*dt,x,'k','LineWidth',2);
tt=(0:200).*dt;
plot(tt,x(1).*exp(-k.*tt)+x0,'r','LineWidth',2);
xlim([0,4])

put_tag(gcf,gca,[0.05,0.8],'x''=-15(x-0.05), x(0)=1',14);
set(gca,'FontSize',14);

xlabel('t','FontSize',14);
ylabel('x','FontSize',14);
set(gcf,'color','w');

legend('Implicit Euler scheme: dt=1/8','Implicit Euler scheme: dt=1/16',...
    'Clipped Euler forward scheme: dt=1/8',...
'Clipped Euler forward scheme: dt=1/16','True solution');