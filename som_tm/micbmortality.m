function [rmortV,rdecE]=micbmortality(x,extra)
%[rmortV,rdecE]=micbmortality(x,extra)
%compute the decay rate of microbes and enzymes
%specific mortality of the microbes
vid=extra.vid;
denorm=1+sum(x(vid.micBV)./extra.rmortV_1);
rmortV=extra.rmortV_0.*x(vid.micBV)./extra.rmortV_1./denorm;
%linear decay of the enzymes
rdecE=extra.exoE.dek_E;
end