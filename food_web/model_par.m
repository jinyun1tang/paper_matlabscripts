function par=model_par()
%define model paramters for t1n2pd1
%par=model_par()
%par: return structure

par.vid.n=1;  %nutrient
par.vid.mr=2; %rod bacteria
par.vid.mc=3; %cocci bacteria
par.vid.mp=4; %predator

%the following values need be reassigned.
par.D=1.e-3;     %dilution rate
par.n0=1.e-9;    %external nutrient concentration
par.Yrn=0.3;     %rod yield rate
par.murn=1.e-4;  %maximum growth rate, rod
par.Krn=1.e-6;   %half saturation parameter for rod nutrient uptake
par.mucn=1.e-4;  %maximum growth rate, cocci
par.Ycn=0.3;     %cocci yield rate
par.Kcn=1.e-6;   %half saturation parameter for cocci nutrient uptake
par.mr=1.e-10;   %specific weight of rod bacteria
par.mc=1.e-10;   %specific weight of cocci bacteria
par.mp=1.e-6;    %specific weight of predator
par.Kpr=1.e-3;   %half saturation constant for rod predation
par.Kpc=1.e-3;   %half saturation constant for cocci predation
par.mupr=0.3;    %maximum predation rate for rod
par.mupc=0.3;    %maximum predation rate for cocci
par.Ypc=0.3;     %yield rate of taking up cocci
par.Ypr=0.3;     %yield rate of taking up rod
end