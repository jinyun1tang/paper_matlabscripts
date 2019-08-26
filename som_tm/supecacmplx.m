function [FcA,FcB,GA,GB,nA,nB,nE]=supecacmplx(A,B,E,KA,KB)
%[FcA,FcB,GA,GB]=supecacmplx(A,B,KA,KB)
%compute the SUPECA flux vectors
%the network is in the form of 
%A+B (E)=> EAB, or A (E)=>AE, B(E)=> BE
%which could be a mix of redox reactions and single substrate reactions
%A: vector of substrate A
%B: vector of substrate B
%E: vector of competitor E
%KA: affinity matrix of A to E
%KB: affinity matrix of B to E
%FcA: col vector of normalized A 
%FcB: col vector of normalized B
%GA: matrix of eca A form
%GB: matrix of eca B form

nA=numel(A);
nB=numel(B);
nE=numel(E);

FcA=zeros(nE,1);
FcB=zeros(nE,1);
FrA=zeros(nA,1);
FrB=zeros(nB,1);
for j2 = 1 : nE
    for j1 = 1 : nA
        if(isgoodK(KA(j1,j2)))
            FcA(j2)=FcA(j2)+A(j1)/KA(j1,j2);
            FrA(j1)=FrA(j1)+E(j2)/KA(j1,j2);
        end
    end

    for j1 = 1 : nB
        if(isgoodK(KB(j1,j2)))
            FcB(j2)=FcB(j2)+B(j1)/KB(j1,j2);
            FrB(j1)=FrB(j1)+E(j2)/KB(j1,j2);
        end
    end
end

GA=zeros(nA,nE);
GB=zeros(nB,nE);
for j2=1:nE
    for j1 = 1 : nA
        GA(j1,j2)=FcA(j2)+FrA(j1);
    end
    
    for j1 = 1 : nB
        GB(j1,j2)=FcB(j2)+FrB(j1);
    end
end
end

function yesno=isgoodK(K)
%determine if the K parameter signifies a calculation
yesno=K>0 && K<1.e10;
end
