close all;
clear all;
clc;

mother_dir='/Users/jinyuntang/work/data_collection/clm_output/bg_nn_coupling';
sub_dirs={...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3adt.2016-04-30',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3adt_cent.2016-04-30',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3adt_clm.2016-04-30',...
    'CLM_USRDAT.I_1850-2000_CLM45_BGC.lawrencium-lr3.intel.5656685.bclm3adt_tr.2016-05-01'};
fig=figure;
set(fig,'unit','normalized','position',[.1,.1,.6,.9]);

year=[1850,2000];
ax = multipanel(fig,2,2,[.1,.1],[.4,.4],[.075,.05]);
    
cc={'b','g','k','c','y','m'};
var='TOTCOLC';
j=1;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat1=get_var_nfiles(indir,stem,year,var);

j=2;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat2=get_var_nfiles(indir,stem,year,var);

    
for k = 1 : 4
    set(fig,'CurrentAxes',ax(k));
    plot(dat1(:,k));hold on;
    plot(dat2(:,k),cc{2});
 
end

j=3;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat1=get_var_nfiles(indir,stem,year,var);


    
for k = 1 : 4
    set(fig,'CurrentAxes',ax(k));
    plot(dat1(:,k),cc{3});hold on;

 
end
%%%
fig1=figure;
set(fig1,'unit','normalized','position',[.1,.1,.6,.9]);
ax1 = multipanel(fig1,2,2,[.1,.1],[.4,.4],[.075,.05]);
j=1;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat1=get_var_nfiles(indir,stem,year,var);

j=4;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat2=get_var_nfiles(indir,stem,year,var);

    
for k = 1 : 4
    set(fig1,'CurrentAxes',ax1(k));
    plot(dat1(:,k),cc{1});hold on;
    plot(dat2(:,k),cc{2});    
end

fig2=figure;
set(fig2,'unit','normalized','position',[.1,.1,.6,.9]);
ax2 = multipanel(fig2,2,2,[.1,.1],[.4,.4],[.075,.05]);
var='TOTCOLN';
j=1;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat1=get_var_nfiles(indir,stem,year,var);

j=4;
    indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
    stem=get_stem_filename(indir);    
    dat2=get_var_nfiles(indir,stem,year,var);

    
for k = 1 : 4
    set(fig2,'CurrentAxes',ax2(k));
    plot(dat1(:,k),cc{1});hold on;
    plot(dat2(:,k),cc{2});    
end