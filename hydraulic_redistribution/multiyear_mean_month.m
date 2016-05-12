function [lh_month_mean,lh_month_std]=multiyear_mean_month(lh_subset)
%get the multiyear seasonal mean cycle

sz1=size(lh_subset,1);
sz2=size(lh_subset,2);
sz3=size(lh_subset,3);

nyears=fix(sz3/12);
lh_month_mean=zeros(sz1,sz2,12);
lh_month_std=zeros(sz1,sz2,12);

for j1 = 1 : sz1
    for j2 = 1 : sz2
        dat=squeeze(lh_subset(j1,j2,:));
        dat_reshape=reshape(dat,[12,nyears]);
        if(~any(isnan(dat_reshape)))       

            lh_month_mean(j1,j2,:)=mean(dat_reshape,2);
            lh_month_std(j1,j2,:)=std(dat_reshape,[],2);

        else
            lh_month_mean(j1,j2,:)=0./0.;
            lh_month_std(j1,j2,:)=0./0.;
        end
    end
end
end