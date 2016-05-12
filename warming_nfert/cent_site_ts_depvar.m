function ts=cent_site_ts_depvar(varname,iloc,jloc,nyr,ntype,active,avg)
if(nargin==6)
    avg=0;
end
nsite=size(iloc,1);
l2=size(iloc,2);
ts=zeros(nsite,nyr*12,l2,2);

[dat10,zdep]=cent_siteextract_depvar(varname,'ctl');
[dat20,zdep]=cent_siteextract_depvar(varname,ntype);

for k1 = 1 : nsite
        
    if(active(k1))
        for k2 = 1 : l2
            if(iloc(k1,k2)>0)
                dat1 = dat10(iloc(k1,k2),jloc(k1,k2),:);
                dat2 = dat20(iloc(k1,k2),jloc(k1,k2),:);   
                if(avg)
                    dat1=dat1./zdep;
                    dat2=dat2./zdep;
                end
           
                ts(k1,:,k2,1)=dat1;
                ts(k1,:,k2,2)=dat2;
            else
                ts(k1,:,k2,1)=0./0.;
                ts(k1,:,k2,2)=0./0.;
            end
        end
    end    
end
end