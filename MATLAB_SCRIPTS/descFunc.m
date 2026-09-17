% Describing Function Analysis in MATLAB
clear; clc; close all;

% Range of input amplitudes
A = linspace(0.1, 10, 100);

% Describing function arrays
N_sat = zeros(size(A));
N_relay = zeros(size(A));

% Parameters of nonlinearities
sat_limit = 2;   % saturation level
relay_h = 1;     % relay output magnitude

% Loop over amplitudes
for k = 1:length(A)
    a = A(k);
    
    % Describing function of saturation
    if a <= sat_limit
        N_sat(k) = 1;  
    else
        N_sat(k) = (2/pi)*(asin(sat_limit/a) + (sat_limit/a)*sqrt(1 - (sat_limit/a)^2));
    end
    
   
    N_relay(k) = (4*relay_h) / (pi*a);
end


figure;
plot(A, abs(N_sat), 'r', 'LineWidth', 2); hold on;
plot(A, abs(N_relay), 'b', 'LineWidth', 2);
grid on;
xlabel('Input Amplitude A');
ylabel('|N(A)|');
legend('Saturation', 'Relay');
title('Describing Functions of Nonlinearities');
