function parstd=get_parstd_comp(ParSet)
%
%get standard deviation of the parameters for the sDEB model

parstd.umax=prctile(ParSet(:,1),[2.5,97.5]);
parstd.mq=prctile(ParSet(:,2),[2.5,97.5]);
parstd.KS=prctile(ParSet(:,3),[2.5,97.5]);
parstd.gmm=prctile(ParSet(:,4),[2.5,97.5]);
parstd.YG=prctile(ParSet(:,5),[2.5,97.5]);


end