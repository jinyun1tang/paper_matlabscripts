function par=resoms_pars()
%resoms_pars define parameters for the simplified resom model


par.vid.polyP=1;
par.vid.exoE=2;
par.vid.minsM=3;
par.vid.monoD=4;
par.vid.micB=5;

par.V_PE=1.e0;
par.K_PE=1.e0;
par.K_EM=1.e0;
par.V_DB=1.e0;
par.K_DB=1.e0;
par.K_DM=1.e0;
par.gamma_B=1.e-6;
par.gamma_E=1.e-6;
par.Y_DX=0.6;
par.Y_XB=0.6;
par.m_B=1.e-6;
par.alpha_B=1.0-1.e-1;
par.Y_XE=0.6;
par.I_p=1.e-3;
par.I_d=1.e-3;
par.f_b=0.7;
par.K_B=1.0;
end