function [sat,chb]=clapp_hornberg_par(pct_sand,pct_clay)
%[sat,chb]=clapp_hornberg_par(pct_sand,pct_clay)

chb=2.91+0.159*pct_clay;

sat=0.489-0.00126*pct_sand;


end