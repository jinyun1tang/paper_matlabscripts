close all;
clear all;
clc;
%case with nutrien limitation, but som provides nutrient through
%mineralization
irun=0;

icase=4;

Extra=cent_par();

vid=Extra.vid;

x=zeros(vid.nvars,1);
x(vid.lit1)=10;
x(vid.lit2)=10;
x(vid.lit3)=10;
x(vid.cwd )=10;
x(vid.som1)=10;
x(vid.som2)=10;
x(vid.som3)=10;
switch icase
    case 1
x(vid.minn)=10d0;
x(vid.minp)=10d0;
    case 2
x(vid.minn)=1d-1;
x(vid.minp)=10d0;
    case 3

x(vid.minn)=10d0;
x(vid.minp)=1d-2;
    case 4
x(vid.minn)=1d-4;
x(vid.minp)=1d-8;
end


if(irun==0)
Extra.method='';
tend=86400*300;

options1 = odeset('RelTol',1e-4,'NonNegative',(1:9));
options = odeset('RelTol',1e-4);

Extra.dt=1800;
[tout11,yout11]=ode_adpt_mbbks1(@sombgc_centclm,x,Extra.dt,[0,tend],Extra);
tout11=tout11./86400;


Extra.dt=1800;
[tout21,yout21]=ode_adpt_mbbks1(@sombgc_cent,x,Extra.dt,[0,tend],Extra);
tout21=tout21./86400;

Extra.dt=1800;
Extra.method='screen';
[tout31,yout31]=ode_adpt_mbbks1(@sombgc_centode,x,Extra.dt,[0,tend],Extra);
tout31=tout31./86400;

Extra.dt=1800;
Extra.method='';
[tout41,yout41]=ode_adpt_mbbks1(@sombgc_centdef,x,Extra.dt,[0,tend],Extra);
tout41=tout41./86400;

[tout51,yout51]=ode_adpt_eulerf(@sombgc_cent,x,Extra.dt,[0,tend],Extra);
tout51=tout51./86400;

save('cent_ncompet_case4_eulerf.mat','tout11','yout11','tout21','yout21',...
    'tout31','yout31','tout41','yout41','tout51','yout51');
else
    load('cent_ncompet_case4_eulerf.mat');
end
%Extra.method='';
%Extra.dt=2*1800;
%[tout12,yout12]=ode_adpt_mbbks1(@sombgc_cent,x,Extra.dt,[0,tend],Extra);
%tout12=tout12./86400/365;

%[tout22,yout22]=ode_adpt_mbbks1(@sombgc_centclm,x,Extra.dt,[0,tend],Extra);
%tout22=tout22./86400/365;

%Extra.method='screen';
%[tout32,yout32]=ode_adpt_mbbks1(@sombgc_centode,x,Extra.dt,[0,tend],Extra);
%tout32=tout32./86400/365;
fontsz=14;
fig=figure(1);
set(fig,'unit','normalized','position',[.1,.1,0.6,.85]);
ax(1)=subplot(4,1,1);
plot(tout11,yout11(:,vid.minn),'LineWidth',2);
hold on;
%plot(tout12,yout12(:,vid.minn),'--','LineWidth',2);

plot(tout21,yout21(:,vid.minn),'r.','LineWidth',2);
%plot(tout22,yout22(:,vid.minn),'r--','LineWidth',2);

plot(tout31,yout31(:,vid.minn),'g--','LineWidth',2);
%plot(tout32,yout32(:,vid.minn),'g--','LineWidth',2);

plot(tout41,yout41(:,vid.minn),'c','LineWidth',2);

plot(tout51,yout51(:,vid.minn),'k.','LineWidth',2);

ax(2)=subplot(4,1,2);
plot(tout11,yout11(:,vid.minp),'LineWidth',2);
hold on;
%plot(tout12,yout12(:,vid.minp),'--','LineWidth',2);

plot(tout21,yout21(:,vid.minp),'r.','LineWidth',2);
%plot(tout22,yout22(:,vid.minp),'r--','LineWidth',2);

plot(tout31,yout31(:,vid.minp),'g--','LineWidth',2);
%plot(tout32,yout32(:,vid.minp),'g--','LineWidth',2);

plot(tout41,yout41(:,vid.minp),'c','LineWidth',2);

plot(tout51,yout51(:,vid.minp),'k.','LineWidth',2);

ax(3)=subplot(4,1,3);
plot(tout11,sum(yout11(:,vid.lits),2),'LineWidth',2);
hold on;
%plot(tout12,sum(yout12(:,vid.lits),2),'--','LineWidth',2);

plot(tout21,sum(yout21(:,vid.lits),2),'r.','LineWidth',2);
%plot(tout22,sum(yout22(:,vid.lits),2),'r--','LineWidth',2);

plot(tout31,sum(yout31(:,vid.lits),2),'g--','LineWidth',2);
%plot(tout32,sum(yout32(:,vid.lits),2),'g--','LineWidth',2);


plot(tout41,sum(yout41(:,vid.lits),2),'c','LineWidth',2);

plot(tout51,sum(yout51(:,vid.lits),2),'k.','LineWidth',2);


ax(4)=subplot(4,1,4);
plot(tout11,sum(yout11(:,vid.soms),2),'LineWidth',2);
hold on;
%plot(tout12,sum(yout12(:,vid.soms),2),'--','LineWidth',2);

plot(tout21,sum(yout21(:,vid.soms),2),'r.','LineWidth',2);
%plot(tout22,sum(yout22(:,vid.soms),2),'r--','LineWidth',2);
plot(tout31,sum(yout31(:,vid.soms),2),'g--','LineWidth',2);
%plot(tout32,sum(yout32(:,vid.soms),2),'g--','LineWidth',2);
plot(tout41,sum(yout41(:,vid.soms),2),'c','LineWidth',2);

plot(tout51,sum(yout51(:,vid.soms),2),'k.','LineWidth',2);

set(ax(1:3),'XTickLabel','');
set(ax,'FontSize',fontsz);

put_tag(fig,ax(1),[.01,.02],'(a) N_m_i_n',fontsz);
put_tag(fig,ax(2),[.01,.02],'(b) P_m_i_n',fontsz);
put_tag(fig,ax(3),[.01,.05],'(c) Litter carbon',fontsz);
put_tag(fig,ax(4),[.01,.1],'(d) SOM carbon',fontsz);

set(fig,'CurrentAxes',ax(1));ylabel('g N','Fontsize',fontsz);
legend('CLM-1','CLM-2','New','BBKS','Eulerf','location','north','orientation','horizontal');

set(fig,'CurrentAxes',ax(2));ylabel('g P','Fontsize',fontsz);

set(fig,'CurrentAxes',ax(3));ylabel('g C','Fontsize',fontsz);

set(fig,'CurrentAxes',ax(4));ylabel('g C','Fontsize',fontsz);
xlabel('Ordinal day','FontSize',fontsz);
set(fig,'color','w');

fprintf('total initial N=%f, P=%f\n',sum(yout31(1,Extra.vid.ids)./Extra.par.rcn)+yout31(1,Extra.vid.minn),sum(yout31(1,Extra.vid.ids)./Extra.par.rcp)+yout31(1,Extra.vid.minp));
fprintf('CLM-1, total final N=%f, P=%f\n',sum(yout11(end,Extra.vid.ids)./Extra.par.rcn)+yout11(end,Extra.vid.minn),sum(yout11(end,Extra.vid.ids)./Extra.par.rcp)+yout11(end,Extra.vid.minp));
fprintf('CLM-2, total final N=%f, P=%f\n',sum(yout21(end,Extra.vid.ids)./Extra.par.rcn)+yout21(end,Extra.vid.minn),sum(yout11(end,Extra.vid.ids)./Extra.par.rcp)+yout21(end,Extra.vid.minp));
fprintf('NEW, total final N=%f, P=%f\n',sum(yout31(end,Extra.vid.ids)./Extra.par.rcn)+yout31(end,Extra.vid.minn),sum(yout11(end,Extra.vid.ids)./Extra.par.rcp)+yout31(end,Extra.vid.minp));
fprintf('BBKS, total final N=%f, P=%f\n',sum(yout41(end,Extra.vid.ids)./Extra.par.rcn)+yout41(end,Extra.vid.minn),sum(yout41(end,Extra.vid.ids)./Extra.par.rcp)+yout41(end,Extra.vid.minp));
fprintf('Eulerf, total final N=%f, P=%f\n',sum(yout51(end,Extra.vid.ids)./Extra.par.rcn)+yout51(end,Extra.vid.minn),sum(yout51(end,Extra.vid.ids)./Extra.par.rcp)+yout51(end,Extra.vid.minp));

