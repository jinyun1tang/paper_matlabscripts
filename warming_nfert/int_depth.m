function [yout,zdep]=int_depth(yin,ndim,nlay)
dzsoi=[  0.01751282,  0.02757897,  0.04547003,  0.07496741,  0.1236004,  ...
    0.2037826,  0.3359806, 0.5539384,  0.91329,  1.505761,  2.48258,...
    4.093082,  6.748351,  11.12615,  13.85115 ;]';

len=length(size(yin));
if(ndim>len)
    error('wrong dimension is specified');
    yout=[];
end
zdep=sum(dzsoi(1:nlay));
switch (len)
    case 1
        %return a scalar
        if(ndim~=1)
            error('wrong dimension is specified');
            yout=[];
        else
            yout=sum(yin(1:nlay).*dzsoi(1:nlay));
        end
    case 2
        if(ndim==1)
            yout=yin(1:nlay,:)'*dzsoi(1:nlay);
        else
            yout=yin(:,1:nlay)*dzsoi(1:nlay);
        end
    case 3
        sz=size(yin);
        switch (ndim)
            case 1
                yout=zeros(sz(2),sz(3));
                for k = 1 : sz(3)
                    yout(:,k)=squeeze(yin(1:nlay,:,k))'*dzsoi(1:nlay);
                end
            case 2
                yout=zeros(sz(1),sz(3));
                for k = 1 : sz(3)
                    yout(:,k)=squeeze(yin(:,1:nlay,k))*dzsoi(1:nlay);
                end
            case 3
                yout=zeros(sz(1),sz(2));
                for k1 = 1 : sz(1)
                    for k2 = 1 : sz(2)
                        yout(sz(1),sz(2))=sum(yin(k1,k2,1:nlay).*dzsoi(1:nlay));
                    end
                end
        end
    case 4
        sz=size(yin);
        switch (ndim)
            case 1
                yout=zeros(sz(2),sz(3),sz(4));
                for k1 = 1 : sz(3)
                    for k2 = 1 : sz(4)
                        yout(:,k1,k2)=squeeze(yin(1:nlay,:,k1,k2))'*dzsoi(1:nlay);
                    end
                end
            case 2
                yout=zeros(sz(1),sz(3),sz(4));
                for k1 = 1 : sz(3)
                    for k2 = 1 : sz(4)
                        yout(:,k1,k2)=squeeze(yin(:,1:nlay,k1,k2))*dzsoi(1:nlay);
                    end
                end
            case 3
                yout=zeros(sz(1),sz(2),sz(4));                
                for k1 = 1 : sz(1)
                    for k2 = 1 : sz(2)
                        for k3 = 1 : sz(4)
                            yout(k1,k2,k3)=sum(squeeze(yin(k1,k2,1:nlay,k3)).*dzsoi(1:nlay));
                        end
                    end
                end 
            case 4
                yout=zeros(sz(1),sz(2),sz(3));
                for k1 = 1 : sz(1)
                    for k2 = 1 : sz(2)
                        for k3 = 1 : sz(3)
                            yout(k1,k2,k3)=sum(squeeze(yin(k1,k2,k3,1:nlay)).*dzsoi(1:nlay));
                        end
                    end
                end
                
        end
    case 5
         sz=size(yin);
        switch (ndim)
            case 1
                yout=zeros(sz(2),sz(3),sz(4),sz(5));
                for k1 = 1 : sz(3)
                    for k2 = 1 : sz(4)
                        for k3 = 1 : sz(5)
                            yout(:,k1,k2,k3)=squeeze(yin(1:nlay,:,k1,k2,k3))'*dzsoi(1:nlay);
                        end
                    end
                end
            case 2
                yout=zeros(sz(1),sz(3),sz(4),sz(5));
                for k1 = 1 : sz(3)
                    for k2 = 1 : sz(4)
                        for k3 = 1 : sz(5)
                            yout(:,k1,k2,k3)=squeeze(yin(:,1:nlay,k1,k2,k3))*dzsoi(1:nlay);
                        end
                    end
                end
            case 3
                yout=zeros(sz(1),sz(2),sz(4),sz(5));                
                for k1 = 1 : sz(1)
                    for k2 = 1 : sz(2)
                        for k3 = 1 : sz(4)
                            for k4 = 1 : sz(5)
                                yout(k1,k2,k3,k4)=sum(squeeze(yin(k1,k2,1:nlay,k3,k4)).*dzsoi(1:nlay));
                            end
                        end
                    end
                end 
            case 4
                yout=zeros(sz(1),sz(2),sz(3),sz(5));
                for k1 = 1 : sz(1)
                    for k2 = 1 : sz(2)
                        for k3 = 1 : sz(3)
                            for k4 = 1 : sz(5)
                                yout(k1,k2,k3,k4)=sum(squeeze(yin(k1,k2,k3,1:nlay,k4)).*dzsoi(1:nlay));
                            end
                        end
                    end
                end
            case 5
                yout=zeros(sz(1),sz(2),sz(3),sz(4));
                for k1 = 1 : sz(1)
                    for k2 = 1 : sz(2)
                        for k3 = 1 : sz(3)
                            for k4 = 1 : sz(4)
                                yout(k1,k2,k3,k4)=sum(squeeze(yin(k1,k2,k3,k4,1:nlay)).*dzsoi(1:nlay));
                            end
                        end
                    end
                end                               
        end       
    otherwise
        error('the dimension of input array is greater than 4');
        yout=[];
end
    
         
    
end