function dxdt=resom_centm(t,x,extra)
%dxdt=resom_centm(x,t,extra)
%century-like model for soil c dynamics
%author: Jinyun Tang, jinyuntang@lbl.gov

dxdt=zeros(size(x));

vid=extra.vid;

P=x(vid.polyP);
E=x(vid.exoE);
D=x(vid.monoD);
B=x(vid.micB);
%exoenzyme degradation of polymer
F_EP=extra.V_LP*P;

%monomer uptake
F_DB=extra.V_LD*D;

%microbial mortality
G_B=extra.gamma_B*B/(extra.K_B+B);

%enzyme decay
G_E=extra.gamma_E*E;

%new cell
NewCell=max(extra.Y_DX*F_DB-extra.m_B*B,0.)*extra.alpha_B*extra.Y_XB;

%new enzyme
NewEnz=max(extra.Y_DX*F_DB-extra.m_B*B,0.)*(1.0-extra.alpha_B)*extra.Y_XE;

dxdt(vid.polyP)=extra.I_p+extra.f_b*G_B+G_E-F_EP;
dxdt(vid.monoD)=extra.I_d+(1.0-extra.f_b)*G_B-F_DB;
dxdt(vid.micB)=NewCell-G_B;
dxdt(vid.exoE)=NewEnz-G_E;


end