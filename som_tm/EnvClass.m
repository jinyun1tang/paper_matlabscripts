classdef EnvClass
   properties
      difo2gs
      difo2ws
      difDws
      filmthkw
      filmthkt
      bo2s
      temp0
      temp1
      soim0
      taug
      tauw
      watsat
      chb
      fact_micb
      fact_exoenz
   end
   methods
       function obj=EnvClass(pct_sand,pct_clay,fom,zsoi, par0)
       
           %obtain the soil parameters
           [obj.chb,obj.watsat, psisat, ~]=clapp_hornberg_par(pct_sand,...
               pct_clay, fom, zsoi);
           %set up temperature
           obj.temp0=273.15+(-20:50);
           %set up moisture
           obj.soim0=(1:100)./100;
           obj.soim0(1:99)=obj.soim0(1:99)-0.001;
           %get gaseous oxygen diffusivity
           obj.difo2gs=get_o2diffusg(obj.temp0);
           %get aqueous oxygen diffusivity
           obj.difo2ws=get_o2diffusw(obj.temp0);
           %get bunsen coefficient
           obj.bo2s=bunsen_o2(obj.temp0);
           [obj.taug, obj.tauw]=moldrup_tau(obj.watsat, obj.chb, obj.soim0);
           obj.filmthkw=wfilm_thickw(psisat, obj.chb, obj.soim0);
           obj.temp1=(-20:0)+273.15;
           obj.filmthkt=wfilm_thicktf(obj.temp1);
           
           obj.fact_exoenz=fact_murphy(obj.temp0, par0.exoE.n,par0.exoE.N_CH);
           obj.fact_micb=fact_murphy(obj.temp0, par0.micb.n,par0.micb.N_CH);
           obj.difDws=5.5e-10*obj.temp0/298.;
       end

       function [taug, tauw]=moldrup_taufrz(obj, s_sat, tsoi)
           %calculate tortuosity using Moldrup's (2003) equation"""
           %sat: saturated water content
           %chb: clapp-hornberg constant
           %s_sat: soil water saturation
           %get fraction of ice;
           fice=fice_dkzx(s_sat,tsoi);
           epsi=obj.watsat.*(1.0-s_sat);
           ss_sat=s_sat.*(1.-fice);%water filled pores
           theta=obj.watsat.*ss_sat;
           % equation (5)
           taug=epsi.*((1.0-s_sat)./(1-ss_sat)).^(3.0./obj.chb);
           %equation (3)
           tauw=theta.*(min(ss_sat./(1-ss_sat)+1.e-10,1.)).^(obj.chb/3.0-1.0);
       end
   end
end

%other functions
       
function dif_o2g=get_o2diffusg(temp)
%gaseous oxygen diffusivity
%dif_o2g= m2 s-1
dif_o2g=1.61e-5.*(temp./273.0).^1.82; 
end


function dif_o2w=get_o2diffusw(temp)
%aqueous oxygen diffusivity
%dif_o2w= m2 s-1
dif_o2w=2.4e-9.*temp./298.0;
end


function bo2=bunsen_o2(temp_kelvin)
%
%compute bunsen solubility for o2 
%bo2: bunsen solubility
henry=1.3e-3.*exp(-1500.0.*(1.0./temp_kelvin-1.0/298.15));
bo2=henry.*temp_kelvin./12.2;    
end


function [taug, tauw]=moldrup_tau(sat, chb, s_sat)
%calculate tortuosity using Moldrup's (2003) equation"""

%sat: saturated water content
%chb: clapp-hornberg constant
%s_sat: soil water saturation
epsi=sat.*(1.0-s_sat);
theta=sat.*s_sat;
% equation (5)
taug=epsi.*(1.0-s_sat).^(3.0./chb);
%equation (3)
tauw=theta.*(s_sat+1.e-10).^(chb/3.0-1.0);
end


function psi=cosby_psi(psisat, chb, s_sat)
%compute the soil water potential (pressure)
%psisat: saturated matric potential, mm
%chb: b constant
%s_sat: level of saturation
%psi: Pascal
%grav
grav=9.8; %m s-2
psi=max(psisat.*(s_sat+1.e-20).^(-chb),-1.e8).*grav;
end


function [chb,watsat, psisat, hksat]=clapp_hornberg_par(pct_sand,...
    pct_clay, fom, zsoi)
%Calculate Clapp Honberg parameters
%pct_sand: percent sand, by weight
%pct_clay: percent clay, by weight
%chb: b constant
%sat: soil porosity
%psisat: mm
%hksat: mm/s
chb=2.91+0.195.*pct_clay;
watsat=0.489-0.00126.*pct_sand;
psisat=-10.0.^(1.88-0.0131.*pct_sand);
xksat=0.0070556*10.0.^(-0.884+0.0153.*pct_sand);
pcalpha   = 0.5;
zsapric   = 0.5;
pcbeta    = 0.139;
om_hksat=0.;
if (fom > 0.)        
    om_watsat  = max(0.93 - 0.1 *(zsoi/zsapric), 0.83);
    om_b       = min(2.7  + 9.3   *(zsoi/zsapric), 12.0);
    om_sucsat  = min(10.3 - 0.2   *(zsoi/zsapric), 10.1);
    om_hksat   = max(0.28 - 0.2799*(zsoi/zsapric), 0.0001);
    %  bd  = (1. - watsat)*2.7e3
    watsat    = (1.-fom) * watsat + om_watsat*fom;
    chb       = (1.-fom) * chb + fom*om_b;
    psisat    = (1.-fom) * psisat + om_sucsat*fom;
end
% perc_frac is zero unless perf_frac greater than percolation threshold
if (fom > pcalpha) 
    perc_norm=(1. - pcalpha)^(-pcbeta);
    perc_frac=perc_norm*(fom - pcalpha)^pcbeta;
else    
    perc_frac=0.;    
end

% uncon_frac is fraction of mineral soil plus fraction of "nonpercolating" organic soil
uncon_frac=(1.-fom)+(1.-perc_frac)*fom;
% uncon_hksat is series addition of mineral/organic conductivites

if (fom < 1.) 
    uncon_hksat=uncon_frac/((1.-fom)/xksat ...
        +((1.-perc_frac)*fom)/om_hksat);        
else        
    uncon_hksat = 0.;    
end
hksat = uncon_frac*uncon_hksat + (perc_frac*fom)*om_hksat;
   
end

function deltaw=wfilm_thicktf(tsoi)
%  """
%  compute water film thickness, m      
%  """
tfrz=273.15; %freezing point
hfus=3.337e5; %heat of fusion      
rhow=1.e3;  %water density

psi= -hfus.*(tfrz-tsoi+eps)./tsoi .* rhow;  %Pa
deltaw = max(min(exp(-13.65-0.857.*log(-psi.*1.e-6)),1.e-5),1.e-8);
   
end 

function deltaw=wfilm_thickw(psisat, chb, s_sat)
%  """
%  compute water film thickness, m      
%  """
psi=cosby_psi(psisat, chb, s_sat); %Pa    
deltaw = max(exp(-13.65-0.857.*log(-psi.*1.e-6)),1.e-8);
   
end 


             
       
function fact=fact_murphy(tsoi, n, N_CH)
%physiological temperature function of proteins
%n: number of amind acids
%N_CH: average number of non-polar hydrogen atmos per amion acid residue
%Delta_H_s: enthalpy change at T_Hs
%parameterized based on Corkrey et al., 2014
Delta_S_s=17.0;%entropy change at T_s
T_Hs=375.5;  % the convergence temperature for enthalpy, [K]
T_s=390.9;   % the convergence temperature of entropy, [K]
Delta_H_s=4874; %J/mol amino acid residue
Rgas=8.314;  % [J / (mol. · K)]

Delta_Cp = -46.0+30.*(1.-1.54.*n.^(-0.268)).*N_CH;%heat capacity
Delta_G_E= Delta_H_s-tsoi.*Delta_S_s+Delta_Cp...
    .*((tsoi-T_Hs)-tsoi.*log(tsoi./T_s));
fact=1./(1.+exp(-n.*Delta_G_E./(Rgas.*tsoi)));
end

function fice=fice_dkzx(s_sat,tsoi)
%get the ice fraction of the soi moisture
%using the Zeng & Decker (2006) algorithm
alpha=2.0;beta=4.0;
fice=(1.0-exp(alpha.*s_sat.^beta.*(tsoi-273.15)))./exp(1.0-s_sat);
end
