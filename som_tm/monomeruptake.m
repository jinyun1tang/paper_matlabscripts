function monomerf=monomeruptake(x,extra)
%monomerf=monomeruptake(x,extra)
%uptake of organic monomer
%Jinyun Tang: jinyuntang@lbl.gov
%return variable, monomerf, of shape [nD,nB]
vid=extra.vid;
D=x(vid.somD);
B=x(vid.micBV).*extra.B_sfa; %multiply cell population with surface area
O2=x(vid.o2);
M=x(vid.minsM);
E=[B;M];
nD=numel(D);
nB=numel(B);
KD = [extra.K_DB,extra.K_DM]; %shape [nA,nE]
KO2 =[extra.K_O2B,zeros(extra.K_DM)];%shape [nB,nE]
V_DB=extra.micb.V_DB;  %shape [nD,nB]
EAB=supeca(D,O2,E,KD,KO2);

monomerf=squeeze(EAB(1:nD,1,1:nB)).*V_DB.*extra.micb.mic_fR;

end