function ps=minp(p,v)
%find the minimum of the nonzero p entries, with the entry determined by
%nonzero values of v
nelm=length(p);
if(nelm~=length(v))
    error('minp: sizes of p and v are not equal');
end

ps=1;

for j = 1 : nelm
    if(v(j)==1)
        ps=min(ps,p(j));
    end
end


end