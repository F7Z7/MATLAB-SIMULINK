clc; clear; close all;

% Define Transfer Function
num = [1]; % Numerator coefficients
den = [1, 3, 2]; % Denominator coefficients
sys = tf(num, den);

% Plot Bode Plot
figure;
subplot(2,2,1);
bode(sys);
title('Bode Plot');

% Plot Root Locus
subplot(2,2,2);
rlocus(sys);
title('Root Locus');

% Plot Nyquist Plot
subplot(2,2,3);
nyquist(sys);
title('Nyquist Plot');

% Plot Polar Plot
subplot(2,2,4);
[mag, phase, w] = bode(sys);
polar(deg2rad(squeeze(phase)), squeeze(mag));
title('Polar Plot');

% Compute Gain and Phase Margins
[GM, PM, Wcg, Wcp] = margin(sys);
fprintf('Gain Margin (dB): %.2f\n', 20*log10(GM));
fprintf('Phase Margin (degrees): %.2f\n', PM);
fprintf('Gain Crossover Frequency (rad/s): %.2f\n', Wcg);
fprintf('Phase Crossover Frequency (rad/s): %.2f\n', Wcp);
