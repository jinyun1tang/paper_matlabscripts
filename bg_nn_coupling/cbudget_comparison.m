close all;
clear all;
clc;
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
    
cc={'b','g','k','m'};
is_load=1;
if(is_load)
    load('cflxes.mat');
else
year=[1850,2000];

j=1;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp11, ar11, hr11,  cdwt11, cfire11, cprod11,som_hr11,lit_hr11]=getCbudget(indir,stem,year);



j=2;    
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp21, ar21, hr21,  cdwt21, cfire21, cprod21,som_hr21,lit_hr21]=getCbudget(indir,stem,year);



j=5;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp31, ar31, hr31,  cdwt31, cfire31, cprod31,som_hr31,lit_hr31]=getCbudget(indir,stem,year);


j=6;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp41, ar41, hr41,  cdwt41, cfire41, cprod41,som_hr41,lit_hr41]=getCbudget(indir,stem,year);


year=[2001,2300];

j=3;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp12, ar12, hr12,  cdwt12, cfire12, cprod12,som_hr12,lit_hr12]=getCbudget(indir,stem,year);

j=4;    
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});   
stem=get_stem_filename(indir);    
[gpp22, ar22, hr22,  cdwt22, cfire22, cprod22,som_hr22,lit_hr22]=getCbudget(indir,stem,year);

j=7;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp32, ar32, hr32,  cdwt32, cfire32, cprod32,som_hr32,lit_hr32]=getCbudget(indir,stem,year);

j=8;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp42, ar42, hr42,  cdwt42, cfire42, cprod42,som_hr42,lit_hr42]=getCbudget(indir,stem,year);


save('cflxes.mat','gpp11', 'ar11', 'hr11',  'cdwt11', 'cfire11', 'cprod11','som_hr11','lit_hr11',...
    'gpp21', 'ar21', 'hr21',  'cdwt21', 'cfire21', 'cprod21','som_hr21','lit_hr21',...
    'gpp31', 'ar31', 'hr31',  'cdwt31', 'cfire31', 'cprod31','som_hr31','lit_hr31',...
    'gpp41', 'ar41', 'hr41',  'cdwt41', 'cfire41', 'cprod41','som_hr41','lit_hr41',...
    'gpp12', 'ar12', 'hr12',  'cdwt12', 'cfire12', 'cprod12','som_hr12','lit_hr12',...
    'gpp22', 'ar22', 'hr22',  'cdwt22', 'cfire22', 'cprod22','som_hr22','lit_hr22',...
    'gpp32', 'ar32', 'hr32',  'cdwt32', 'cfire32', 'cprod32','som_hr32','lit_hr32',...
    'gpp42', 'ar42', 'hr42',  'cdwt42', 'cfire42', 'cprod42','som_hr42','lit_hr42')
end

tyear=3600*24*365;
%print statistics to screen
fprintf('1850-2000\n');
fprintf('%s\n',sims{1});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp11,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar11,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr11,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt11,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire11,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod11,1).*tyear);
fprintf('%s\n',sims{2});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp21,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar21,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr21,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt21,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire21,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod21,1).*tyear);
fprintf('%s\n',sims{3});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp31,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar31,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr31,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt31,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire31,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod31,1).*tyear);
fprintf('%s\n',sims{4});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp41,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar41,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr41,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt41,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire41,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod41,1).*tyear);
fprintf('2001-2300\n');
fprintf('%s\n',sims{1});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp12,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar12,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr12,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt12,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire12,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod12,1).*tyear);
fprintf('%s\n',sims{2});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp22,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar22,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr22,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt22,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire22,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod22,1).*tyear);
fprintf('%s\n',sims{3});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp32,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar32,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr32,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt32,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire32,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod32,1).*tyear);
fprintf('%s\n',sims{4});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp42,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar42,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr42,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt42,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire42,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod42,1).*tyear);
%


fig=figure;
set(fig,'unit','normalized','position',[.1,.1,.7,.9]);
ax = multipanel(fig,2,2,[.1,.1],[.4,.35],[.075,.075]);

years=(1850:2000);


for k = 1 : 4
    set(fig,'CurrentAxes',ax(k));

    fh(1)=plot(years,(hr11(:,k)).*tyear,cc{1},'LineWidth',2);hold on;    
    fh(2)=plot(years,(hr21(:,k)).*tyear,cc{2},'LineWidth',2);        
    fh(3)=plot(years,(hr31(:,k)).*tyear,cc{3},'LineWidth',2);        
    fh(4)=plot(years,(hr41(:,k)).*tyear,cc{4},'LineWidth',2);        
 
end
txt={'(a)(74.67^\circW,40.6^\circN)','(b)(26.22^\circE,67.7^\circN)',...
    '(c)(50.02^\circW,4.88^\circS)','(d)(51.5^\circW,30.0^\circS)'};
set(ax,'FontSize',14,'Xlim',[1850,2000]);
set(fig,'Color','w');
for k = 1 : 4        
    set(fig,'CurrentAxes',ax(k));
    xlabel('Year','FontSize',14);
    ylabel('HR (g C m^-^2yr^-^1)','FontSize',14);
    %ylabel('Total vegetation carbon (g C m^-^2)','FontSize',14);
    %ylabel('Total vegetation nitrogen (g N m^-^2)','FontSize',14);    
    put_tag(fig,ax(k),[.05,.95],txt{k},14);
end
legend(fh,'PNL-adapt','PNL','NUL','MNL');

