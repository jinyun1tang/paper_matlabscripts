%content
close all;
clear all;
model_src={'depolymerization.m',...
    'eca.m',...
'ecacmplx.m',...
'get_tsoi.m',...
'micbmortality.m',...
'micbphysiology.m',...
'monomeruptake.m',...
'resom_envset.m',...
'resom_par.m',...
'resom_tm.m',...
'supeca.m',...
'supecacmplx.m'};

model_driver={'resom_driver.m'};
test_src={'kinetics_test.m',...
    'parset_test.m'};