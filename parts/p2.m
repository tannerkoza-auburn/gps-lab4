%% Fundamentals of GPS - Lab 4 - Part 1
clear
clc
close all

%% Part A

% Data Import
tData = 0.002; % 2 ms of Signal
[sig, sigSamps] = parseIFEN(tData);
s1 = sig(1:sigSamps/2);
s2 = sig((sigSamps/2)+1:end);

% Time Initialization
tInt = tData/2;
fS = 20e6;
tS = 1/fS;
n = 0:tS:tInt-tS;

% Code Initialization
prn = 8;
codeL = 1023;

% Code Upsampling
ca = genCA(prn,codeL);
caU = sample(ca',sigSamps/2,1.023e6,fS,0);
sShift = (sigSamps/2)/codeL;

% Doppler Initialization
fIF = 5000445.88565834; % Intermediate Frequency (Hz)
fBin = 500; % Frequency Bin Size (Hz)
fLim = 10000; % Doppler Frequency Limit (Hz)
fSearch = (fIF-fLim):fBin:(fIF+fLim); % Frequency Search Space
fSearchL = length(fSearch); % Frequency Search Space Length

% Correlation
R1 = zeros(fSearchL,codeL);
R2 = zeros(fSearchL,codeL);

for i = 1:fSearchL
    for j = 1:codeL
        I = s1'.*caU'.*cos(2*pi*fSearch(i)*n);
        Q = s1'.*caU'.*sin(2*pi*fSearch(i)*n);
        R1(i,j) = sum(I)^2 + sum(Q)^2;

        caU = sample(ca',sigSamps/2,1.023e6,fS,j);
    end
end

[X,Y] = meshgrid(1:codeL, -fLim:fBin:fLim);

figure
surf(X,Y,R1)
title('Correlation: PRN 8')
xlabel('Code Phase (Chips)')
ylabel('Doppler (Hz)')
zlabel('Correlation')
xlim([0 codeL])

%% Part B

% Data Import
tData = 0.02; % 2 ms of Signal
[sig, sigSamps] = parseIFEN(tData);
s1 = sig(1:sigSamps/2);
s2 = sig((sigSamps/2)+1:end);

% Time Initialization
tInt = tData/2;
fS = 20e6;
tS = 1/fS;
n = 0:tS:tInt-tS;

% Code Initialization
prn = 8;
codeL = 1023;

% Code Upsampling
ca = genCA(prn,codeL);
caU = sample(ca',sigSamps/2,1.023e6,fS,0);
sShift = (sigSamps/2)/codeL;

% Doppler Initialization
fIF = 5000445.88565834; % Intermediate Frequency (Hz)
fBin = 500; % Frequency Bin Size (Hz)
fLim = 10000; % Doppler Frequency Limit (Hz)
fSearch = (fIF-fLim):fBin:(fIF+fLim); % Frequency Search Space
fSearchL = length(fSearch); % Frequency Search Space Length

% Correlation
R1 = zeros(fSearchL,codeL);
R2 = zeros(fSearchL,codeL);

for i = 1:fSearchL
    for j = 1:codeL
        I = s1'.*caU'.*cos(2*pi*fSearch(i)*n);
        Q = s1'.*caU'.*sin(2*pi*fSearch(i)*n);
        R1(i,j) = sum(I)^2 + sum(Q)^2;

        caU = sample(ca',sigSamps/2,1.023e6,fS,j);
    end
end

for i = 1:fSearchL
    for j = 1:codeL
        I = s2'.*caU'.*cos(2*pi*fSearch(i)*n);
        Q = s2'.*caU'.*sin(2*pi*fSearch(i)*n);
        R2(i,j) = sum(I)^2 + sum(Q)^2;

        caU = sample(ca',sigSamps/2,1.023e6,fS,j);
    end
end

[X,Y] = meshgrid(1:codeL, -fLim:fBin:fLim);

figure
surf(X,Y,R1)
title('Correlation: PRN 8 Chunk 1')
xlabel('Code Phase (Chips)')
ylabel('Doppler (Hz)')
zlabel('Correlation')
xlim([0 codeL])

figure
surf(X,Y,R2)
title('Correlation: PRN 8 Chunk 2')
xlabel('Code Phase (Chips)')
ylabel('Doppler (Hz)')
zlabel('Correlation')
xlim([0 codeL])

%% Part C 

% Data Import
tData = 0.04; % 2 ms of Signal
[sig, sigSamps] = parseIFEN(tData);
s1 = sig(1:sigSamps/2) + 6*randn(sigSamps/2,1);
s2 = sig(1:sigSamps/2) + 12*randn(sigSamps/2,1);

% Time Initialization
tInt = tData/2;
fS = 20e6;
tS = 1/fS;
n = 0:tS:tInt-tS;

% Code Initialization
prn = 8;
codeL = 1023;

% Code Upsampling
ca = genCA(prn,codeL);
caU = sample(ca',sigSamps/2,1.023e6,fS,0);
sShift = (sigSamps/2)/codeL;

% Doppler Initialization
fIF = 5000445.88565834; % Intermediate Frequency (Hz)
fBin = 500; % Frequency Bin Size (Hz)
fLim = 10000; % Doppler Frequency Limit (Hz)
fSearch = (fIF-fLim):fBin:(fIF+fLim); % Frequency Search Space
fSearchL = length(fSearch); % Frequency Search Space Length

% Correlation
R1 = zeros(fSearchL,codeL);
R2 = zeros(fSearchL,codeL);

for i = 1:fSearchL
    for j = 1:codeL
        I = s1'.*caU'.*cos(2*pi*fSearch(i)*n);
        Q = s1'.*caU'.*sin(2*pi*fSearch(i)*n);
        R1(i,j) = sum(I)^2 + sum(Q)^2;

        caU = sample(ca',sigSamps/2,1.023e6,fS,j);
    end
end

for i = 1:fSearchL
    for j = 1:codeL
        I = s2'.*caU'.*cos(2*pi*fSearch(i)*n);
        Q = s2'.*caU'.*sin(2*pi*fSearch(i)*n);
        R2(i,j) = sum(I)^2 + sum(Q)^2;

        caU = sample(ca',sigSamps/2,1.023e6,fS,j);
    end
end

[X,Y] = meshgrid(1:codeL, -fLim:fBin:fLim);

figure
surf(X,Y,R1)
title('Correlation: PRN 8 \sigma = 6')
xlabel('Code Phase (Chips)')
ylabel('Doppler (Hz)')
zlabel('Correlation')
xlim([0 codeL])

figure
surf(X,Y,R2)
title('Correlation: PRN 8 \sigma = 12')
xlabel('Code Phase (Chips)')
ylabel('Doppler (Hz)')
zlabel('Correlation')
xlim([0 codeL])