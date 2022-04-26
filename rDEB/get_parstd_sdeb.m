function parstd=get_parstd_sdeb(ParSet)
%
%get standard deviation of the parameters for the sDEB model


parstd.kap0=prctile(ParSet(:,1),[2.5,97.5]);
parstd.KS=prctile(ParSet(:,2),[2.5,97.5]);
parstd.amax=prctile(ParSet(:,3).*ParSet(:,5),[2.5,97.5]);
parstd.YRV=prctile(ParSet(:,4),[2.5,97.5]);
parstd.YSR=prctile(ParSet(:,5),[2.5,97.5]);
parstd.mV=prctile(ParSet(:,6),[2.5,97.5]);
parstd.gmm=prctile(ParSet(:,7),[2.5,97.5]);


end