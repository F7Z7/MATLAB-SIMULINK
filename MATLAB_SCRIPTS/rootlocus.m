clc; clear;

% Original plant
s = tf('s');
G = 1 / (s * (s + 2));

% Lead compensator
Gc = (s + 1) / (s + 5.4);

% Compensated open-loop system
G_open = Gc * G;

% Root locus

rlocus(G)
hold on
rlocus(G_open);
hold off
title('Root Locus with Lead Compensator');
grid on;

% Desired pole location
s_d = -2.05 + 3.86j;
hold on;
plot(real(s_d), imag(s_d), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
legend('Root Locus', 'Desired Pole');

% Get gain at desired pole
[K, poles] = rlocfind(G_open);  % click on desired location in plot

% Closed-loop transfer function
T = feedback(K * G_open, 1);

% Step response
figure;
step(T);
title('Step Response of Compensated System');
grid on;
