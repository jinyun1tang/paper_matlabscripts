%clc;
clear all;
close all;
%Driver file for the revised DEB model
%Author: Jinyun Tang (jinyuntang@lbl.gov)
%Prepare the work space
addpath('/Users/jinyuntang/work/github/matlab_tools/');
addpath('/Users/jinyuntang/work/github/matlab_tools/export_fig');
addpath('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB');

%load('parrdeb_opt.mat');
load('/Users/jinyuntang/work/github/matlab_tools/MCMC/DREAM_ZS/parrdeb_dreamzs.mat');
parset=ParSet(35001-300:end,:);
parpct_rdeb=get_parstd_rdeb(parset,parrdeb);
%################################################################
%Driver for the standard DEB model
%load('parsdeb_opt.mat');
load('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB/parsdeb_opt1.mat');
parset=ParSet';
parpct_sdeb=get_parstd_sdeb(parset);
%#####################################################################
%Define parameters for the composite model
%load('parcomp_opt.mat');
load('parcomp_opt1.mat');
parset=ParSet';
parpct_comp=get_parstd_comp(parset);

