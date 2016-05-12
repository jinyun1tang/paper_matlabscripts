function ts=nfert_site_ts(varname,nlevl,iscent,iloc,jloc,nyr,active)

nsite=size(iloc,1);
l2=size(iloc,2);
ts=zeros(nsite,nyr*12,l2,2);

for k1 = 1 : nsite
    
    
    if(active(k1))
        if(iscent)
            for k2 = 1 : l2
                if(iloc(k1,k2)>0)
                    dat1 = nfert_siteextract_cent(varname,iloc(k1,k2),jloc(k1,k2),'ctl');
                    dat2 = nfert_siteextract_cent(varname,iloc(k1,k2),jloc(k1,k2),nlevl);        
           
                    ts(k1,:,k2,1)=dat1;
                    ts(k1,:,k2,2)=dat2;
                else
                    ts(k1,:,k2,1)=0./0.;
                    ts(k1,:,k2,2)=0./0.;
                end
            end
        else
            for k2 = 1 : l2
                if(iloc(k1,k2)>0)
                    dat1 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),'ctl');
                    dat2 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),nlevl); 
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
end