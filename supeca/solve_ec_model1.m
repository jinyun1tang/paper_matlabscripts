function cplx=solve_ec_model1(s1,s2,b,m,par)


sol=[s1,s2,b,m];

sol0=sol;
iter=0;
while(1)
    %the newton's method is as following
    % f(x0)+jac*(x-x0)=0
    % x=x0-(jac^-1)*f(x0)*rho;
    %fun=eval_func(sol,sol0,par);
    
    %jac=jacobian(sol(1),sol(2),sol(3),sol(4),par);
    
    %dx=jac\fun';
    %p=findp(sol,dx,sol0).*0.99;
    
    %sol=sol-p.*dx';
    [sol_new,fun]=fixp_iter(sol,sol0,par);
    if(max(abs(fun./sol_new))<1.e-6 || iter > 1000)
        if(iter>1000)
            fprintf('iter=%d,err=%f\n',iter,max(abs(fun./sol_new))); 
        end
        break;
    end
    iter=iter+1;
    sol=sol_new;
    %fprintf('iter=%d, sol=%f,%f,%f,%f fun=%f,%f,%f,%f\n',iter,sol,fun);
    %pause;

end

cplx = (par.kbs2*sol(3)*sol(2)+par.kbs1*sol(3)*sol(1))/par.k2;

end


function [sol_new,fun]=fixp_iter(sol,sol0,par)



s1=sol(1);s2=sol(2);b=sol(3);m=sol(4);
sol_new(1)=sol0(1)/(1+m/par.Kms1+par.kbs1*b/(par.kbs2*s2)+par.kbs2*b*s2/(s1*par.k2)+...
    par.kbs1*b/par.k2);
sol_new(2)=sol0(2)/(1+par.kbs2*b/(par.kbs1*s1)+par.kbs2*b/par.k2+par.kbs1*b*s1/(s2*par.k2));
sol_new(3)=sol0(3)/(1+par.kbs1*s1/(par.kbs2*s2)+par.kbs2*s2/(par.kbs1*s1)+...
    par.kbs2*s2/par.k2+par.kbs1*s1/par.k2);
sol_new(4)=sol0(4)/(1+s1/par.Kms1);


fun=sol_new-sol;

end

function fun=eval_func(sol,sol0,par)

fun=zeros(size(sol));
s1=sol(1);s2=sol(2);b=sol(3);m=sol(4);
fun(1)=s1+m*s1/par.Kms1+par.kbs1*b*s1/(par.kbs2*s2)+par.kbs2*b*s2/par.k2+...
    par.kbs1*b*s1/par.k2;
fun(2)=s2+par.kbs2*b*s2/(par.kbs1*s1)+par.kbs2*b*s2/par.k2+par.kbs1*b*s1/par.k2;
fun(3)=b+par.kbs1*b*s1/(par.kbs2*s2)+par.kbs2*b*s2/(par.kbs1*s1)+...
    par.kbs2*b*s2/par.k2+par.kbs1*b*s1/par.k2;
fun(4)=m+s1*m/par.Kms1;


fun=fun-sol0;
end

function jac=jacobian(s1,s2,b,m,par)


jac=zeros(4,4);

jac(1,1)=1+m/par.Kms1+par.kbs1*b/(par.kbs2*s2)+par.kbs1*b/par.k2;
jac(1,2)=-par.kbs1*b*s1/(par.kbs2*s2*s2)+par.kbs2*b/par.k2;
jac(1,3)=par.kbs1*s1/(par.kbs2*s2)+par.kbs2*s2/par.k2+par.kbs1*s1/par.k2;
jac(1,4)=s1/par.Kms1;

jac(2,1)=-par.kbs2*b*s2/(par.kbs1*s1*s1)+par.kbs1*b/par.k2;
jac(2,2)=1+par.kbs2*b/(par.kbs1*s1)+par.kbs2*b/par.k2;
jac(2,3)=par.kbs2*s2/(par.kbs1*s1)+par.kbs2*s2/par.k2+par.kbs1*s1/par.k2;
jac(2,4)=0;

jac(3,1)=par.kbs1*b/(par.kbs2*s2)-par.kbs2*b*s2/(par.kbs1*s1*s1)+par.kbs1*b/par.k2;
jac(3,2)=-par.kbs1*b*s1/(par.kbs2*s2*s2)+par.kbs2*b/(par.kbs1*s1)+par.kbs2*b/par.k2;
jac(3,3)=1+par.kbs1*s1/(par.kbs2*s2)+par.kbs2*s2/(par.kbs1*s1)+par.kbs2*s2/par.k2+par.kbs1*s1/par.k2;
jac(3,4)=0;

jac(4,1)=m/par.Kms1;
jac(4,2)=0;
jac(4,3)=0;
jac(4,4)=s1/par.Kms1;
end


function p=findp(x,dx,x0)

nn=length(x);
p=1;
for jj = 1 : nn
    xt=x(jj)-dx(jj);
    if(xt>x0(jj))
        p = min(abs((x-x0)/dx(jj)),p);
    elseif(xt<0)
        p=min(p,abs(x(jj)/dx(jj)));
    end
    
end

end