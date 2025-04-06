x = -10:0.1:10; % Define the range of x

% First subplot: Sigmoid function
subplot(3, 1, 1); % Create a grid with 2 rows and 1 column, activate the 1st plot
y1 = 1 ./ (1 + exp(-x)); % Sigmoid function
plot(x, y1, 'r'); % Plot sigmoid in red
title('Sigmoid Function'); % Title for the first subplot
xlabel('x');
ylabel('y');
grid on;

% Second subplot: Tangent function
subplot(2, 1, 2); % Activate the 2nd plot
y2 = 2./1+exp(-2.*x); % Tangent function
plot(x, y2, 'b'); % Plot tangent in blue
title('Tanh Function'); % Title for the second subplot
xlabel('x');
ylabel('y');
grid on;

subplot(2, 1, 3);x` % Activate the 2nd plot
y3 =max(0,x); % Tangent function
plot(x, y2, 'b'); % Plot tangent in blue
title('RELU Function'); % Title for the second subplot
xlabel('x');
ylabel('y');
grid on;

% Adjust layout for better visualization
sgtitle('Subplot Example'); % Super title for the whole figure
