close all;
clear all;
clc;
%
%this plots figure 3.
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


fig=figure;
set(fig,'unit','normalized','position',[.1,.1,.6,.9]);
ax = multipanel(fig,2,2,[.1,.1],[.4,.4],[.075,.065]);

year=[1850,2000];

linewd=2;
fontsz=28;
cc={'c','r','k','b'};
var='TOTCOLC';docum=0;
j=1;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat1=get_var_nfiles(indir,stem,year,var);

j=2;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat2=get_var_nfiles(indir,stem,year,var);

    
year=[2001,2300];

j=3;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat3=get_var_nfiles(indir,stem,year,var);
j=4;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat4=get_var_nfiles(indir,stem,year,var);

dat11=[dat1;dat3];clear dat1 dat3;
dat22=[dat2;dat4];clear dat2 dat4;

wt=get_monw();window=12;

dat1=slidew_mean(dat11,window,wt);clear dat11;
dat2=slidew_mean(dat22,window,wt);clear dat22;

years=1850+(1:fix(length(dat1)));
fh=zeros(4,1);
for k = 1 : 4
    set(fig,'CurrentAxes',ax(k));
    if(docum)    
        plot(years,cumsum(dat1(:,k)),cc{1},'LineWidth',linewd);hold on;    
        plot(years,cumsum(dat2(:,k)),cc{2},'LineWidth',linewd);
    else
       fh(1)= plot(years,(dat1(:,k)),cc{1},'LineWidth',linewd);hold on;    
       fh(2)= plot(years,(dat2(:,k)),cc{2},'LineWidth',linewd);        
    end
 
end

year=[1850,2000];
j=5;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat1=get_var_nfiles(indir,stem,year,var);

j=6;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat2=get_var_nfiles(indir,stem,year,var);

    
year=[2001,2300];

j=7;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat3=get_var_nfiles(indir,stem,year,var);
j=8;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat4=get_var_nfiles(indir,stem,year,var);

dat11=[dat1;dat3];clear dat1 dat3;
dat22=[dat2;dat4];clear dat2 dat4;
dat1=slidew_mean(dat11,window,wt);clear dat11;
dat2=slidew_mean(dat22,window,wt);clear dat22;
for k = 1 : 4
    set(fig,'CurrentAxes',ax(k));
    if(docum)    
        plot(years,cumsum(dat1(:,k)),cc{3},'LineWidth',linewd);hold on;    
        plot(years,cumsum(dat2(:,k)),cc{4},'LineWidth',linewd);
    else
        fh(3)=plot(years,(dat1(:,k)),cc{3},'LineWidth',linewd);hold on;    
        fh(4)=plot(years,(dat2(:,k)),cc{4},'LineWidth',linewd);        
    end
 
end
txt={'(a)Northern Hemisphere (74.67^\circW,40.6^\circN)','(b)Northern Hemisphere (26.22^\circE,67.7^\circN)',...
    '(c)Southern Hemisphere (50.02^\circW,4.88^\circS)','(d)Southern Hemisphere (51.5^\circW,30.0^\circS)'};
set(ax,'FontSize',14,'Xlim',[1850,2350],'XTick',(1850:100:2350));
set(fig,'Color','w');
for k = 1 : 4        
    set(fig,'CurrentAxes',ax(k));
    grid on;
    xlabel('Year','FontSize',fontsz);
    ylabel('Total carbon (g C m^-^2)','FontSize',fontsz);
    set(ax(k),'Fontsize',fontsz);
    %ylabel('Total vegetation carbon (g C m^-^2)','FontSize',14);
    %ylabel('Total vegetation nitrogen (g N m^-^2)','FontSize',14); 
    if(k<=2)    
        put_tag(fig,ax(k),[.015,.95],txt{k},fontsz);
    else
        put_tag(fig,ax(k),[.015,.05],txt{k},fontsz);
    end
end
legend(fh(4:-1:1),'MNL','NUL','PNL','PNL-adapt');