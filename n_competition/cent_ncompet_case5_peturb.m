close all;
clear all;
clc;
%case with nutrien limitation, but som provides nutrient through
%mineralization
irun=1;

icase=4;
opt=2;
Extra=cent_par(opt);

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
x(vid.minn)=1d-3;
x(vid.minp)=1d-7;
end


if(irun==0)
    tend=3000;


    tout11=zeros(tend+1,1);
    yout11=zeros(tend+1,vid.nvars);yout11(1,:)=x;
    
    tout21=tout11;
    yout21=yout11;
    
    tout31=tout11;
    yout31=yout11;
    
    tout41=tout11;
    yout41=yout11;
    
    tout51=tout11;
    yout51=yout11;
    
    Extra.dt=1;
    for it0=1:tend
        it=it0+1;
        Extra.method='';

        [t,yout11(it,:)]=ode_adpt_ebbks1(@sombgc_centclm,yout11(it0,:),Extra.dt,[0,Extra.dt],Extra);
        if(it0<=tend/2)        
            yout11(it,:)=add_litter(yout11(it,:),vid);
        end
        tout11(it) = tout11(it0) + Extra.dt;

        [t,yout21(it,:)]=ode_adpt_ebbks1(@sombgc_cent,yout21(it0,:),Extra.dt,[0,Extra.dt],Extra);
        if(it0<=tend/2)
            yout21(it,:)=add_litter(yout21(it,:),vid);
        end
        tout21(it)=tout21(it0)+Extra.dt;
        
        Extra.method='';
        [t,yout31(it,:)]=ode_adpt_ebbks1(@sombgc_centode,yout31(it0,:),Extra.dt,[0,Extra.dt],Extra);
        if(it0<=tend/2)
            yout31(it,:)=add_litter(yout31(it,:),vid);
        end
        tout31(it)=tout31(it0)+Extra.dt;
        
        Extra.method='';
        [t,yout41(it,:)]=ode_adpt_ebbks1(@sombgc_centclm_order12,yout41(it0,:),Extra.dt,[0,Extra.dt],Extra);
        
        tout41(it)=tout41(it0)+Extra.dt;
        if(it0<=tend/2)
            yout41(it,:)=add_litter(yout41(it,:),vid);
        end

        [t,yout51(it,:)]=ode_adpt_ebbks1(@sombgc_centclm_order21,yout51(it0,:),Extra.dt,[0,Extra.dt],Extra);
        
        tout51(it)=tout51(it0)+Extra.dt;
        if(it0<=tend/2)
            yout51(it,:)=add_litter(yout51(it,:),vid);
        end
        
    end

    save('cent_ncompet_case5_perturb.mat','tout11','yout11','tout21','yout21',...
        'tout31','yout31','tout41','yout41','tout51','yout51');
else
    load('cent_ncompet_case5_perturb.mat');
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

plot(tout31(1:20:3001),yout31((1:20:3001),vid.minn),'g--','LineWidth',2);
%plot(tout32,yout32(:,vid.minn),'g--','LineWidth',2);

plot(tout41(1:10:3001),yout41(1:10:3001,vid.minn),'co');

plot(tout51(1:20:3001),yout51((1:20:3001),vid.minn),'k.');

ax(2)=subplot(4,1,2);
plot(tout11,yout11(:,vid.minp),'LineWidth',2);
hold on;
%plot(tout12,yout12(:,vid.minp),'--','LineWidth',2);

plot(tout21(1:20:3001),yout21((1:20:3001),vid.minp),'r-','LineWidth',2);
%plot(tout22,yout22(:,vid.minp),'r--','LineWidth',2);

plot(tout31,yout31(:,vid.minp),'g--','LineWidth',2);
%plot(tout32,yout32(:,vid.minp),'g--','LineWidth',2);

plot(tout41(1:10:3001),yout41(1:10:3001,vid.minp),'co');

plot(tout51(1:20:3001),yout51((1:20:3001),vid.minp),'k.');

ax(3)=subplot(4,1,3);
plot(tout11,sum(yout11(:,vid.lits),2),'LineWidth',2);
hold on;
%plot(tout12,sum(yout12(:,vid.lits),2),'--','LineWidth',2);

plot(tout21(1:20:3001),sum(yout21((1:20:3001),vid.lits),2),'r.','LineWidth',2);
%plot(tout22,sum(yout22(:,vid.lits),2),'r--','LineWidth',2);

plot(tout31,sum(yout31(:,vid.lits),2),'g--','LineWidth',2);
%plot(tout32,sum(yout32(:,vid.lits),2),'g--','LineWidth',2);


plot(tout41(1:10:3001),sum(yout41(1:10:3001,vid.lits),2),'co');

plot(tout51(1:20:3001),sum(yout51((1:20:3001),vid.lits),2),'k.');


ax(4)=subplot(4,1,4);
plot(tout11,sum(yout11(:,vid.soms),2),'LineWidth',2);
hold on;
%plot(tout12,sum(yout12(:,vid.soms),2),'--','LineWidth',2);

plot(tout21(1:20:3001),sum(yout21((1:20:3001),vid.soms),2),'r.','LineWidth',2);
%plot(tout22,sum(yout22(:,vid.soms),2),'r--','LineWidth',2);
plot(tout31,sum(yout31(:,vid.soms),2),'g--','LineWidth',2);
%plot(tout32,sum(yout32(:,vid.soms),2),'g--','LineWidth',2);
plot(tout41(1:10:3001),sum(yout41(1:10:3001,vid.soms),2),'co');

plot(tout51(1:20:3001),sum(yout51((1:20:3001),vid.soms),2),'k.');

set(ax(1:3),'XTickLabel','');
set(ax,'FontSize',fontsz);

put_tag(fig,ax(1),[.01,.02],'(a) N_m_i_n',fontsz);
put_tag(fig,ax(2),[.01,.02],'(b) P_m_i_n',fontsz);
put_tag(fig,ax(3),[.01,.05],'(c) Litter carbon',fontsz);
put_tag(fig,ax(4),[.01,.1],'(d) SOM carbon',fontsz);

set(fig,'CurrentAxes',ax(1));ylabel('g N','Fontsize',fontsz);
legend('CLM-1','CLM-2','New','CLM-1NP','CLM-1PN','location','north','orientation','horizontal');

set(fig,'CurrentAxes',ax(2));ylabel('g P','Fontsize',fontsz);

set(fig,'CurrentAxes',ax(3));ylabel('g C','Fontsize',fontsz);

set(fig,'CurrentAxes',ax(4));ylabel('g C','Fontsize',fontsz);
xlabel('Ordinal day','FontSize',fontsz);
set(fig,'color','w');

fprintf('total initial N=%f, P=%f\n',sum(yout31(1,Extra.vid.ids)./Extra.par.rcn)+yout31(1,Extra.vid.minn),sum(yout31(1,Extra.vid.ids)./Extra.par.rcp)+yout31(1,Extra.vid.minp));
fprintf('CLM-1, total final N=%f, P=%f\n',sum(yout11(end,Extra.vid.ids)./Extra.par.rcn)+yout11(end,Extra.vid.minn),sum(yout11(end,Extra.vid.ids)./Extra.par.rcp)+yout11(end,Extra.vid.minp));
fprintf('CLM-2, total final N=%f, P=%f\n',sum(yout21(end,Extra.vid.ids)./Extra.par.rcn)+yout21(end,Extra.vid.minn),sum(yout11(end,Extra.vid.ids)./Extra.par.rcp)+yout21(end,Extra.vid.minp));
fprintf('New, total final N=%f, P=%f\n',sum(yout31(end,Extra.vid.ids)./Extra.par.rcn)+yout31(end,Extra.vid.minn),sum(yout11(end,Extra.vid.ids)./Extra.par.rcp)+yout31(end,Extra.vid.minp));
fprintf('CLM-1NP, total final N=%f, P=%f\n',sum(yout41(end,Extra.vid.ids)./Extra.par.rcn)+yout41(end,Extra.vid.minn),sum(yout41(end,Extra.vid.ids)./Extra.par.rcp)+yout41(end,Extra.vid.minp));
fprintf('CLM-1PN, total final N=%f, P=%f\n',sum(yout51(end,Extra.vid.ids)./Extra.par.rcn)+yout51(end,Extra.vid.minn),sum(yout51(end,Extra.vid.ids)./Extra.par.rcp)+yout51(end,Extra.vid.minp));


fig1=figure;
set(fig1,'unit','normalized','position',[.1,.1,0.6,.85]);
ax(1)=subplot(4,1,1);
plot(tout11,yout21(:,vid.minn)-yout11(:,vid.minn),'LineWidth',2);title('CLM-2 minus CLM-1','FontSize',fontsz);
ax(2)=subplot(4,1,2);
plot(tout11,yout21(:,vid.minp)-yout11(:,vid.minp),'LineWidth',2);
ax(3)=subplot(4,1,3);
plot(tout31,sum(yout21(:,vid.lits),2)-sum(yout11(:,vid.lits),2),'LineWidth',2);
ax(4)=subplot(4,1,4);
plot(tout31,sum(yout21(:,vid.soms),2)-sum(yout11(:,vid.soms),2),'LineWidth',2);

set(fig1,'CurrentAxes',ax(1));ylabel('g N','Fontsize',fontsz);

set(fig1,'CurrentAxes',ax(2));ylabel('g P','Fontsize',fontsz);

set(fig1,'CurrentAxes',ax(3));ylabel('g C','Fontsize',fontsz);

set(fig1,'CurrentAxes',ax(4));ylabel('g C','Fontsize',fontsz);

set(ax,'FontSize',fontsz);
xlabel('Ordinal day','FontSize',fontsz);
set(fig1,'color','w');

put_tag(fig1,ax(1),[.01,.02],'(a) \DeltaN_m_i_n',fontsz);
put_tag(fig1,ax(2),[.01,.02],'(b) \DeltaP_m_i_n',fontsz);
put_tag(fig1,ax(3),[.01,.05],'(c) \DeltaLitter carbon',fontsz);
put_tag(fig1,ax(4),[.01,.1],'(d) \DeltaSOM carbon',fontsz);
