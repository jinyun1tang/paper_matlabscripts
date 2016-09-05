function tdays=get_tdays(year1, year2)
%get number of days for each month
%no leap year is used at the moment;

daz=[31,28,31,30,31,30,31,31,30,31,30,31];

tdays=zeros((year2-year1+1)*12,1);


for year = year1 : year2
    
    j0=(year-year1)*12;
    for mon = 1 : 12
        j=j0+mon;
        tdays(j)=daz(mon);
    end
end



end