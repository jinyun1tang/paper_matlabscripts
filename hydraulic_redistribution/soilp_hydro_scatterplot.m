close all;
clear all;
clc;
%compare soil hydraulic properties of the topsoil


mdir='/Users/jinyuntang/work/data_collection/clm_output/hd_model/global_sim/';

ncf1=[mdir,'def_soihydp.nc'];
ncf2=[mdir,'cosby4_soihydp.nc'];
ncf3=[mdir,'noilhan_soihydp.nc'];
ncf_map=[mdir,'area_info.nc'];

ax=zeros(8,1);
ws=zeros(8,7);
fig=figure(1);
for jj = 1 : 8
    ax(jj)=subplot(4,2,jj);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varname='WATSAT';
bsw1=netcdf(ncf1,'var',varname);
bsw2=netcdf(ncf2,'var',varname);
bsw3=netcdf(ncf3,'var',varname);
id=find(abs(bsw1)<1d10);

set(fig,'CurrentAxes',ax(1));

plot(bsw1(id),bsw2(id),'.');
w=linearfit(bsw1(id),bsw2(id));
hold on;
plot(bsw1(id),w(1).*bsw1(id)+w(3),'r');
ws(1,:)=w;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(fig,'CurrentAxes',ax(2));
plot(bsw1(id),bsw3(id),'.');
w=linearfit(bsw1(id),bsw3(id));
hold on;
plot(bsw1(id),w(1).*bsw1(id)+w(3),'r');
ws(2,:)=w;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varname='BSW';

bsw1=netcdf(ncf1,'var',varname);
bsw2=netcdf(ncf2,'var',varname);
bsw3=netcdf(ncf3,'var',varname);
id=find(abs(bsw1)<1d10);
set(fig,'CurrentAxes',ax(3));

plot(bsw1(id),bsw2(id),'.');
w=linearfit(bsw1(id),bsw2(id));
hold on;
plot(bsw1(id),w(1).*bsw1(id)+w(3),'r');

ws(3,:)=w;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(fig,'CurrentAxes',ax(4));

plot(bsw1(id),bsw3(id),'.');
w=linearfit(bsw1(id),bsw3(id));
hold on;
plot(bsw1(id),w(1).*bsw1(id)+w(3),'r');

ws(4,:)=w;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varname='HKSAT';
bsw1=netcdf(ncf1,'var',varname);
bsw2=netcdf(ncf2,'var',varname);
bsw3=netcdf(ncf3,'var',varname);
id=find(abs(bsw1)<1d10);

set(fig,'CurrentAxes',ax(5));

plot(bsw1(id),bsw2(id),'.');
w=linearfit(bsw1(id),bsw2(id));
hold on;
plot(bsw1(id),w(1).*bsw1(id)+w(3),'r');

ws(5,:)=w;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(fig,'CurrentAxes',ax(6));

plot(bsw1(id),bsw3(id),'.');
w=linearfit(bsw1(id),bsw3(id));
hold on;
plot(bsw1(id),w(1).*bsw1(id)+w(3),'r');

ws(6,:)=w;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varname='SUCSAT';

bsw1=netcdf(ncf1,'var',varname);
bsw2=netcdf(ncf2,'var',varname);
bsw3=netcdf(ncf3,'var',varname);
id=find(abs(bsw1)<1d10);

set(fig,'CurrentAxes',ax(7));

plot(bsw1(id),bsw2(id),'.');
w=linearfit(bsw1(id),bsw2(id));
hold on;
plot(bsw1(id),w(1).*bsw1(id)+w(3),'r');
ws(7,:)=w;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(fig,'CurrentAxes',ax(8));

plot(bsw1(id),bsw3(id),'.');
w=linearfit(bsw1(id),bsw3(id));
hold on;
plot(bsw1(id),w(1).*bsw1(id)+w(3),'r');

ws(8,:)=w;
tags={'(a)\theta_s_a_t','(b)\theta_s_a_t','(c)b','(d)b','(e)K_s_a_t',...
    '(f)K_s_a_t','(g)\psi_s_a_t','(h)\psi_s_a_t'};
for jj = 1 : 8
    set(fig,'CurrentAxes',ax(jj));
    axis tight;
    if(ws(3)>0)
        cc='+';
    else
        cc='-';
    end
    put_tag(fig,ax(jj),[.025,.88],['y=',num2str(ws(jj,1),'%.2f'),'x',cc,...
        num2str(abs(ws(jj,3)),'%.2f'), ', R^2=',num2str(ws(jj,6),'%.2f')],12);
    set(ax(jj),'FontSize',14);
    put_tag(fig,ax(jj),[.75,0.1],tags{jj},14);
end