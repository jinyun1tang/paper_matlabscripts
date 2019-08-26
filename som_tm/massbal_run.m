function [dxdt,errC]=massbal_run(t,x,extra)
%return mass balance error of carbon


dxdt=resom_tm(t,x,extra);
vid=extra.vid;
errC=dxdt(vid.somP)+dxdt(vid.somD)+dxdt(vid.co2)+...
    dxdt(vid.micBX)+dxdt(vid.micBV)+dxdt(vid.exoE);
errC=errC-(extra.I_somP+extra.I_somD)/12;
end