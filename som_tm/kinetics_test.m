%code to validity check of the substrate kinetics
close all;


KA=0.2;
ea_cplx1=zeros(100,1);
ea_cplx2=zeros(100,1);
ea_cplx3=zeros(100,1);
a=(1:100)*0.01;
for j = 1 : 100
    e1=0.02;
    ea_cplx1(j)=eca(a(j),e1,KA);
    e2=0.2;
    ea_cplx2(j)=eca(a(j),e2,KA);
    e3=2;
    ea_cplx3(j)=eca(a(j),e3,KA);    
end
linwd=2;
plot(a,ea_cplx1./e1,'b','LineWidth',linwd);
hold on;
plot(a,ea_cplx2./e2,'c','LineWidth',linwd);
hold on;
plot(a,ea_cplx3./e3,'r','LineWidth',linwd);
legend({'E=0.02','E=0.2','E=2'},'location','best');
xlabel('Substrate','FontSize',14);
ylabel('Normalzied EA complex','FontSize',14);

set(gca,'FontSize',14);
