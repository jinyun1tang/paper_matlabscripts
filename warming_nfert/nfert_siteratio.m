function ratio=nfert_siteratio(varname,nlevl,iscent,iloc,jloc,nyr,ntype)

nsite=length(iloc);
ratio=zeros(nsite,nyr*12);

for k1 = 1 : nsite
    if(iloc(k1,2)==0)
        if(jloc(k1,2)==0)
            %one point
            if(iscent)
                dat1 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,1),'ctl');
                dat2 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,1),nlevl);
            else
                dat1 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),'ctl');
                dat2 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),nlevl);  
            end
            if(strcmp(ntype,'ratio'))            
                ratio(k1,:)=dat2./(dat1+eps);
            else
                ratio(k1,:)=dat2-dat1;
            end
        else
            %two points
            if(iscent)
                dat11 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,1),'ctl');
                dat12 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,2),'ctl');                
                dat21 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,1),nlevl);
                dat22 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,2),nlevl);
                
            else
                dat11 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),'ctl');
                dat12 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,2),'ctl');                
                dat21 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),nlevl);
                dat22 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,2),nlevl); 
            end        
            if(strcmp(ntype,'ratio'))               
                ratio(k1,:)=(dat21+dat22)./(dat11+dat12+eps);
            else
                ratio(k1,:)=(dat21+dat22-dat11-dat12)./2;
            end
        end
    else
        if(jloc(k1,2)==0)
            %2 points
            if(iscent)
                dat11 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,1),'ctl');
                dat12 = nfert_siteextract_cent(varname,iloc(k1,2),jloc(k1,1),'ctl');                
                dat21 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,1),nlevl);
                dat22 = nfert_siteextract_cent(varname,iloc(k1,2),jloc(k1,1),nlevl);                
            else
                dat11 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),'ctl');
                dat12 = nfert_siteextract_cn(varname,iloc(k1,2),jloc(k1,1),'ctl');                
                dat21 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),nlevl);
                dat22 = nfert_siteextract_cn(varname,iloc(k1,2),jloc(k1,1),nlevl); 
            end            
            if(strcmp(ntype,'ratio'))               
                ratio(k1,:)=(dat21+dat22)./(dat11+dat12+eps);
            else
                ratio(k1,:)=(dat21+dat22-dat11-dat12)./2;
            end
            
        else
            %four points
            if(iscent)
                dat11 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,1),'ctl');
                dat12 = nfert_siteextract_cent(varname,iloc(k1,2),jloc(k1,1),'ctl');    
                dat13 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,2),'ctl');
                dat14 = nfert_siteextract_cent(varname,iloc(k1,2),jloc(k1,2),'ctl');                  
                dat21 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,1),nlevl);
                dat22 = nfert_siteextract_cent(varname,iloc(k1,2),jloc(k1,1),nlevl);              
                dat23 = nfert_siteextract_cent(varname,iloc(k1,1),jloc(k1,2),nlevl);
                dat24 = nfert_siteextract_cent(varname,iloc(k1,2),jloc(k1,2),nlevl);                  
            else
                dat11 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),'ctl');
                dat12 = nfert_siteextract_cn(varname,iloc(k1,2),jloc(k1,1),'ctl');    
                dat13 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,2),'ctl');
                dat14 = nfert_siteextract_cn(varname,iloc(k1,2),jloc(k1,2),'ctl');                  
                dat21 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,1),nlevl);
                dat22 = nfert_siteextract_cn(varname,iloc(k1,2),jloc(k1,1),nlevl);              
                dat23 = nfert_siteextract_cn(varname,iloc(k1,1),jloc(k1,2),nlevl);
                dat24 = nfert_siteextract_cn(varname,iloc(k1,2),jloc(k1,2),nlevl);  
            end            
            if(strcmp(ntype,'ratio'))               
                ratio(k1,:)=(dat21+dat22+dat23+dat24)./(dat11+dat12+dat13+dat14+eps);
            else
                ratio(k1,:)=(dat21+dat22+dat23+dat24-dat11-dat12-dat13-dat14)./4;
            end
        end
    end
end
end