function [taug,tauw]=moldrup_tau(por,epsi,theta,kappa)
%[taug,tauw]=moldrup_tau(por,epsi,theta,kappa)
%calculate tortuosity using Moldrup's(2003) equation 

taug=epsi.*(epsi./por).^(3./kappa);
tauw=theta.*theta.*(theta./por).^(kappa./3-1);

end