function [lh_season_mean,lh_season_std]=multiyear_mean_season(lh_subset)
%get the multiyear seasonal mean cycle

sz1=size(lh_subset,1);
sz2=size(lh_subset,2);
sz3=size(lh_subset,3);

nyears=fix(sz3/12);
lh_season_mean=zeros(sz1,sz2,4);
if(nargin==2)
    lh_season_std=zeros(sz1,sz2,4);
end
%winter 12 1  2
%spring 3  4  5
%summer 6  7  8
%fall   9  10 11
ids=[3,4,5;6,7,8;9,10,11;12,1,2];
days=[31,30,31;30,31,31;30,31,30;31,31,28];
%caculate the weighting factor
for k1 = 1 : 4
    days(k1,:)=days(k1,:)./sum(days(k1,:),2);
end
for j1 = 1 : sz1
    for j2 = 1 : sz2
        dat=squeeze(lh_subset(j1,j2,:));
        dat_reshape=reshape(dat,[12,nyears]);
        if(~any(isnan(dat_reshape)))       
            for k = 1 : 4
                dat_ts=squeeze(dat_reshape(ids(k,:),:));
                for k1 = 1 : 3
                    dat_ts(k1,:)=dat_ts(k1,:).*days(k,k1);
                end
                dat_ts_mean=sum(dat_ts,1);
                lh_season_mean(j1,j2,k)=mean(dat_ts_mean);   
                if(nargout==2)                
                    lh_season_std(j1,j2,k)=std(dat_ts_mean,0,2); 
                end
            end
        else
            lh_season_mean(j1,j2,:)=0./0.;
            if(nargout==2)            
                lh_season_std(j1,j2,:)=0./0.;
            end
        end
    end
end
end