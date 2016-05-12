function coef=corr_coefv(x1,x2)
%compute the correlation coefficient for given two vectors

anormal_x1=x1-mean(x1);
anormal_x2=x2-mean(x2);

%compute the inner production

numerator=sum(anormal_x1.*anormal_x2);
mod1=sqrt(sum(anormal_x1.*anormal_x1));
mod2=sqrt(sum(anormal_x2.*anormal_x2));
coef=numerator/(mod1*mod2);
end