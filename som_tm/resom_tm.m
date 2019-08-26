function dxdt=resom_tm(~,x,extra)
%dxdt=resom_tm(t,x,extra)
%ReSOM model with interactive temperature and moisture controls
%Jinyun Tang: jinyuntang@lbl.gov 
%assume all vectors are column major.

dxdt=zeros(size(x));
vid=extra.vid;
%carbon input from external environment
dxdt(vid.somP)=extra.I_somP./12;  %mol C/s
dxdt(vid.somD)=extra.I_somD./12;  %mol C/s

%depolymerization by exoEymes
%return a 1xnP vector
depolymerf=depolymerization(x,extra);

%monomer uptake
%return a nD*nB vector
monomerf=monomeruptake(x,extra);

%microbial physiology
%return 1xnB vectors
%get oxygen stress
fO2=getmic_fO2(x,extra);
%update the specific reserve mobilization rate
extra.micb.mic_ho=extra.micb.mic_h.*fO2;

[rgs,pes,rCO2,rds, mobXs]=micbphysiology(x,extra);

%microbial mortality, predation
%return 1xnB, 1xnE vectors
[rmortV,rdecE]=micbmortality(x,extra);

%update exoEyme, production + decay
dxdt(vid.exoE)=-rdecE.*x(vid.exoE)+pes.*x(vid.micBV);

%update structural biomass, growth + mortality
dmortV=(rds+rmortV).*x(vid.micBV);
dmortX=(rds+rmortV).*x(vid.micBX);

dxdt(vid.micBV)=dxdt(vid.micBV)+rgs.*x(vid.micBV)-dmortV;

%update reserve biomass, mobilization and mortality
dxdt(vid.micBX)=dxdt(vid.micBX)-mobXs.*x(vid.micBV)-dmortX;

%update CO2 and O2
dxdt(vid.co2)=x(vid.micBV)'*rCO2;

dxdt(vid.o2)=-dxdt(vid.co2);

%update microbial biomass
%1. new assimilation into reserve
%extract yield, and O2 flux needed for yield.
[monomerX,monomerCO2,monomerD]=monomerf_extract(monomerf,extra);

%microbial reserve
dxdt(vid.micBX)=dxdt(vid.micBX)+monomerX;

dxdt(vid.co2)=dxdt(vid.co2)+sum(monomerCO2);

%oxygen consumption
dxdt(vid.o2)=dxdt(vid.o2)-sum(monomerCO2.*extra.e_cont)*0.25+...
    extra.x_o2g*(extra.o2g_atm-x(vid.o2));

%update polymer, the last term needs modification when extrapolated to
%multiple organisms
dxdt(vid.somP)=dxdt(vid.somP)-depolymerf+extra.BV2somP*dmortV...
    +rdecE.*x(vid.exoE)+(1.-extra.BX2somD)*dmortX;

%update monomer
dxdt(vid.somD)=dxdt(vid.somD)-monomerD+extra.BX2somD*dmortX;
%mass balance check if needed

end

function [monomerX,monomerCO2,monomerD]=monomerf_extract(monomerf,extra)
%extract monomer fluxes to microbes and O2 requirement

nD=numel(extra.vid.somD);%number of monomers
nB=numel(extra.vid.micBV);%number of microbe populations
monomerX=(monomerf.*extra.Y_DX)'*ones(nD,1);     %vector,[nB,1]
monomerCO2=(monomerf.*(1-extra.Y_DX))*ones(nB,1);%vector, [nD,1]
monomerD=monomerf*ones(nB,1);

end

function fO2=getmic_fO2(x,extra)

E=x(extra.vid.micBV).*extra.B_sfa;   %could be multiple, B_sfa is surface area of the cells
A=x(extra.vid.o2);                    

KA=extra.K_O2B; %shape [nA, nC]
fO2=eca(E,A,KA)./E;  %EA is of shape [nE,nC]
end
