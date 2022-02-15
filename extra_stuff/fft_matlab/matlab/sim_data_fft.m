%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                     
%
%       Simulating data for FFT 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Author: Julius Welzel (Neurogeriatrie, UKSH Kiel, University of Kiel)
% Version: 1.0 // setting up default (26.01.2021)

% clean wksp 
clc;
clear all;
close all;

% Change MatLab defaults
set(0,'defaultfigurecolor',[1 1 1]);

%% Set MAIN path 
MAIN = [fileparts(pwd) '\'];
addpath(genpath(MAIN)) % add all file in path to matlab envir


%% simulate

% Testsignal settings
% X Hz , Y sec, Z amp

% x = % Hz
% y = % sec
% z = % amp
srate = 500; % number of samples per second

%% simulate and plot 1 sine 5 sec amp of 1 at 5 Hz
x = 5; % Hz
y = 5; % sec
z = 1; % amp

time    = linspace(0,y,srate*y);
vec     = linspace (0, 2 * pi * y,srate * y );

signal_all  = z * sin( vec * x );

figure
plot(time,signal_all,'LineWidth',2)
    xlabel 'Time [s]'
    ylabel 'Amplitude [a.u.]'
    box off
    ylim ([-2 2])
    set(gcf, 'Units', 'centimeters', 'OuterPosition', [0 0 35 10]);

    xlim([0 1])
    
%% simulate and plot 2 sines 5 sec amp of 1&0.5 at 5&1 Hz

x = 5; % Hz
y = 5; % sec
z = 1; % amp
signal1  = z * sin( vec * x );

x = 1; % Hz
y = 5; % sec
z = 0.5; % amp
signal2  = z * sin( vec * x );

figure
subplot(3,1,1)
plot(time,[signal1 + signal2],'LineWidth',2)
    xlabel 'Time [s]'
    ylabel 'Amplitude [a.u.]'
    box off
    ylim ([-2 2])

subplot(3,1,2)
plot(time,signal1,'k--','LineWidth',1)
    xlabel 'Time [s]'
    ylabel 'Amplitude [a.u.]'
    box off
    ylim ([-2 2])
subplot(3,1,3)
plot(time,signal2,'k--','LineWidth',1)
    xlabel 'Time [s]'
    ylabel 'Amplitude [a.u.]'
    box off
    ylim ([-2 2])

set(gcf, 'Units', 'centimeters', 'OuterPosition', [0 0 35 20]);


%% plot multiple with sines and noise
clear x z noise_scl signal

n = 20;
x = randi(20,1,n); % Hz
y = 5; % sec
z = randi(2,1,n); % amp

noise_scl = 0.1 * randi(100,1,n)/100;

time    = linspace(0,y,srate*y);

for i = 1:n
    phase_shift     = randi([-100,100],1,1)/100 * pi;
    vec             = linspace (0 + phase_shift, 2 * pi * y + phase_shift, srate * y );
    signal_all(i,:)     = z(i) * sin( vec * x(i) ) + noise_scl(i)*rand(size(vec));
end

figure
plot(time,sum(signal_all,1),'LineWidth',1.5)
    xlabel 'Time [s]'
    ylabel 'Amplitude [a.u.]'
    box off
    title (['Signals = ' num2str(n) ' @ Hz ' num2str(x)])

set(gcf, 'Units', 'centimeters', 'OuterPosition', [0 0 35 15]);


%% fft of signal 1
[freq_vec,amp] = my_fft(time,signal1,srate);

figure
subplot(2,1,1)
plot(time,signal1)
    xlabel 'Time [s]'
    ylabel 'Amplitude [a.u.]'
    box off
    title '5 Hz'
    
subplot(2,1,2)
plot(freq_vec,amp)
    xlabel 'Frequency [Hz]'
    ylabel 'Amplitude [a.u.]'
    xlim ([0 20])
    box off

set(gcf, 'Units', 'centimeters', 'OuterPosition', [0 0 35 20]);

%% fft of multiple sines

[freq_vec,amp] = my_fft(time,sum(signal_all,1),srate);

figure
subplot(2,1,1)
plot(time,sum(signal_all,1))
    xlabel 'Time [s]'
    ylabel 'Amplitude [a.u.]'
    box off
    title (['Signals = ' num2str(n) ' @ Hz ' num2str(unique(sort(x)))])
    
subplot(2,1,2)
plot(freq_vec,amp)
    xlabel 'Frequency [Hz]'
    ylabel 'Amplitude [a.u.]'
    xlim ([0 25])
    box off

set(gcf, 'Units', 'centimeters', 'OuterPosition', [0 0 35 20]);

