function par=resom_par()

%set up model parameters
par.vid.micBV=1;
par.vid.micBX=2;
par.vid.exoE=3;
par.vid.somP=4;
par.vid.somD=5;
par.vid.o2=6;
par.vid.co2=7;
par.vid.minsM=8;
par.vid.vsz=par.vid.minsM;

par.I_somD=300.*0.2/365/86400;  %gC/s
par.I_somP=300.*0.8/365/86400;  %gC/s
par.e_cont=4;    %number of electrons the monomer can confer
par.BV2somP=1.0; %conversion of structural microbial biomass to polymer P
par.BX2somD=0.3; %conversion of reserve biomass to monomer D.

par.B_sfa=1.; %microbial surface area for monomer binding
par.somP_sfa=1.; %polymer surface area for enzyme binding
par.K_EM =1;   %affinity of enzyme to mineral surface binding

par.micb.K_DB =1;   %affinity of monomer binding to structural microbial biomass
par.K_DM =1;   %affinity of monomer binding to mineral surface
par.micb.K_O2B=1;   %affinity of oxygen binding to microbes
par.micb.V_DB =1;   %specific monomer processing rate [1/s]

par.micb.mic_ho=1;  %oxygen conditioned reserve mobilization rate [1/s]
par.micb.mic_m=1;   %specific maintenance  rate [1/s]
par.micb.mic_h=1;   %basic reservation mobilization rate [1/s]

par.micb.mic_m0=1;  %reference maintenance rate [1/s]
par.micb.mic_h0=1;  %reference reserve mobilization rate [1/s]

par.exoE.dek_E=1.e-6;%enzyme decay rate
par.exoE.n=500;      %number of amino acids
par.exoE.N_CH=6.0;   %number of non-polar hydrogen atmos per amino acids

par.micb.n=270;      %number of amino acids
par.micb.N_CH=6.0;   %number of non-polar hydrogen atmos per amino acids

par.rp_poly=1.e-5;   %polymer radius [m]
par.fC_poly=0.5;     %polymer carbon content
par.rho_poly=1.35e6; %polymer mass denisty, g /m3
par.exoE.M0=par.exoE.n*137;
par.exoE.rad=0.066*(par.exoE.M0).^(1/3).*1.0e-9; %exoenzyme radius [m]
par.exoE.Rp2Re=par.rp_poly/par.exoE.rad; %ratio of polymer to enzyme radius
par.exoE.Vm_poly=5;  %specific maximum depolymerization rate [1/s]

%exoenzyme reference diffusivity at 298 K, equation 6.3, Erickson (2009).
par.exoE.DE0=2.2e-19/par.exoE.rad; 
par.sigma_poly=0.5;  %binding surface density, unit [none]
par.NE_poly=4.*par.sigma_poly.*(par.exoE.Rp2Re).^2;
par.V_EP0=par.exoE.Vm_poly*par.NE_poly;
par.k1w0_poly=4.*pi.*par.exoE.DE0*6.02e23*par.rp_poly;

par.rmortV_0=1.15e-6;
par.rmortV_1=0.1;
par.mic_yldVm=0.8;
par.mic_YldV=0.6;
par.mic_YldE=0.6;
par.Y_DX=0.6;

par.micb.mic_alphaE_max=0.03;  %maximum enzyme produciton effort
par.micb.mic_alphaE=par.micb.mic_alphaE_max;
par.micb.mic_fR=1;
par.micb.mic_Kx=1./0.6;
par.micb.radc=1.e-6;  %cell radius, [m]
par.micb.radp=1.e-9;  %porter radius, [m]
par.micb.rc2rp=par.micb.radc/par.micb.radp;
par.micb.mic_ea=0.5;  %ratio of metabolic flux for enzyme production to growth
par.micb.vdpmaxr=300; %maximum substrate processing rate per transporter, [s-1]
par.micb.Nports=pi*par.micb.radc/par.micb.radp;
par.micb.k2f1=par.micb.vdpmaxr*par.micb.Nports;
par.micb.k2f2=par.micb.vdpmaxr*par.micb.Nports;
par.micb.Eact_res=60e3; %J/mol
par.Eact_poly=45e3; %J/mol
par.micb.Eact_D=45e3; %J/mol
par.micsite.ncell=10;
par.micsite.rad=(80*par.micsite.ncell).^(1/3)*par.micb.radc;
par.n0cell=2.68e-11; %mol cells (mol C)^(-1)
par.nC=10;
par.n0poly=12./(6.02e23*4*pi*par.rp_poly.^3.*par.rho_poly./3.*par.fC_poly);  %polymer particle number density  [particles /mol C]
par.ratm=50;  %aerodynamic resistance, m/s
par.o2g_atm=8.51;  %atmospheric oxygen, mol O2/m3
end