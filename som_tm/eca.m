function EA=eca(A,E,KA)
%EA=eca(A,E,KA)
%compute the eca complex duo
%A: vector of substrate A
%E: vector of competitor E
%KA: affinity matrix of A to E, of shape [nA,nE]
%reutrn variable: EA, shape [nA,nE]
[FcA,FrA,nA,nE]=ecacmplx(A,E,KA);

EA=zeros(nA,nE);

for j2= 1 : nE
    for j1 = 1 : nA
        EA(j1,j2)=E(j2)*A(j1)/KA(j1,j2)/(1.+FcA(j2)+FrA(j1));
    end
end


end