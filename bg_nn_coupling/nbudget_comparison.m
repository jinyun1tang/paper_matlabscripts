close all;
clear all;
clc;
%This draws figure 4.
addpath(genpath('~/work/github_rep/matlab_tools/'));

mother_dir='/Users/jinyuntang/work/data_collection/clm_output/bg_nn_coupling';
sub_dirs={...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3adt.2016-04-30',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3.2016-04-30',...
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3adt.2016-05-09',...
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3.2016-05-09',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3_cent.2016-05-03',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3_clm.2016-05-03',...    
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3_cent.2016-05-10',...
    'CLM_USRDAT.IRCP45CLM45BGC.lawrencium-lr3.intel.5656685.bclm3_clm.2016-05-10'};


%fig=figure;
%set(fig,'unit','normalized','position',[.1,.1,.6,.9]);

sims={'clm3adt','clm3','cent','clm'};
%ax = multipanel(fig,2,2,[.1,.1],[.4,.4],[.075,.05]);
    

cc={'m','r','g','b'};
is_load=1;
if(is_load)
    load('nflxes.mat');
else
year=[1850,2000];

j=1;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[ndep11,nfix11,f_nit_n2o11,f_den11,fno3_hydro11_leach,fno3_hydro11_srun,nfire11,nprod11,f_nit11]=getNbudget(indir,stem,year);

fno3_hydro11=fno3_hydro11_leach+fno3_hydro11_srun;

j=2;    
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[ndep21,nfix21,f_nit_n2o21,f_den21,fno3_hydro21_leach,fno3_hydro21_srun,nfire21,nprod21,f_nit21]=getNbudget(indir,stem,year);
fno3_hydro21=fno3_hydro21_leach+fno3_hydro21_srun;


j=5;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[ndep31,nfix31,f_nit_n2o31,f_den31,fno3_hydro31_leach,fno3_hydro31_srun,nfire31,nprod31,f_nit31]=getNbudget(indir,stem,year);
fno3_hydro31=fno3_hydro31_leach+fno3_hydro31_srun;


j=6;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[ndep41,nfix41,f_nit_n2o41,f_den41,fno3_hydro41_leach,fno3_hydro41_srun,nfire41,nprod41,f_nit41]=getNbudget(indir,stem,year);
fno3_hydro41=fno3_hydro41_leach+fno3_hydro41_srun;


year=[2001,2300];

j=3;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[ndep12,nfix12,f_nit_n2o12,f_den12,fno3_hydro12_leach,fno3_hydro12_srun,nfire12,nprod12,f_nit12]=getNbudget(indir,stem,year);
fno3_hydro12=fno3_hydro12_leach+fno3_hydro12_srun;

j=4;    
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});   
stem=get_stem_filename(indir);    
[ndep22,nfix22,f_nit_n2o22,f_den22,fno3_hydro22_leach,fno3_hydro22_srun,nfire22,nprod22,f_nit22]=getNbudget(indir,stem,year);
fno3_hydro22=fno3_hydro22_leach+fno3_hydro22_srun;

j=7;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[ndep32,nfix32,f_nit_n2o32,f_den32,fno3_hydro32_leach,fno3_hydro32_srun,nfire32,nprod32,f_nit32]=getNbudget(indir,stem,year);
fno3_hydro32=fno3_hydro32_leach+fno3_hydro32_srun;

j=8;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[ndep42,nfix42,f_nit_n2o42,f_den42,fno3_hydro42_leach,fno3_hydro42_srun,nfire42,nprod42,f_nit42]=getNbudget(indir,stem,year);
fno3_hydro42=fno3_hydro42_leach+fno3_hydro42_srun;


save('nflxes.mat','ndep11','nfix11','f_nit_n2o11','f_den11','fno3_hydro11','nfire11','nprod11','fno3_hydro11_leach','fno3_hydro11_srun','f_nit11',...
'ndep21','nfix21','f_nit_n2o21','f_den21','fno3_hydro21','nfire21','nprod21','fno3_hydro21_leach','fno3_hydro21_srun','f_nit21',...
'ndep31','nfix31','f_nit_n2o31','f_den31','fno3_hydro31','nfire31','nprod31','fno3_hydro31_leach','fno3_hydro31_srun','f_nit31',...
'ndep41','nfix41','f_nit_n2o41','f_den41','fno3_hydro41','nfire41','nprod41','fno3_hydro41_leach','fno3_hydro41_srun','f_nit41',...
'ndep12','nfix12','f_nit_n2o12','f_den12','fno3_hydro12','nfire12','nprod12','fno3_hydro12_leach','fno3_hydro12_srun','f_nit12',...
'ndep22','nfix22','f_nit_n2o22','f_den22','fno3_hydro22','nfire22','nprod22','fno3_hydro22_leach','fno3_hydro22_srun','f_nit22',...
'ndep32','nfix32','f_nit_n2o32','f_den32','fno3_hydro32','nfire32','nprod32','fno3_hydro32_leach','fno3_hydro32_srun','f_nit32',...
'ndep42','nfix42','f_nit_n2o42','f_den42','fno3_hydro42','nfire42','nprod42','fno3_hydro42_leach','fno3_hydro42_srun','f_nit42')
end

tyear=3600*24*365;
%print statistics to screen
fprintf('1850-2000\n');
fprintf('%s\n',sims{1});
fprintf('ndep        :%.6f,%.6f,%.6f,%.6f\n',mean(ndep11,1).*tyear);
fprintf('nfix        :%.6f,%.6f,%.6f,%.6f\n',mean(nfix11,1).*tyear);
fprintf('n2o_nit     :%.6f,%.6f,%.6f,%.6f\n',mean(f_nit_n2o11,1).*tyear);
fprintf('f_den11     :%.6f,%.6f,%.6f,%.6f\n',mean(f_den11,1).*tyear);
fprintf('fno3_hydro11:%.6f,%.6f,%.6f,%.6f\n',mean(fno3_hydro11,1).*tyear);
fprintf('nfire11     :%.6f,%.6f,%.6f,%.6f\n',mean(nfire11,1).*tyear);
fprintf('%s\n',sims{2});
fprintf('ndep        :%.6f,%.6f,%.6f,%.6f\n',mean(ndep21,1).*tyear);
fprintf('nfix        :%.6f,%.6f,%.6f,%.6f\n',mean(nfix21,1).*tyear);
fprintf('n2o_nit     :%.6f,%.6f,%.6f,%.6f\n',mean(f_nit_n2o21,1).*tyear);
fprintf('f_den11     :%.6f,%.6f,%.6f,%.6f\n',mean(f_den21,1).*tyear);
fprintf('fno3_hydro11:%.6f,%.6f,%.6f,%.6f\n',mean(fno3_hydro21,1).*tyear);
fprintf('nfire11     :%.6f,%.6f,%.6f,%.6f\n',mean(nfire21,1).*tyear);
fprintf('%s\n',sims{3});
fprintf('ndep        :%.6f,%.6f,%.6f,%.6f\n',mean(ndep31,1).*tyear);
fprintf('nfix        :%.6f,%.6f,%.6f,%.6f\n',mean(nfix31,1).*tyear);
fprintf('n2o_nit     :%.6f,%.6f,%.6f,%.6f\n',mean(f_nit_n2o31,1).*tyear);
fprintf('f_den11     :%.6f,%.6f,%.6f,%.6f\n',mean(f_den31,1).*tyear);
fprintf('fno3_hydro11:%.6f,%.6f,%.6f,%.6f\n',mean(fno3_hydro31,1).*tyear);
fprintf('nfire11     :%.6f,%.6f,%.6f,%.6f\n',mean(nfire31,1).*tyear);
fprintf('%s\n',sims{4});
fprintf('ndep        :%.6f,%.6f,%.6f,%.6f\n',mean(ndep41,1).*tyear);
fprintf('nfix        :%.6f,%.6f,%.6f,%.6f\n',mean(nfix41,1).*tyear);
fprintf('n2o_nit     :%.6f,%.6f,%.6f,%.6f\n',mean(f_nit_n2o41,1).*tyear);
fprintf('f_den11     :%.6f,%.6f,%.6f,%.6f\n',mean(f_den41,1).*tyear);
fprintf('fno3_hydro11:%.6f,%.6f,%.6f,%.6f\n',mean(fno3_hydro41,1).*tyear);
fprintf('nfire11     :%.6f,%.6f,%.6f,%.6f\n',mean(nfire41,1).*tyear);
fprintf('2001-2300\n');
fprintf('%s\n',sims{1});
fprintf('ndep        :%.6f,%.6f,%.6f,%.6f\n',mean(ndep12,1).*tyear);
fprintf('nfix        :%.6f,%.6f,%.6f,%.6f\n',mean(nfix12,1).*tyear);
fprintf('n2o_nit     :%.6f,%.6f,%.6f,%.6f\n',mean(f_nit_n2o12,1).*tyear);
fprintf('f_den11     :%.6f,%.6f,%.6f,%.6f\n',mean(f_den12,1).*tyear);
fprintf('fno3_hydro11:%.6f,%.6f,%.6f,%.6f\n',mean(fno3_hydro12,1).*tyear);
fprintf('nfire11     :%.6f,%.6f,%.6f,%.6f\n',mean(nfire12,1).*tyear);
fprintf('%s\n',sims{2});
fprintf('ndep        :%.6f,%.6f,%.6f,%.6f\n',mean(ndep22,1).*tyear);
fprintf('nfix        :%.6f,%.6f,%.6f,%.6f\n',mean(nfix22,1).*tyear);
fprintf('n2o_nit     :%.6f,%.6f,%.6f,%.6f\n',mean(f_nit_n2o22,1).*tyear);
fprintf('f_den11     :%.6f,%.6f,%.6f,%.6f\n',mean(f_den22,1).*tyear);
fprintf('fno3_hydro11:%.6f,%.6f,%.6f,%.6f\n',mean(fno3_hydro22,1).*tyear);
fprintf('nfire11     :%.6f,%.6f,%.6f,%.6f\n',mean(nfire22,1).*tyear);
fprintf('%s\n',sims{3});
fprintf('ndep        :%.6f,%.6f,%.6f,%.6f\n',mean(ndep32,1).*tyear);
fprintf('nfix        :%.6f,%.6f,%.6f,%.6f\n',mean(nfix32,1).*tyear);
fprintf('n2o_nit     :%.6f,%.6f,%.6f,%.6f\n',mean(f_nit_n2o32,1).*tyear);
fprintf('f_den11     :%.6f,%.6f,%.6f,%.6f\n',mean(f_den32,1).*tyear);
fprintf('fno3_hydro11:%.6f,%.6f,%.6f,%.6f\n',mean(fno3_hydro32,1).*tyear);
fprintf('nfire11     :%.6f,%.6f,%.6f,%.6f\n',mean(nfire32,1).*tyear);
fprintf('%s\n',sims{4});
fprintf('ndep        :%.6f,%.6f,%.6f,%.6f\n',mean(ndep42,1).*tyear);
fprintf('nfix        :%.6f,%.6f,%.6f,%.6f\n',mean(nfix42,1).*tyear);
fprintf('n2o_nit     :%.6f,%.6f,%.6f,%.6f\n',mean(f_nit_n2o42,1).*tyear);
fprintf('f_den11     :%.6f,%.6f,%.6f,%.6f\n',mean(f_den42,1).*tyear);
fprintf('fno3_hydro11:%.6f,%.6f,%.6f,%.6f\n',mean(fno3_hydro42,1).*tyear);
fprintf('nfire11     :%.6f,%.6f,%.6f,%.6f\n',mean(nfire42,1).*tyear);
%


fig=figure;
set(fig,'unit','normalized','position',[.1,.1,.8,.92]);
ax = multipanel(fig,4,4,[.075,.05],[.18,.185],[.05,.065]);
for jj = 1 : 4
    set(fig,'CurrentAxes',ax(jj));    
    hh(1)=plot((1850:2000),f_nit11(:,jj).*tyear,cc{1},'LineWidth',1.5);      
    hold on;
    hh(2)=plot((1850:2000),f_nit21(:,jj).*tyear,cc{2},'LineWidth',1.5);      
    hh(3)=plot((1850:2000),f_nit31(:,jj).*tyear,cc{3},'LineWidth',1.5);      
    hh(4)=plot((1850:2000),f_nit41(:,jj).*tyear,cc{4},'LineWidth',1.5);

    set(fig,'CurrentAxes',ax(jj+4));
    plot((1850:2000),f_nit_n2o11(:,jj).*tyear,cc{1},'LineWidth',1.5);      
    hold on;
    plot((1850:2000),f_nit_n2o21(:,jj).*tyear,cc{2},'LineWidth',1.5);      
    plot((1850:2000),f_nit_n2o31(:,jj).*tyear,cc{3},'LineWidth',1.5);      
    plot((1850:2000),f_nit_n2o41(:,jj).*tyear,cc{4},'LineWidth',1.5);
    
    set(fig,'CurrentAxes',ax(jj+8));      
    plot((1850:2000),(f_den11(:,jj)+f_nit_n2o11(:,jj)).*tyear,cc{1},'LineWidth',1.5);    
    hold on;
    plot((1850:2000),(f_den21(:,jj)+f_nit_n2o21(:,jj)).*tyear,cc{2},'LineWidth',1.5);    
    plot((1850:2000),(f_den31(:,jj)+f_nit_n2o31(:,jj)).*tyear,cc{3},'LineWidth',1.5);    
    plot((1850:2000),(f_den41(:,jj)+f_nit_n2o41(:,jj)).*tyear,cc{4},'LineWidth',1.5);    

    id=find(fno3_hydro11(:,jj)<0);
    if(~isempty(id))
        fno3_hydro11(id,jj)=0.;        
    end;
    id=find(fno3_hydro21(:,jj)<0);
    if(~isempty(id))
        fno3_hydro21(id,jj)=0.;
    end
    id=find(fno3_hydro31(:,jj)<0);
    if(~isempty(id))
        fno3_hydro31(id,jj)=0.;
    end
    id=find(fno3_hydro41(:,jj)<0);
    if(~isempty(id))
        fno3_hydro41(id,jj)=0.;
    end
    set(fig,'CurrentAxes',ax(jj+12));       
    plot((1850:2000),fno3_hydro11(:,jj).*tyear,cc{1},'LineWidth',1.5);      
    hold on;
    plot((1850:2000),fno3_hydro21(:,jj).*tyear,cc{2},'LineWidth',1.5);      
    plot((1850:2000),fno3_hydro31(:,jj).*tyear,cc{3},'LineWidth',1.5);      
    plot((1850:2000),fno3_hydro41(:,jj).*tyear,cc{4},'LineWidth',1.5);      
              
end
set(ax,'FontSize',14);
set(ax(1:12),'XTickLabel','');
set(fig,'CurrentAxes',ax(1));
ylabel('Nitrification (gN m^-^2yr^-^1)'); 
set(fig,'CurrentAxes',ax(5));
ylabel('Aerobic N_2O (gN m^-^2yr^-^1)'); 
set(fig,'CurrentAxes',ax(9));
ylabel('Denitrification (gN m^-^2yr^-^1)'); 
set(fig,'CurrentAxes',ax(13));
ylabel('Hydro loss (gN m^-^2yr^-^1)'); 

for jj = 13:16
    set(fig,'CurrentAxes',ax(jj));
    xlabel('Year');
end
sites={'(a1)','(b1)','(c1)','(d1)',...
    '(a2)','(b2)','(c2)','(d2)',...
    '(a3)','(b3)','(c3)','(d3)',...
    '(a4)','(b4)','(c4)','(d4)'};
for jj = 1 : 16
    put_tag(fig,ax(jj),[.025,.93],sites{jj},14);
end

legend(hh(4:-1:1),'MNL','NUL','PNL','PNL-adapt');
set(fig,'Color','w');
return;
%derive the fraction of runoff
frac11=fno3_hydro11_srun./fno3_hydro11;
id=find(frac11>1);
if(~isempty(id));
    frac11(id)=1.;
end
frac21=fno3_hydro21_srun./fno3_hydro21;
id=find(frac21>1);
if(~isempty(id));
    frac21(id)=1.;
end
frac31=fno3_hydro31_srun./fno3_hydro31;
id=find(frac31>1);
if(~isempty(id));
    frac31(id)=1.;
end
frac41=fno3_hydro41_srun./fno3_hydro41;
id=find(frac41>1);
if(~isempty(id));
    frac41(id)=1.;
end
frac12=fno3_hydro12_srun./fno3_hydro12;
id=find(frac12>1);
if(~isempty(id));
    frac12(id)=1.;
end
frac22=fno3_hydro22_srun./fno3_hydro22;
id=find(frac22>1);
if(~isempty(id));
    frac22(id)=1.;
end
frac32=fno3_hydro32_srun./fno3_hydro32;
id=find(frac32>1);
if(~isempty(id));
    frac32(id)=1.;
end
frac42=fno3_hydro42_srun./fno3_hydro42;
id=find(frac42>1);
if(~isempty(id));
    frac42(id)=1.;
end
fig1=figure;
set(fig1,'unit','normalized','position',[.1,.1,.8,.82]);
ax1 = multipanel(fig1,2,2,[.075,.075],[.4,.4],[.05,.05]);

for jj = 1 : 4
    set(fig1,'CurrentAxes',ax1(jj));
    plot((1850:2000),frac11,cc{1});
    hold on;
    plot((1850:2000),frac21,cc{2});
    plot((1850:2000),frac31,cc{3});
    plot((1850:2000),frac41,cc{4});    
end