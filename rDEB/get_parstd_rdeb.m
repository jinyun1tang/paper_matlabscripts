function parstd=get_parstd_rdeb(ParSet,parrdeb)
%get parameter standard deviation for the rDEB model

parstd.YRV=prctile(ParSet(:,1),[2.5,97.5]);
parstd.YRN=prctile(ParSet(:,2),[2.5,97.5]);
parstd.YSR=prctile(ParSet(:,3),[2.5,97.5]);
parstd.fN =prctile(ParSet(:,4),[2.5,97.5]);
parstd.KS =prctile(ParSet(:,5),[2.5,97.5]);
parstd.amax=prctile(ParSet(:,6).*ParSet(:,3),[2.5,97.5]);
parstd.mV =prctile(ParSet(:,7),[2.5,97.5]);
parstd.kapmax=prctile(ParSet(:,8),[2.5,97.5]);
parstd.gmm=prctile(ParSet(:,9),[2.5,97.5]);
parstd.tauN=prctile(ParSet(:,12),[2.5,97.5]);

parrdeb.KR0=4.7e-13*12./3600*(1-parrdeb.phiV)/parrdeb.phiV.*parstd.kapmax;
end

