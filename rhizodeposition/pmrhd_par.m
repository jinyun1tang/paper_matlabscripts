function par=pmrhd_par()
%pmrhd_par set up model parameters for the model of plant microbial 
%interaction through rhizodeposition.
%author: Jinyun Tang, jinyuntang@lbl.gov
%par=pmrhd_par()

par.vid.plantC=1;
par.vid.plantN=2;
par.vid.micrbC=3;
par.vid.micrbN=4;
par.vid.somC=5;
par.vid.somN=6;
par.vid.minN=7;
par.vid.engS=8;

par.gamma_PC=1.e-5; %[s-1],litterfall rate for the plant carbon pool
par.gamma_PN=5.e-6; %[s-1], litterfall rate for the plant nitrogen pool
par.lamdaC=1.e-6;   %[s-1], rhizodeposition rate
par.PbetaCN_opt=60;  %optimal carbon to nitrogen ratio of plants.
par.E_S0=0.6;
par.Y_C0=0.6;
par.E_P=0.5;
par.E_D=0.9;
par.Vmax_C=1.e-6;   %[s-1], maximum SOM uptake rate
par.Mbeta_CN=5;     %microbial C to N ratio, molar based.
par.gamma_MC=1.e-7; %[s-1], basal microbial mortality rate
par.K_D=1.0;        %[mol C m-3], half saturation for microbial mortality
par.alpha_PN0=0.05; %[-], fraction of biomass involved in nutrient uptake
par.V_PN=1.e-5;
par.K_PN=1.;
par.K_SC=1.0;
par.alpha_MC=0.05;
par.K_MN=0.5;
par.K0=0.1;        %[-], affinity parameter from abiotic competitors
par.I_C=1.e-5;      %[mol C s-1], input plant carbon
par.I_N=1.e-9;      %[mol N s-1], fertilization rate
par.q=1.e-8;        %[s-1], mineral N loss rate from other processes.
end