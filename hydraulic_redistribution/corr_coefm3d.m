function coef=corr_coefm3d(mat1,mat2)
%compute the correlation of two input 3d matrices
%the correlation if computed for the 3rd dimension


sz1=size(mat1,1);
sz2=size(mat1,2);

if(sz1~=size(mat2,1) || sz2~=size(mat2,2))
    error('the two input matrices are not of equal size');
end
coef=zeros(sz1,sz2);
for j1 = 1 : sz1
    for j2 = 1 : sz2
        v1=mat1(j1,j2,:);
        v2=mat2(j1,j2,:);
        if(any(isnan(v1+v2)))
            coef(j1,j2)=0./0.;
        else
            coef(j1,j2)=corr_coefv(v1,v2);
        end
    end
end
end