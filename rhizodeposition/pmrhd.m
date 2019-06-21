function dxdt=pmrhd(t,x,extra)
%pmrhd plant micorbial coupling through rhizodeposition
%author: Jinyun Tang, jinyuntang@lbl.gov
%dxdt=pmrhd(t,x,extra)
%t: time
%x: state variable
%extra: parameter structure

dxdt=zeros(size(x));
vid=extra.vid;

P_C=x(vid.plantC);
P_N=x(vid.plantN);
M_C=x(vid.micrbC);
M_N=x(vid.micrbN);
S_C=x(vid.somC);
S_N=x(vid.somN);
N=x(vid.minN);
E_S=x(vid.engS);
E_s=E_S/S_C;
%litterfall
Flit_C=extra.gamma_PC*P_C;
Flit_N=extra.gamma_PN*P_N;
%rhizodeposition
rD=extra.lamdaC*max(P_C-P_N*extra.PbetaCN_opt,0.);
%SOM decomposition
%CN ratio
beta_SCN=S_C/S_N;
%yield rate
Y_C=E_S/(extra.E_S0*S_C)*extra.Y_C0;
%1total som uptake
A_C=extra.Vmax_C*S_C*M_C/(extra.K_SC+S_C+extra.alpha_MC*M_C);
A_N=A_C*min(Y_C/extra.Mbeta_CN,1./beta_SCN);
%microbial mortality
M_deathC=extra.gamma_MC*M_C/(extra.K_D+M_C);
M_deathN=M_deathC/extra.Mbeta_CN;
%nutrient compeition
alpha_PN=extra.alpha_PN0*max(1.0-P_N/P_C*extra.PbetaCN_opt);
fPN=extra.V_PN*alpha_PN*P_C*N/(extra.K_PN+N+alpha_PN*P_C+...
    extra.K_PN*M_C/extra.K_MN+extra.K_PN/extra.K0);
%mineralization
fminN=A_C*(1./beta_SCN-Y_C/extra.Mbeta_CN);
%uptake
fMN=max(-fminN,0.0);


%update the temperature tendencies
dxdt(vid.plantC)=extra.I_C-Flit_C-rD;
dxdt(vid.plantN)=fPN-Flit_N;
dxdt(vid.micrbC)=Y_C*A_C-M_deathC;
dxdt(vid.micrbN)=A_N+fMN-M_deathN;
dxdt(vid.somC)=Flit_C+rD-A_C+M_deathC;
dxdt(vid.somN)=Flit_N+M_deathN-A_N;
dxdt(vid.engS)=-A_C*E_s+extra.E_P*Flit_C+extra.E_D*rD+extra.E_S0*M_deathC;
dxdt(vid.minN)=extra.I_N+max(fminN,0.0)-fMN-fPN-extra.q*N;

end