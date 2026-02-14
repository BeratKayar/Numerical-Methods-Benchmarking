function [root, iter, err_history] = solve_newton(f, df, x0, tol, max_iter)
% SOLVE_NEWTON finds the root of f(x) = 0 using Newton-Raphson method.
%
% Inputs
%   f           - Function handle (e.g., @(x) x^2 - 4)
%   df          - Derivative function handle (e.g., @(x) 2*x)
%   x0          - Initial guess
%   tol         - Tolerance for stopping criterion (absolute error)
%   max_iter    - Maximum number of iterations allowed
%
% Outputs
%   root        - Estimated root
%   iter        - Number of iterations performed
%   err_history - Saves errors
%
% Author: Kayar Berat

    % Input Validation (Using 'error')
    if max_iter <= 0
        error('Maximum iterations must be a positive integer.');
    end

    x_curr = x0;
    iter = 0;
    err_history = []; % Array to store error at each step
    
    while iter < max_iter
        iter = iter + 1;
        
        y = f(x_curr);
        dy = df(x_curr);
        
        % Safety check for zero derivative (Using 'warning')
        if abs(dy) < 1e-10
            warning('Derivative is too close to zero. The method might diverge.');
            break;
        end
        
        % Newton-Raphson Step
        x_next = x_curr - y/dy;
        
        % Calculate and store error
        current_error = abs(x_next - x_curr);
        err_history(iter) = current_error;
        
        % Check convergence
        if current_error < tol
            root = x_next;
            return;
        end
        
        x_curr = x_next;
    end
    
    root = x_curr;
    warning('Maximum iterations reached without full convergence.');
end