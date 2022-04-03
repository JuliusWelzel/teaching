%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                     
%
%       Load data and first plots
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Data: Coffee quality database 
% Author:Julius Welzel (Neurogeriatrie, UKSH Kiel,University of Kiel)
% Version: 1.0 

% clean wksp -------------------------
clc;clear all;close all;


%Change MatLab defaults
set(0,'defaultfigurecolor',[1 1 1]);
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Times New Roman')
% Change default text fonts.
set(0,'DefaultTextFontname', 'Times New Roman')

%% Set MAIN path ----------------------
MAIN = [fileparts(pwd) '\'];
addpath(genpath(MAIN))

PATHIN = [MAIN '01_data\00_raw\'];
PATHOUT_plot = [MAIN '03_plots\'];

if ~exist(PATHOUT_plot);mkdir(PATHOUT_plot);end

%% load data
dat_raw = readtable([PATHIN 'arabica_data_cleaned.csv']);
dat_raw = standardizeMissing(dat_raw,0);%% plot overview

%% plot data
figure
scatterhist(dat_raw.Flavor,dat_raw.Aroma)
xlabel 'Flavor'
ylabel 'Aroma'
box off

%% save plot
save_fig(gcf,PATHOUT_plot,'overview_flv_arm');
