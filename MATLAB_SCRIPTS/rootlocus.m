clc; clear; close all;

% Define numerator and denominator
num = [1 12];  
den = conv([1 0 0], [1 20]);  

% Create transfer function
sys = tf(num, den);

% Get poles and zeros
poles = pole(sys);
zeros_ = zero(sys);

% Step 1: Calculate Centroid (Asymptote Intersection Point)
N = length(poles); % Number of poles
M = length(zeros_); % Number of zeros
sigma_a = (sum(real(poles)) - sum(real(zeros_))) / (N - M);
disp(['Centroid (σ_a): ', num2str(sigma_a)]);

% Step 2: Calculate Asymptote Angles
angles = ( (2*(0:N-M-1) + 1) * 180 ) / (N - M);
disp('Asymptote Angles (degrees):');
disp(angles);

% Step 3: Find Breakaway and Break-in Points (Solve dK/ds = 0)
syms s K;
char_eq = det(s*eye(N) - diag(poles)); % Characteristic equation determinant
K_eq = simplify(1 / char_eq);
dK_ds = diff(K_eq, s); % Derivative of K
break_points = double(solve(dK_ds == 0, s)); % Solve for s
disp('Breakaway/Break-in Points:');
disp(break_points);

% Step 4: Use Routh-Hurwitz to Find Imaginary Axis Crossings
disp('Checking Imaginary Axis Crossing using Routh-Hurwitz Criterion...');
[rh_table, crossing_freq] = routh(den); % Custom Routh function
disp('Crossing Frequency (Imaginary Axis):');
disp(crossing_freq);

% Plot Root Locus
figure;
rlocus(sys);

plot(real(break_points), imag(break_points), 'ro', 'MarkerSize', 10, 'LineWidth', 2); % Mark breakaway points
plot(sigma_a, 0, 'g*', 'MarkerSize', 10, 'LineWidth', 2); % Mark centroid
title('Root Locus with Asymptotes & Breakaway Points');
grid on;

% Add Asymptotes to Plot
for angle = angles
    theta_rad = deg2rad(angle);
    x = [sigma_a sigma_a + cos(theta_rad) * 10]; % Extend line
    y = [0 sin(theta_rad) * 10];
    plot(x, y, '--k', 'LineWidth', 1.5);
end

% Add Imaginary Axis Crossing (if any)
if ~isempty(crossing_freq)
    yline(crossing_freq, '--m', 'LineWidth', 1.5); % Add vertical magenta line
end


