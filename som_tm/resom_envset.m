function par=resom_envset(par0,tsoi,soim,zsoi,envobj)

%Avogadro's number
NA=6.02e23;
T0=298;
%set temeprature and moisture dependent model parameters
par=par0;

%gaseous diffusivity
difo2g=interp1(envobj.temp0,envobj.difo2gs,tsoi);
%aqueous diffusivity
%O2
difo2w=interp1(envobj.temp0,envobj.difo2ws,tsoi);
%DOC
difDw=interp1(envobj.temp0,envobj.difDws, tsoi);
%bunsen coefficient
bo2=interp1(envobj.temp0,envobj.bo2s,tsoi);
if(tsoi <= 273.15)
    [taug, tauw]=moldrup_taufrz(envobj, soim, tsoi);
else
    %gaseous tortuosity
    taug=interp1(envobj.soim0,envobj.taug,soim);
    %aqueous tortuosity
    tauw=interp1(envobj.soim0,envobj.tauw,soim);
end
%microbial activity
par.fact_mic=interp1(envobj.temp0,envobj.fact_micb,tsoi);
par.fact_exoenz=interp1(envobj.temp0,envobj.fact_exoenz,tsoi);

par.micb.mic_h=par.micb.mic_h0*par.fact_mic*fT_Eyring(par.micb.Eact_res,T0,tsoi);
par.micb.mic_m=par.micb.mic_m0*fT_arrhenius(par.micb.Eact_res,T0,tsoi);


vsoim=envobj.watsat*soim;
vsoia=envobj.watsat*(1.0-soim);
%non-normalized bulk diffusivity
%equation (3) in Tang and Riely (2019), JGR-B
difo2bw=difo2g*vsoia*taug/bo2+difo2w*vsoim*tauw;

difDbw=difDw*vsoim*tauw;

if(tsoi <= 273.15)
    filmth=interp1(envobj.temp1,envobj.filmthkt,tsoi);
else
    filmth=interp1(envobj.soim0,envobj.filmthkw,soim);
end

%equation (16) in Tang and Riley (2019), JGR-B.
ko2_1wdNA=4.*pi*difo2w*par.micb.radc*finterp(par.micb.Nports,par.fact_mic,...
    par.micb.rc2rp);

gamma_O2=1.+par.micsite.ncell./(4.*pi*(par.micsite.rad+filmth))...
    *(filmth./(difo2w*par.micsite.rad)+1./difo2bw)*ko2_1wdNA;

gamma_D=1.+par.micsite.ncell./(4.*pi*(par.micsite.rad+filmth))...
    *(filmth./(difDw*par.micsite.rad)+1./difDbw)*ko2_1wdNA;

%maximum DOC uptake rate, 1/s per cell
par.V_DB=par.micb.k2f1*par.fact_mic*fT_Eyring(par.micb.Eact_D,T0,tsoi);

par.V_DB=par.V_DB.*par.n0cell;

par.K0_DB=(par.micb.k2f1.*par.fact_mic+par.micb.k2f2)...
    *fT_Eyring(par.micb.Eact_D,T0,tsoi)/(4*pi*difDw*par.micb.radc*NA);

%equation (17) in Tang and Riley (2019), JGR-B
par.K0_O2w=(par.micb.k2f1.*par.fact_mic+par.micb.k2f2)...
    *fT_Eyring(par.micb.Eact_res,T0,tsoi)/(4*pi*difo2w*par.micb.radc*NA);


%depolymerization parameter
%depolymerization rate 1/s per particle
par.V_EP=par.V_EP0*par.fact_exoenz*fT_Eyring(par.Eact_poly,T0,tsoi);

%affinity
k1w0_poly=par.k1w0_poly*tsoi/298*finterp(par.NE_poly,par.fact_exoenz,...
    par.exoE.Rp2Re);

par.K0_EP=par.V_EP/k1w0_poly;
par.K_EP=par.K0_EP/(tauw*vsoim);
%scale with the particle density 
par.V_EP=par.V_EP.*par.n0poly;

%aqueous affinity parameter
%equation (12) in Tang and Riley (2019), JGR-B
par.K_O2w=par.K0_O2w*gamma_O2;
par.K_O2g=par.K_O2w/bo2;
par.K_DB=par.K0_DB*gamma_D;

%conductance of oxygen
rsoi_o2=zsoi*0.5/(difo2bw*bo2);
par.x_o2g=1./(zsoi*(par.ratm+rsoi_o2));

end


function fT=fT_arrhenius(Eact,T0,tsoi)
%arrhenius function
Rgas=8.314; %J / (mol. · K)
fT=exp(-Eact./Rgas*(1./tsoi-1./T0));

end

function fT=fT_Eyring(Eact,T0,tsoi)
%arrhenius function
Rgas=8.314; %J / (mol. · K)
fT=exp(-Eact./Rgas*(1./tsoi-1./T0)).*tsoi./T0;

end

function fint=finterp(Np,fact_mic,rc2rp)

fint=Np*fact_mic/(Np*fact_mic+pi*rc2rp);
end

