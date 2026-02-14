function [root, iter, err_history] = solve_secant(f, x0, x1, tol, max_iter)
% SOLVE_SECANT finds the root of f(x) = 0 using Secant method.
%
% Inputs:
%   f           - Function handle
%   x0, x1      - Two initial guesses
%   tol         - Tolerance
%   max_iter    - Max iterations
%
% Outputs:
%   root        - Estimated root
%   iter        - Number of iterations
%   err_history - Saves errors
%
% Author: Kayar Berat

    iter = 0;
    err_history = [];
    
    while iter < max_iter
        iter = iter + 1;
        
        y1 = f(x1);
        y0 = f(x0);
        
        % Prevent division by zero
        if abs(y1 - y0) < 1e-10
            warning('Denominator is too small. Secant method might fail.');
            break;
        end
        % Secant Formula: x_next = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
        x_next = x1 - y1 * (x1 - x0) / (y1 - y0);
        
        current_error = abs(x_next - x1);
        err_history(iter) = current_error;
        
        if current_error < tol
            root = x_next;
            return;
        end
        % Update points for next iteration
        x0 = x1;
        x1 = x_next;
    end
    
    root = x1;
    warning('Maximum iterations reached in Secant method.');
end