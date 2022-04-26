%% Fundamentals of GPS - Lab 4 - Part 1
clear
clc
close all

%% Part A

% Data Import
tData = 0.1; % Length of Signal
[sig, sigSamps] = parseIFEN(tData);
fS = 20e6;
tS = 1/fS;
t = 0:tS:tData-tS;

figure
plot(t,sig)
title('IFEN Signal')
xlabel('Time (s)')
ylabel('Amplitude')
axis padded

%% Part B

figure
histogram(sig)
title('IFEN Histogram')

%% Part C

figure
periodogram(sig)