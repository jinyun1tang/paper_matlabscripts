function dat=get_var_nfiles(indir,stem,year,var)
%read variable var from a set of files

dat=[];    
tlen=(year(2)-year(1)+1)*12;
id=0;
for iyear=year(1) : year(2)
    for mon=1:12            
        fnm=sprintf('%s/%s.h0.%d-%2.2d.nc',indir,stem,iyear,mon); 
        dati=netcdf(fnm,'var',var);
        
        if(id==0)
            dat=zeros(tlen,size(dati,1),size(dati,2));
        end
        id=id+1;        
        dat(id,:,:)=dati;        
    end    
end

end

