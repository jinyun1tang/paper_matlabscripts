function par=resoms_pars(model)
%resoms_pars define parameters for the simplified resom model
if(nargin==0)
    model='simple';
end
fprintf('model: %s\n',model);
par.I_p=0.8*1.e-5;  %polymer input, gC/s,  
par.I_d=0.2*1.e-5;

par.vid.polyP=1;
par.vid.exoE=2;
par.vid.monoD=3;
par.vid.micB=4;
par.vid.varnames={'P','E','D','B','M'};
switch model
    case 'simple'
        par.vid.minsM=5;
        par.V_PE=2.8e-5;
        par.K_PE=200.e0;
        par.K_EM=50.e0;
        par.V_DB=1.2e-4;
        par.K_DB=1.e0;
        par.K_DM=25.e0;
        par.gamma_B=1.e-7;
        par.gamma_E=1.e-8;
        par.Y_DX=0.6;
        par.Y_XB=0.6;
        par.m_B=2.6e-7;
        par.alpha_B=1.0-1.e-1;
        par.Y_XE=0.6;
        par.f_b=0.7;
        par.K_B=1.0;
    case 'mm'
        par.vid.minsM=5;
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
        par.f_b=0.7;
        par.K_B=1.0;        
    case 'cent'
        par.V_LP=1.e0;
        par.V_LD=1.e0;
        par.K_DB=1.e0;
        par.K_DM=1.e0;
        par.gamma_B=1.e-6;
        par.gamma_E=1.e-6;
        par.Y_DX=0.6;
        par.Y_XB=0.6;
        par.m_B=1.e-6;
        par.alpha_B=1.0-1.e-1;
        par.Y_XE=0.6;
        par.f_b=0.7;
        par.K_B=1.0;        
end
end