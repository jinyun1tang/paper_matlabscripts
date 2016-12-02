close all;
clear all;
clc;
nn=5000;
ss1=random('uniform',0,nn,[nn,1]);
ss2=random('uniform',0,nn,[nn,1]);
sb=random('uniform',0,nn,[nn,1]);
sm=random('uniform',0,nn,[nn,1]);
spar.k2=48.*ones(nn,1);

spar.Kbs1=random('exp',1,[nn,1]).*100;
spar.Kbs2=random('exp',1,[nn,1]).*100;
spar.Kms1=random('exp',1,[nn,1]).*100;
spar.kbs1=spar.k2./spar.Kbs1;
spar.kbs2=spar.k2./spar.Kbs2;

fprintf('ec , supeca, su, sup\n');
cplx_ec=zeros(nn,1);
cplx_sp=zeros(nn,1);
cplx_su=zeros(nn,1);
cplx_sup=zeros(nn,1);
for mi = 1 : nn
    s1=ss1(mi);
    s2=ss2(mi);
    b=sb(mi);
    m=sm(mi);
    par.k2=spar.k2(mi);
    par.Kbs1=spar.Kbs1(mi);
    par.Kbs2=spar.Kbs2(mi);
    par.Kms1=spar.Kms1(mi);
    par.kbs1=spar.kbs1(mi);
    par.kbs2=spar.kbs2(mi);
    
    cplx_ec(mi)=solve_ec_model1(s1,s2,b,m,par);

    s1m=(par.Kms1+m+s1)/2d0*(1d0-sqrt(1d0-4*m*s1/(par.Kms1+m+s1)^2));

    cplx_sp(mi)=supeca_model1(par,[s1,s2,b,m]);

    fa=par.kbs1*(s1-s1m);

    fb=par.kbs2*s2;

    cplx_su(mi)=b/(1+par.k2/fa+par.k2/fb-par.k2/(fa+fb));

    fab=fa+fb;

    fa_=fa+par.kbs1*b;

    fb_=fb+par.kbs2*b;

    fab_=fa_+fb_;

    cplx_sup(mi)=fa*fb*b/(fa_*fb_*fab/fab_+fab*par.k2-(fa*fb_+fa_*fb-fa_*fb_)*par.k2/fab_);

    fprintf('%d\n',mi);

%fprintf('xxfa=%f,fb=%f,fa_=%f,fb_=%f,fab=%f,fab_=%f\n',fa/par.k2,fb/par.k2,...
%    fa_/par.k2,fb_/par.k2,fab/par.k2,fab_/par.k2);
end
plot(cplx_ec,cplx_sp,'rd');
w=linearfit(cplx_ec,cplx_sp);
str1=sprintf('SUPECA: y=%.6f(%s%.5f) x %s %.6f(%s%.5f)\n',w(1),setstr(177),w(2),ssign(w(3)),abs(w(3)),setstr(177),w(4));
hold on;
plot(cplx_ec,cplx_su,'kd');
w=linearfit(cplx_ec,cplx_su);
str2=sprintf('SU: y=%.6f(%s%.5f) x %s %.6f(%s%.5f)\n',w(1),setstr(177),w(2),ssign(w(3)),abs(w(3)),setstr(177),w(4));
plot(cplx_ec,cplx_sup,'gd');
w=linearfit(cplx_ec,cplx_sup);
str3=sprintf('SUPECA+QD: y=%.6f(%s%.5f) x %s %.6f(%s%.5f)\n',w(1),setstr(177),w(2),ssign(w(3)),abs(w(3)),setstr(177),w(4));

xlabel('x: EC predicted enzyme-substrate complex','FontSize',14);
ylabel('y: Approximated eznyme-substrate complex with different methods','FontSize',14);
legend(str1,str2,str3);legendmarkeradjust(15);
set(gca,'FontSize',14);
set(gcf,'color','w');
mksz=5;
figure;
subplot(2,3,1);plot(ss1,cplx_ec,'.','MarkerSize',mksz);hold on;plot(ss1,cplx_sp,'r.','MarkerSize',mksz);
plot(ss1,cplx_su,'k.','MarkerSize',mksz);plot(ss1,cplx_sup,'g.','MarkerSize',mksz);
xlabel('Substrate S1 (mol/V)','FontSize',14);
ylabel('Enzyme-substrate complex (mol/V)','FontSize',14);
set(gca,'FontSize',14);
put_tag(gcf,gca,[0.95,0.9],'(a)',14);

subplot(2,3,2);plot(ss2,cplx_ec,'.','MarkerSize',mksz);hold on;plot(ss2,cplx_sp,'r.','MarkerSize',mksz);
plot(ss2,cplx_su,'k.','MarkerSize',mksz);plot(ss2,cplx_sup,'g.','MarkerSize',mksz);
xlabel('Substrate S2 (mol/V)','FontSize',14);
ylabel('Enzyme-substrate complex (mol/V)','FontSize',14);
set(gca,'FontSize',14);
put_tag(gcf,gca,[0.95,0.9],'(b)',14);

subplot(2,3,3);plot(spar.Kbs1,cplx_ec,'.','MarkerSize',mksz);hold on;plot(spar.Kbs1,cplx_sp,'r.','MarkerSize',mksz);
plot(spar.Kbs1,cplx_su,'k.','MarkerSize',mksz);plot(spar.Kbs1,cplx_sup,'g.','MarkerSize',mksz);
xlabel('Inverse affinity for substrate S1 (mol/V)','FontSize',14);
ylabel('Enzyme-substrate complex (mol/V)','FontSize',14);
set(gca,'FontSize',14);
put_tag(gcf,gca,[0.95,0.9],'(c)',14);

subplot(2,3,4);plot(spar.Kbs2,cplx_ec,'.','MarkerSize',mksz);hold on;plot(spar.Kbs2,cplx_sp,'r.','MarkerSize',mksz);
plot(spar.Kbs2,cplx_su,'k.','MarkerSize',mksz);plot(spar.Kbs2,cplx_sup,'g.','MarkerSize',mksz);
xlabel('Inverse affinity for S2 (mol/V)','FontSize',14);
ylabel('Enzyme-substrate complex (mol/V)','FontSize',14);
set(gca,'FontSize',14);
put_tag(gcf,gca,[0.95,0.9],'(d)',14);

subplot(2,3,5);plot(sb,cplx_ec,'.','MarkerSize',mksz);hold on;plot(sb,cplx_sp,'r.','MarkerSize',mksz);
plot(sb,cplx_su,'k.','MarkerSize',mksz);plot(sb,cplx_sup,'g.','MarkerSize',mksz);
xlabel('Enzyme abundance (mol/V)','FontSize',14);
ylabel('Enzyme-substrate complex (mol/V)','FontSize',14);
set(gca,'FontSize',14);
put_tag(gcf,gca,[0.95,0.9],'(e)',14);

set(gcf,'color','w');

legend('EC','SUPECA','SU','SUPECA+QD');
legendmarkeradjust(10);
