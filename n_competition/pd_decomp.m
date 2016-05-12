function [p,d]=pd_decomp(cascade)
%return positive and negative entries of the cascade matrix

p=(cascade>0);

d=(cascade<0);

end