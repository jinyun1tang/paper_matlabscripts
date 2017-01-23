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
    
cc={'m','r','g','b'};
is_load=1;
if(is_load)
    load('cflxes.mat');
else
year=[1850,2000];

j=1;   
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp11, ar11, hr11,  cdwt11, cfire11, cprod11,som_hr11,lit_hr11,npp11]=getCbudget(indir,stem,year);



j=2;    
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp21, ar21, hr21,  cdwt21, cfire21, cprod21,som_hr21,lit_hr21,npp21]=getCbudget(indir,stem,year);



j=5;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp31, ar31, hr31,  cdwt31, cfire31, cprod31,som_hr31,lit_hr31,npp31]=getCbudget(indir,stem,year);


j=6;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp41, ar41, hr41,  cdwt41, cfire41, cprod41,som_hr41,lit_hr41,npp41]=getCbudget(indir,stem,year);


year=[2001,2300];

j=3;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp12, ar12, hr12,  cdwt12, cfire12, cprod12,som_hr12,lit_hr12,npp12]=getCbudget(indir,stem,year);

j=4;    
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});   
stem=get_stem_filename(indir);    
[gpp22, ar22, hr22,  cdwt22, cfire22, cprod22,som_hr22,lit_hr22,npp22]=getCbudget(indir,stem,year);

j=7;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp32, ar32, hr32,  cdwt32, cfire32, cprod32,som_hr32,lit_hr32,npp32]=getCbudget(indir,stem,year);

j=8;
indir=sprintf('%s/%s',mother_dir,sub_dirs{j});
stem=get_stem_filename(indir);    
[gpp42, ar42, hr42,  cdwt42, cfire42, cprod42,som_hr42,lit_hr42,npp42]=getCbudget(indir,stem,year);


save('cflxes.mat','gpp11', 'ar11', 'hr11',  'cdwt11', 'cfire11', 'cprod11','som_hr11','lit_hr11','npp11',...
    'gpp21', 'ar21', 'hr21',  'cdwt21', 'cfire21', 'cprod21','som_hr21','lit_hr21','npp21',...
    'gpp31', 'ar31', 'hr31',  'cdwt31', 'cfire31', 'cprod31','som_hr31','lit_hr31','npp31',...
    'gpp41', 'ar41', 'hr41',  'cdwt41', 'cfire41', 'cprod41','som_hr41','lit_hr41','npp41',...
    'gpp12', 'ar12', 'hr12',  'cdwt12', 'cfire12', 'cprod12','som_hr12','lit_hr12','npp12',...
    'gpp22', 'ar22', 'hr22',  'cdwt22', 'cfire22', 'cprod22','som_hr22','lit_hr22','npp22',...
    'gpp32', 'ar32', 'hr32',  'cdwt32', 'cfire32', 'cprod32','som_hr32','lit_hr32','npp32',...
    'gpp42', 'ar42', 'hr42',  'cdwt42', 'cfire42', 'cprod42','som_hr42','lit_hr42','npp42')
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
fprintf('npp     :%.6f,%.6f,%.6f,%.6f\n',mean(npp11,1).*tyear);

fprintf('%s\n',sims{2});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp21,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar21,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr21,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt21,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire21,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod21,1).*tyear);
fprintf('npp     :%.6f,%.6f,%.6f,%.6f\n',mean(npp21,1).*tyear);
fprintf('%s\n',sims{3});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp31,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar31,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr31,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt31,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire31,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod31,1).*tyear);
fprintf('npp     :%.6f,%.6f,%.6f,%.6f\n',mean(npp31,1).*tyear);
fprintf('%s\n',sims{4});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp41,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar41,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr41,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt41,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire41,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod41,1).*tyear);
fprintf('npp     :%.6f,%.6f,%.6f,%.6f\n',mean(npp41,1).*tyear);
fprintf('2001-2300\n');
fprintf('%s\n',sims{1});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp12,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar12,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr12,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt12,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire12,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod12,1).*tyear);
fprintf('npp     :%.6f,%.6f,%.6f,%.6f\n',mean(npp12,1).*tyear);
fprintf('%s\n',sims{2});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp22,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar22,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr22,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt22,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire22,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod22,1).*tyear);
fprintf('npp     :%.6f,%.6f,%.6f,%.6f\n',mean(npp22,1).*tyear);
fprintf('%s\n',sims{3});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp32,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar32,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr32,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt32,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire32,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod32,1).*tyear);
fprintf('npp     :%.6f,%.6f,%.6f,%.6f\n',mean(npp32,1).*tyear);
fprintf('%s\n',sims{4});
fprintf('gpp     :%.6f,%.6f,%.6f,%.6f\n',mean(gpp42,1).*tyear);
fprintf('ar      :%.6f,%.6f,%.6f,%.6f\n',mean(ar42,1).*tyear);
fprintf('hr      :%.6f,%.6f,%.6f,%.6f\n',mean(hr42,1).*tyear);
fprintf('cwdt    :%.6f,%.6f,%.6f,%.6f\n',mean(cdwt42,1).*tyear);
fprintf('cfire   :%.6f,%.6f,%.6f,%.6f\n',mean(cfire42,1).*tyear);
fprintf('cprod   :%.6f,%.6f,%.6f,%.6f\n',mean(cprod42,1).*tyear);
fprintf('npp     :%.6f,%.6f,%.6f,%.6f\n',mean(npp42,1).*tyear);
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
%    fh(1)=plot(years,(cfire11(:,k)).*tyear,cc{1},'LineWidth',2);hold on;    
%    fh(2)=plot(years,(cfire21(:,k)).*tyear,cc{2},'LineWidth',2);        
%    fh(3)=plot(years,(cfire31(:,k)).*tyear,cc{3},'LineWidth',2);        
%    fh(4)=plot(years,(cfire41(:,k)).*tyear,cc{4},'LineWidth',2);   
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

legend(fh(4:-1:1),'MNL','NUL','PNL','PNL-adapt');



fig=figure;
set(fig,'unit','normalized','position',[.1,.1,.7,.9]);
ax = multipanel(fig,2,2,[.1,.1],[.4,.35],[.075,.075]);

years=(1850:2000);


for k = 1 : 4
    set(fig,'CurrentAxes',ax(k));

    fh(1)=plot(years,(npp11(:,k)).*tyear,cc{1},'LineWidth',2);hold on;    
    fh(2)=plot(years,(npp21(:,k)).*tyear,cc{2},'LineWidth',2);        
    fh(3)=plot(years,(npp31(:,k)).*tyear,cc{3},'LineWidth',2);        
    fh(4)=plot(years,(npp41(:,k)).*tyear,cc{4},'LineWidth',2);        
%    fh(1)=plot(years,(cfire11(:,k)).*tyear,cc{1},'LineWidth',2);hold on;    
%    fh(2)=plot(years,(cfire21(:,k)).*tyear,cc{2},'LineWidth',2);        
%    fh(3)=plot(years,(cfire31(:,k)).*tyear,cc{3},'LineWidth',2);        
%    fh(4)=plot(years,(cfire41(:,k)).*tyear,cc{4},'LineWidth',2);   
end
txt={'(a)(74.67^\circW,40.6^\circN)','(b)(26.22^\circE,67.7^\circN)',...
    '(c)(50.02^\circW,4.88^\circS)','(d)(51.5^\circW,30.0^\circS)'};
set(ax,'FontSize',14,'Xlim',[1850,2000]);
set(fig,'Color','w');
for k = 1 : 4        
    set(fig,'CurrentAxes',ax(k));
    xlabel('Year','FontSize',14);
    ylabel('NPP (g C m^-^2yr^-^1)','FontSize',14);
    %ylabel('Total vegetation carbon (g C m^-^2)','FontSize',14);
    %ylabel('Total vegetation nitrogen (g N m^-^2)','FontSize',14);    
    put_tag(fig,ax(k),[.05,.95],txt{k},14);
end

legend(fh(4:-1:1),'MNL','NUL','PNL','PNL-adapt');

fig=figure;
set(fig,'unit','normalized','position',[.1,.1,.8,.65]);
ax = multipanel(fig,2,4,[.075,.075],[.18,.4],[.05,.065]);


sites={'(a1)(74.67^\circW,40.6^\circN)','(b1)(26.22^\circE,67.7^\circN)',...
    '(c1)(50.02^\circW,4.88^\circS)','(d1)(51.5^\circW,30.0^\circS)',...
    '(a2)(74.67^\circW,40.6^\circN)','(b2)(26.22^\circE,67.7^\circN)',...
    '(c2)(50.02^\circW,4.88^\circS)','(d2)(51.5^\circW,30.0^\circS)'};



npp1=cumsum([npp11;npp12],1);hr1=cumsum([hr11;hr12],1);
npp2=cumsum([npp21;npp22],1);hr2=cumsum([hr21;hr22],1);
npp3=cumsum([npp31;npp32],1);hr3=cumsum([hr31;hr32],1);
npp4=cumsum([npp41;npp42],1);hr4=cumsum([hr41;hr42],1);

for jj = 1 : 4
    set(fig,'CurrentAxes',ax(jj));    
    hh(1)=plot((1850:2300),(npp1(:,jj)-npp4(:,jj)).*tyear,cc{1},'LineWidth',1.5);      
    hold on;
    hh(2)=plot((1850:2300),(npp2(:,jj)-npp4(:,jj)).*tyear,cc{2},'LineWidth',1.5);      
    hh(3)=plot((1850:2300),(npp3(:,jj)-npp4(:,jj)).*tyear,cc{3},'LineWidth',1.5);      

    
    
    
    set(fig,'CurrentAxes',ax(jj+4));    
    plot((1850:2300),(hr1(:,jj)-hr4(:,jj)).*tyear,cc{1},'LineWidth',1.5);      
    hold on;
    plot((1850:2300),(hr2(:,jj)-hr4(:,jj)).*tyear,cc{2},'LineWidth',1.5);      
    plot((1850:2300),(hr3(:,jj)-hr4(:,jj)).*tyear,cc{3},'LineWidth',1.5);      
  
end

set(ax,'Xlim',[1850,2300]);
legend(hh(3:-1:1),'NULmMNL','PNLmMNL','PNL-adaptmMNL');
set(fig,'Color','w');

set(ax,'FontSize',14);
set(ax(1:4),'XTickLabel','');

for jj = 5:8
    set(fig,'CurrentAxes',ax(jj));
    xlabel('Year');
end


sites={'(a1)(74.67^\circW,40.6^\circN)','(b1)(26.22^\circE,67.7^\circN)',...
    '(c1)(50.02^\circW,4.88^\circS)','(d1)(51.5^\circW,30.0^\circS)',...
    '(a2)(74.67^\circW,40.6^\circN)','(b2)(26.22^\circE,67.7^\circN)',...
    '(c2)(50.02^\circW,4.88^\circS)','(d2)(51.5^\circW,30.0^\circS)'};

for jj = 1 : 8
    put_tag(fig,ax(jj),[.025,.93],sites{jj},14);
end

set(fig,'CurrentAxes',ax(1));
ylabel('\Delta Cumulative NPP (gC m^-^2)'); 
set(fig,'CurrentAxes',ax(5));
ylabel('\Delta Cumulative HR (gC m^-^2)'); 

