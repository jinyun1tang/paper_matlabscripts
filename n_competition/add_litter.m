function yout=add_litter(yin, vid)
%add litter input

amount=1d-1;
yout=yin;
yout(vid.lit1)=yin(vid.lit1)+0.4*amount;
yout(vid.lit2)=yin(vid.lit2)+0.4*amount;
yout(vid.lit3)=yin(vid.lit3)+0.2*amount;



end

