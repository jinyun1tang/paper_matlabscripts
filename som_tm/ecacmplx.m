function [FcA,FrA,nA,nE]=ecacmplx(A,E,KA)

%[FcA,FrA]=ecacmplx(A,E,KA)
%compute the SUPECA flux vectors
%the network is in the form of 
% A (E)=>AE
%A: vector of substrate A

%E: vector of competitor E
%KA: affinity matrix of A to E
%FcA: col vector of normalized A 
%FrA: row vector of normalized A


nA=numel(A);
nE=numel(E);
FcA=zeros(nE,1);
FrA=zeros(nA,1);

for j1 = 1 : nA
    for j2 = 1 : nE
        if(isgoodK(KA(j1,j2)))
            FcA(j2)=FcA(j2)+A(j1)/KA(j1,j2);
            FrA(j1)=FrA(j1)+E(j2)/KA(j1,j2);
        end
    end
end

end


function yesno=isgoodK(K)
%determine if the K parameter signifies a calculation
yesno=K>0 && K<1.e10;
end
