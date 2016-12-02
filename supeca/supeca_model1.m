function cplx=supeca_model1(par,sol)

%sol:=[s1,s2,b,m];
%table A
%  B M
%s1
%table B
%  B
%s2

ss=sol(1:2);
ee=sol(3:4);

%par.Kbs1=1;
%par.Kbs2=2;
%par.Kms1=1.5;


Fra=ee(1)./par.Kbs1+ee(2)./par.Kms1;
Fca=ss(1)./par.Kbs1;

Fcb=ss(2)./par.Kbs2;
Frb=ee(1)./par.Kbs2;
Fcabk=Fca+Fcb;

Gaik=Fca+Fra;
Gbjk=Fcb+Frb;
Gabijk=Gaik+Gbjk;


%fprintf('fra=%f,frb=%f,Gaik=%f,Gbjk=%f,Gabijk=%f,Fcabk=%f\n',...
%    Fra,Frb,Gaik,Gbjk,Gabijk,Fcabk);

cplx=sol(3).*ss(1).*ss(2)./(par.Kbs1.*par.Kbs2)./(Gaik.*Gbjk.*Fcabk./Gabijk+Fcabk-...
    (Fca.*Gbjk+Gaik.*Fcb-Gaik.*Gbjk)./Gabijk);


%fprintf('fa=%f,fb=%f,fa_=%f,fb_=%f,fab=%f,fab_=%f\n',Fca,Fcb,Gaik,Gbjk,Fcabk,Gabijk);