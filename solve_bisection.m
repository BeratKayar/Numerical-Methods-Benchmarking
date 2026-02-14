function [root, iter, err_history] = solve_bisection(f, a, b, tol, max_iter)
% SOLVE_BISECTION finds the root of f(x) = 0 using Bisection method.
%
% Inputs
%   f           - Function handle
%   a, b        - Interval limits [a, b]
%   tol         - Tolerance
%   max_iter    - Max iterations
%
% Outputs
%   root        - Estimated root
%   iter        - Number of iterations
%   err_history - Saves errors
%
% Author: Kayar Berat

    % Check if the function changes sign over the interval (Darboux theorem)
    if f(a) * f(b) > 0
        error('Function must have different signs at the interval endpoints (f(a)*f(b) < 0).');
    end

    iter = 0;
    err_history = [];
    
    while iter < max_iter
        iter = iter + 1;
        
        c = (a + b) / 2;
        
        % Error estimate for Bisection is half the interval width
        current_error = (b - a) / 2; 
        err_history(iter) = current_error;
        
        if abs(f(c)) < tol || current_error < tol
            root = c;
            return;
        end
        
        if f(c) * f(a) < 0
            b = c;
        else
            a = c;
        end
    end
    
    root = (a + b) / 2;
    warning('Maximum iterations reached in Bisection method.');
end