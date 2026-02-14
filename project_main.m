% =========================================================================
%  COMPARATIVE ANALYSIS OF ROOT FINDING
% =========================================================================
%  Author       : Kayar Berat
%  Date         : 2025
%  Subject      : Root Finding Algorithms & Convergence Analysis
% -------------------------------------------------------------------------
%  DESCRIPTION:
%  This script benchmarks and visualizes three fundamental numerical 
%  methods for finding roots of non-linear equations:
%     1. Newton-Raphson Method (Quadratic Convergence)
%     2. Secant Method (Superlinear Convergence)
%     3. Bisection Method (Linear Convergence)
%
%  KEY FEATURES:
%   - Numerical Derivative: Uses Finite Difference approximation (h=1e-6)
%     to eliminate the need for analytical derivative calculation.
%   - Time Benchmarking: Averaging execution time over N runs to ensure
%     measurement stability and accuracy.
%   - Visualization: Plots function behavior, root locations, and 
%     convergence speed on a semi-log scale.
% =========================================================================

clc; clear; close all;

% ---------------------------------------------------------
% 1. Define Problem
% ---------------------------------------------------------
% Target Function
f = @(x) exp(-x) - sin(x);

% Numerical Derivative Approximation (Finite Difference)
h = 1e-6;  % Step size for derivative
df = @(x) (f(x + h) - f(x)) / h;  

% Parameters
tol = 1e-8;       % Tolerance for convergence
max_iter = 100;   % Maximum number of iterations
N = 10000;         % Number of runs for time averaging

disp('==========================================================');
disp('   COMPARATIVE ANALYSIS OF ROOT FINDING ALGORITHMS');
disp(['   (Results averaged over ', num2str(N), ' runs)']);
disp('==========================================================');
disp('Method         Root            Iterations      Avg Time (s)');
disp('----------------------------------------------------------');

% ---------------------------------------------------------
% 2. Run Algorithms (with Average Time Calculation)
% ---------------------------------------------------------

% --- Newton-Raphson ---
x0 = 0.5;
tic; 
for k = 1:N
    [root_n, iter_n, err_n] = solve_newton(f, df, x0, tol, max_iter);
end
total_time_n = toc; 
time_n = total_time_n / N; 
result_n = ['Newton         ', num2str(root_n, '%.5f'), '      ', ...
    num2str(iter_n), '              ', num2str(time_n, '%.6f')];
disp(result_n);

% --- Bisection ---
a = 0; b = 2;
tic;
for k = 1:N
    [root_b, iter_b, err_b] = solve_bisection(f, a, b, tol, max_iter);
end
total_time_b = toc;
time_b = total_time_b / N;
result_b = ['Bisection      ', num2str(root_b, '%.5f'), '      ', ...
    num2str(iter_b), '             ', num2str(time_b, '%.6f')];
disp(result_b);

% --- Secant ---
x0_s = 0; x1_s = 1; 
tic;
for k = 1:N
    [root_s, iter_s, err_s] = solve_secant(f, x0_s, x1_s, tol, max_iter);
end
total_time_s = toc;
time_s = total_time_s / N;
result_s = ['Secant         ', num2str(root_s, '%.5f'), '      ', ...
    num2str(iter_s), '              ', num2str(time_s, '%.6f')];
disp(result_s);

disp(' ');
disp('Analysis complete. Generating plots...');

% ---------------------------------------------------------
% 3. Visualization 1: Root Location
% ---------------------------------------------------------
figure('Name', 'Root Location', 'NumberTitle', 'off');

center = root_b; % Center the root
range = 2; 

x_vals = (center - range):0.01:(center + range);
y_vals = f(x_vals);

% Draw Function and Zero Line
plot(x_vals, y_vals, 'y-', 'LineWidth', 1.5); hold on; 
yline(0, 'm-', 'LineWidth', 1); 
xline(0, 'm-', 'LineWidth', 1); 

% Plot Roots with Different Symbols
h_newton = plot(root_n, f(root_n), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
h_bisect = plot(root_b, f(root_b), 'gx', 'MarkerSize', 10, 'LineWidth', 2);
h_secant = plot(root_s, f(root_s), 'bs', 'MarkerSize', 10, 'LineWidth', 2);

title('Function Behavior and Found Roots');
xlabel('x');
ylabel(['f(x) = ', func2str(f)]); 
grid on;

legend([h_newton, h_bisect, h_secant], ...
       'Newton Root', 'Bisection Root', 'Secant Root', ...
       'Location', 'best');

% ---------------------------------------------------------
% 4. Visualization 2: Convergence Speed (Semilogy)
% ---------------------------------------------------------
figure('Name', 'Convergence Analysis', 'NumberTitle', 'off');

semilogy(1:length(err_b), err_b, 'g-o', 'LineWidth', 1.5, 'DisplayName', ...
    'Bisection (Linear)'); hold on;
semilogy(1:length(err_s), err_s, 'b-s', 'LineWidth', 1.5, 'DisplayName', ...
    'Secant (Superlinear)');
semilogy(1:length(err_n), err_n, 'r-^', 'LineWidth', 1.5, 'DisplayName', ... 
    'Newton (Quadratic)');

grid on;
title('Convergence Speed Comparison');
xlabel('Iteration Number');
ylabel('Absolute Error (Log Scale)');
legend('Location', 'best');
subtitle('Steeper slope indicates faster convergence');