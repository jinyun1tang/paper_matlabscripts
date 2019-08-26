function EAB=supeca(A,B,E,KA,KB)
%EAB=supeca(A,B,E,KA,KB)
%compute the supeca complex trio
%A: vector of substrate A
%B: vector of substrate B
%E: vector of competitor E
%KA: affinity matrix of A to E, shape [nA,nE]
%KB: affinity matrix of B to E, shape [nB,nE]
%return variable, EAB of shape [nA, nB, nE]

[FcA,FcB,GA,GB,nA,nB,nE]=supecacmplx(A,B,E,KA,KB);
EAB=zeros(nA,nB,nE);
FcAB=FcA+FcB;

for j3 = 1 : nE
    for j2 = 1 : nB
        for j1 = 1 : nA
            GAB=GA(j1,j3)+GB(j2,j3);
            EAB(j1,j2,j3)=E(j3)*A(j1)/KA(j1,j3)*B(j2)/KB(j2,j3)/...
                (GA(j1,j3)*GB(j2,j3)*FcAB(j3)/GAB+FcAB(j3)-...
                (FcA(j3)*GB(j2,j3)+GA(j1,j3)*FcB(j3)-GA(j1,j3)*GB(j2,j3))...
                /GAB);
     
        end
    end    
end