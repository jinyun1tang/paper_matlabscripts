function dxdt=sombgc_centclm(t,x,Extra)
%
%
% a formulation of the century biogeochemical model
%
par=Extra.par;
vid=Extra.vid;

rdc=zeros(7,1);                                                            %potential c flux
rdn=zeros(7,1);                                                            %potential n flux
rdp=zeros(7,1);                                                            %potential p flux
%reaction 1: lit1 + 0.55*o2 -> 0.45 som1 + 0.55co2 + (1/cn_ratios(lit1) - 0.45/cn_ratios(som1))min_n+ (1/cp_ratios(lit1)-0.45/cp_ratios(som1))min_p
rdc(vid.lit1)=par.kd(vid.lit1)*x(vid.lit1);
rdn(vid.lit1)=(1./par.rcn(vid.lit1)-par.lit1_to_som1/par.rcn(vid.som1))*rdc(vid.lit1);
rdp(vid.lit1)=(1./par.rcp(vid.lit1)-par.lit1_to_som1/par.rcp(vid.som1))*rdc(vid.lit1);
%reaction 2: lit2 + 0.5 o2  -> 0.5 som1 + 0.5 co2 + (1/cn_ratios(lit2)-0.5/cn_ratios(som1))min_n +(1/cp_ratios(lit2)-0.5/cp_ratios(som1))min_p
rdc(vid.lit2)=par.kd(vid.lit2)*x(vid.lit2);
rdn(vid.lit2)=(1./par.rcn(vid.lit2)-par.lit2_to_som1/par.rcn(vid.som1))*rdc(vid.lit2);
rdp(vid.lit2)=(1./par.rcp(vid.lit2)-par.lit2_to_som1/par.rcp(vid.som1))*rdc(vid.lit2);
%reaction 3: lit3 + 0.5 o2 -> 0.5 som2 + 0.5 co2 + (1/cn_ratios(lit3) - 0.5/cn_ratios(som2))min_n + (1/cp_ratios(lit3)-0.5_r8/cp_ratios(som2))minp
rdc(vid.lit3)=par.kd(vid.lit3)*x(vid.lit3);
rdn(vid.lit3)=(1./par.rcn(vid.lit3)-par.lit3_to_som2/par.rcn(vid.som2))*rdc(vid.lit3);
rdp(vid.lit3)=(1./par.rcp(vid.lit3)-par.lit3_to_som2/par.rcp(vid.som2))*rdc(vid.lit3);

%reaction 4: som1 + f(txt) o2 -> f1*som2 + f2*som3 + f(txt) co2 + (1/cn_ratios(som1)-f1/cn_ratios(som2)-f2/cn_ratios(som3)) +(1/cp_ratios(som1)-f1/cp_ratios(som2)-f2/cp_ratios(som3))
%f(txt) = 0.85_r8 - 0.68_r8 * 0.01_r8 * (100._r8 - sand)
%f1+f2+f(txt)=1._r8
rdc(vid.som1)=par.kd(vid.som1)*x(vid.som1);
rdn(vid.som1)=(1./par.rcn(vid.som1)-par.som1_to_som2/par.rcn(vid.som2)-par.som1_to_som3/par.rcn(vid.som3))*rdc(vid.som1);
rdp(vid.som1)=(1./par.rcp(vid.som1)-par.som1_to_som2/par.rcp(vid.som2)-par.som1_to_som3/par.rcp(vid.som3))*rdc(vid.som1);
%reaction 5: som2 + 0.55 o2 -> 0.42 som1 + 0.03som3 + 0.55co2 + (1/cn_ratios(som2)-0.42/cn_ratios(som1)-0.03/cn_ratios(som3)) + (1/cp_raitos(som2)-0.42/cp_ratios(som1)-0.03/cp_ratios(som3))    
rdc(vid.som2)=par.kd(vid.som2)*x(vid.som2);
rdn(vid.som2)=(1./par.rcn(vid.som2)-par.som2_to_som1/par.rcn(vid.som1)-par.som2_to_som3/par.rcn(vid.som3))*rdc(vid.som2);
rdp(vid.som2)=(1./par.rcp(vid.som2)-par.som2_to_som1/par.rcp(vid.som1)-par.som2_to_som3/par.rcp(vid.som3))*rdc(vid.som2);
%reaction 6: som3 + 0.55 o2 -> 0.45*som1 + 0.55co2 + (1/cn_ratios(som3)-0.45/cn_ratios(som1)) + (1/cp_ratios(som3)-0.45/cp_ratios(som1))
rdc(vid.som3)=par.kd(vid.som3)*x(vid.som3);
rdn(vid.som3)=(1./par.rcn(vid.som3)-par.som3_to_som1/par.rcn(vid.som1))*rdc(vid.som3);
rdp(vid.som3)=(1./par.rcp(vid.som3)-par.som3_to_som1/par.rcp(vid.som1))*rdc(vid.som3);
%reaction 7: cwd + o2 -> 0.76lit2 + 0.24*lit3 + (1/cn_ratios(cwd)-0.76/cn_ratios(lit2)-0.24/cn_ratios(lit3)) + (1/cp_ratios(cwd)-0.76/cp_ratios(lit2)-0.24/cp_ratios(lit3))
rdc(vid.cwd) =par.kd(vid.cwd)*x(vid.cwd);
rdn(vid.cwd) =(1./par.rcn(vid.cwd)-par.cwd_to_lit2/par.rcn(vid.lit2)-par.cwd_to_lit3/par.rcn(vid.lit3))*rdc(vid.cwd);
rdp(vid.cwd) =(1./par.rcp(vid.cwd)-par.cwd_to_lit2/par.rcp(vid.lit2)-par.cwd_to_lit3/par.rcp(vid.lit3))*rdc(vid.cwd);
%state variables 
%lit1, lit2, lit3, som1, som2, som3, cwd, o2, minn, minp



id_loc=find(rdn<0);
tot_nd=sum(rdn(id_loc));                              %total nitrogen demand
id_loc=find(rdp<0);
tot_pd=sum(rdp(id_loc));                              %total phosphorus demand

if(-tot_nd*Extra.dt>x(vid.minn))
    alpha_n=x(vid.minn)/(-tot_nd*Extra.dt);
else
    alpha_n=1;
end

if(-tot_pd*Extra.dt>x(vid.minp))
    alpha_p=x(vid.minp)/(-tot_pd*Extra.dt);
else
    alpha_p=1;
end

for j = 1 : length(vid.ids)
    if(rdn(vid.ids(j))<0.)
        if(rdp(vid.ids(j))<0.)
            %potentially, N&P limited
            alpha = min(alpha_n,alpha_p);
        else
            %potentially, N limited
            alpha=alpha_n;            
        end
        
        rdc(vid.ids(j))=rdc(vid.ids(j))*alpha;
        rdn(vid.ids(j))=rdn(vid.ids(j))*alpha;
        rdp(vid.ids(j))=rdp(vid.ids(j))*alpha;        
    else
        if(rdp(vid.ids(j))<0.)
            %potentiall, P limited
            alpha=alpha_p;
            rdc(vid.ids(j))=rdc(vid.ids(j))*alpha;
            rdn(vid.ids(j))=rdn(vid.ids(j))*alpha;
            rdp(vid.ids(j))=rdp(vid.ids(j))*alpha;  
        end
    end
end

dxdt(vid.cwd) =-rdc(vid.cwd);
dxdt(vid.lit1)=-rdc(vid.lit1);
dxdt(vid.lit2)=-rdc(vid.lit2)+rdc(vid.cwd)*par.cwd_to_lit2;
dxdt(vid.lit3)=-rdc(vid.lit3)+rdc(vid.cwd)*par.cwd_to_lit3;
dxdt(vid.som1)=-rdc(vid.som1)+rdc(vid.lit1)*par.lit1_to_som1+rdc(vid.lit2)*par.lit2_to_som1+rdc(vid.som2)*par.som2_to_som1+rdc(vid.som3)*par.som3_to_som1;
dxdt(vid.som2)=-rdc(vid.som2)+rdc(vid.lit3)*par.lit3_to_som2+rdc(vid.som1)*par.som1_to_som2;
dxdt(vid.som3)=-rdc(vid.som3)+rdc(vid.som1)*par.som1_to_som3+rdc(vid.som2)*par.som2_to_som3;

dxdt(vid.minn)=sum(rdn)-par.lchn*x(vid.minn);
dxdt(vid.minp)=sum(rdp)-par.lchp*x(vid.minp);
dxdt=reshape(dxdt,size(x));

mass_p=sum(dxdt(vid.ids)./par.rcp)+dxdt(vid.minp);
mass_n=sum(dxdt(vid.ids)./par.rcn)+dxdt(vid.minn);

if(max(abs([mass_n,mass_p]))>1.d-10  && max([par.lchp,par.lchn])==0d0)
    fprintf('mass_n=%e,mass_p=%e\n',mass_n,mass_p);
    fprintf('dt=%f\n',Extra.dt);
    

end

end