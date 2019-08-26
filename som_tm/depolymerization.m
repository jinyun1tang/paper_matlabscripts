function depolymerf=depolymerization(x,extra)
%depolymerf=depolymerization(x,extra)
%Jinyun Tang (jinyuntang@lbl.gov)

vid=extra.vid;

E=x(vid.exoE);   %could be multiple
P=x(vid.somP).*extra.somP_sfa;  %could be multiple, som_sfa is surface area of the polymers
M=x(vid.minsM);  %only one mineral surface is considered
nE=numel(E);
nP=numel(P);

K_EP=extra.K_EP; %affinity matrix of enzyme to polymer, shape [nE, nP]
K_EM=extra.K_EM; %affinity vector of enzyme to mineral surface, shape [nE, nM]
V_EP=extra.V_EP; %shape nE, nP

A=[P,M];
KA=[K_EP,K_EM]; %shape [nA, nC]
EA=eca(E,A,KA);  %EA is of shape [nE,nC]

depolymerf=(EA(1:nE,1:nP).*V_EP)'*ones(nE,1);


end