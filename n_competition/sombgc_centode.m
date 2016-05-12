function dxdt=sombgc_centode(t,x,Extra)
%
%
% a formulation of the century biogeochemical model
%
par=Extra.par;
vid=Extra.vid;

casc=zeros(vid.nvars,vid.nreacs);

rdc=zeros(vid.nreacs,1);                                                            %potential c flux
%reaction 1: lit1 + 0.55*o2 -> 0.45 som1 + 0.55co2 + (1/cn_ratios(lit1) - 0.45/cn_ratios(som1))min_n+ (1/cp_ratios(lit1)-0.45/cp_ratios(som1))min_p
reac=vid.lit1_reac;
rdc(reac)=par.kd(vid.lit1)*x(vid.lit1);

casc(vid.lit1,reac)=-1;
casc(vid.som1,reac)=0.45;
casc(vid.minn,reac)=(1./par.rcn(vid.lit1)-par.lit1_to_som1/par.rcn(vid.som1));
casc(vid.minp,reac)=(1./par.rcp(vid.lit1)-par.lit1_to_som1/par.rcp(vid.som1));
%reaction 2: lit2 + 0.5 o2  -> 0.5 som1 + 0.5 co2 + (1/cn_ratios(lit2)-0.5/cn_ratios(som1))min_n +(1/cp_ratios(lit2)-0.5/cp_ratios(som1))min_p
reac=vid.lit2_reac;
rdc(reac)=par.kd(vid.lit2)*x(vid.lit2);

casc(vid.lit2,reac)=-1;
casc(vid.som1,reac)=0.5;
casc(vid.minn,reac)=(1./par.rcn(vid.lit2)-par.lit2_to_som1/par.rcn(vid.som1));
casc(vid.minp,reac)=(1./par.rcp(vid.lit2)-par.lit2_to_som1/par.rcp(vid.som1));
%reaction 3: lit3 + 0.5 o2 -> 0.5 som2 + 0.5 co2 + (1/cn_ratios(lit3) - 0.5/cn_ratios(som2))min_n + (1/cp_ratios(lit3)-0.5_r8/cp_ratios(som2))minp
reac=vid.lit3_reac;
rdc(reac)=par.kd(vid.lit3)*x(vid.lit3);

casc(vid.lit3,reac)=-1;
casc(vid.som2,reac)=0.5;
casc(vid.minn,reac)=(1./par.rcn(vid.lit3)-par.lit3_to_som2/par.rcn(vid.som2));
casc(vid.minp,reac)=(1./par.rcp(vid.lit3)-par.lit3_to_som2/par.rcp(vid.som2));
%reaction 4: som1 + f(txt) o2 -> f1*som2 + f2*som3 + f(txt) co2 + (1/cn_ratios(som1)-f1/cn_ratios(som2)-f2/cn_ratios(som3)) +(1/cp_ratios(som1)-f1/cp_ratios(som2)-f2/cp_ratios(som3))
%f(txt) = 0.85_r8 - 0.68_r8 * 0.01_r8 * (100._r8 - sand)
%f1+f2+f(txt)=1._r8
reac=vid.som1_reac;
rdc(reac)=par.kd(vid.som1)*x(vid.som1);

casc(vid.som1,reac)=-1;
casc(vid.som2,reac)=par.som1_to_som2;
casc(vid.som3,reac)=par.som1_to_som3;
casc(vid.minn,reac)=(1./par.rcn(vid.som1)-par.som1_to_som2/par.rcn(vid.som2)-par.som1_to_som3/par.rcn(vid.som3));
casc(vid.minp,reac)=(1./par.rcp(vid.som1)-par.som1_to_som2/par.rcp(vid.som2)-par.som1_to_som3/par.rcp(vid.som3));
%reaction 5: som2 + 0.55 o2 -> 0.42 som1 + 0.03som3 + 0.55co2 + (1/cn_ratios(som2)-0.42/cn_ratios(som1)-0.03/cn_ratios(som3)) + (1/cp_raitos(som2)-0.42/cp_ratios(som1)-0.03/cp_ratios(som3))    
reac=vid.som2_reac;
rdc(reac)=par.kd(vid.som2)*x(vid.som2);

casc(vid.som2,reac)=-1;
casc(vid.som1,reac)=0.42;
casc(vid.som3,reac)=0.03;
casc(vid.minn,reac)=(1./par.rcn(vid.som2)-par.som2_to_som1/par.rcn(vid.som1)-par.som2_to_som3/par.rcn(vid.som3));
casc(vid.minp,reac)=(1./par.rcp(vid.som2)-par.som2_to_som1/par.rcp(vid.som1)-par.som2_to_som3/par.rcp(vid.som3));
%reaction 6: som3 + 0.55 o2 -> 0.45*som1 + 0.55co2 + (1/cn_ratios(som3)-0.45/cn_ratios(som1)) + (1/cp_ratios(som3)-0.45/cp_ratios(som1))
reac=vid.som3_reac;

rdc(reac)=par.kd(vid.som3)*x(vid.som3);

casc(vid.som3,reac)=-1;
casc(vid.som1,reac)=0.45;
casc(vid.minn,reac)=(1./par.rcn(vid.som3)-par.som3_to_som1/par.rcn(vid.som1));
casc(vid.minp,reac)=(1./par.rcp(vid.som3)-par.som3_to_som1/par.rcp(vid.som1));

%reaction 7: cwd + o2 -> 0.76lit2 + 0.24*lit3 + (1/cn_ratios(cwd)-0.76/cn_ratios(lit2)-0.24/cn_ratios(lit3)) + (1/cp_ratios(cwd)-0.76/cp_ratios(lit2)-0.24/cp_ratios(lit3))
reac=vid.cwd_reac;
rdc(reac) =par.kd(vid.cwd)*x(vid.cwd);

casc(vid.cwd,reac)=-1;
casc(vid.lit2,reac)=0.76;
casc(vid.lit3,reac)=0.24;
casc(vid.minn,reac)=(1./par.rcn(vid.cwd)-par.cwd_to_lit2/par.rcn(vid.lit2)-par.cwd_to_lit3/par.rcn(vid.lit3));
casc(vid.minp,reac)=(1./par.rcp(vid.cwd)-par.cwd_to_lit2/par.rcp(vid.lit2)-par.cwd_to_lit3/par.rcp(vid.lit3));

reac=vid.minn_reac;
casc(vid.minn,reac)=-1;
rdc(reac)=par.lchn*x(vid.minn);

reac=vid.minp_reac;
casc(vid.minp,reac)=-1;
rdc(reac)=par.lchp*x(vid.minp);



%state variables 
%lit1, lit2, lit3, som1, som2, som3, cwd, o2, minn, minp
[p,d]=pd_decomp(casc);
p_casc=p.*casc;
d_casc=d.*casc;
%form the scacade matrix

p_dt=p_casc*rdc;
d_dt=d_casc*rdc;


dxdt=p_dt+d_dt;

dxdt=reshape(dxdt,size(x));

while(1)

    
    pscal=ones(vid.nvars,1);
    lneg=0;
    for j = 1 : vid.nvars    
        yp=x(j)+dxdt(j)*Extra.dt;
        if(yp<0)        
            pscal(j)=-(p_dt(j)*Extra.dt+x(j))/Extra.dt/d_dt(j);        
            if(pscal(j)<0)            
                disp(pscal(j),x(j),p_dt(j));        
            end            
            lneg=1;    
        end        
    end
   

    if(lneg==0)    
        break;
    end    
    if(lneg)    
        rscal=ones(vid.nreacs,1);    
        for j = 1 : vid.nreacs        
            rscal(j)=minp(pscal,d(:,j));    
        end        

        rdc=rdc.*rscal;    
        dxdt=(casc*rdc);
        
        
    end    
    dxdt=reshape(dxdt,size(x));

end

%mass bal check
mass_p=sum(dxdt(vid.ids)./par.rcp)+dxdt(vid.minp);
mass_n=sum(dxdt(vid.ids)./par.rcn)+dxdt(vid.minn);

if(max(abs([mass_n,mass_p]))>1.d-10 && max([par.lchp,par.lchn])==0d0)
    fprintf('mass_n=%e,mass_p=%e\n',mass_n,mass_p);
    fprintf('dt=%f\n',Extra.dt);
    

end
end