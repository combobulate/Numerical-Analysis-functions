function [fp, history] = fixed_point_iteration(g, p0, max_iterations, abs_tol)
%% FIXED_POINT_ITERATION Finds a fixed point for g near p0
%   Input parameters:
%       g: a function handle
%       p0: a starting value to obtain the fixed point. g should be
%       continuous upon a reasonable interval containing both p0 and the
%       fixed point. p0 should be some value in the image for g.
%       max_iterations: the largest number of iterations which will be
%       attempted for finding the fixed point
%       abs_tol: the tolerance given for error of an acceptable fixed
%       point, allowing for an earlier stopping point than max_iterations
%
%   Output parameters:
%       fp: the fixed point
%       history: 2 x n matrix. Row 1 is p_n-1, row 2 is g(p_n-1), n is the
%       number of iterations. The first column is then p0 and p1=g(p0), one
%       iteration. This is a bit redundant due to the particular algorithm
%       used here.
    
    p_curr = p0;
    history = zeros(2, max_iterations);
    
    for i = 1:max_iterations
        % Useful for troubleshooting:
        % fprintf('iteration %d: p = %f\n', i, p_curr);
        
        % Gracefully handle where the function is not continuous where it
        % is hoped to be
        try
            p_next = g(p_curr);
        catch
            fprintf('Error: g is not continuous at %f\n(encountered after %d iterations)\n', p_curr, i);
            return;
        end
        
        % Stopping criteria:
        % Check how close this new point is to being a fixed point.
        abs_err_limit_1 = abs(p_next - g(p_next));
        
        % Check how close this new point is to the previous one. For this
        % particular algorithm, this also happens to redundantly check what
        % was abs_err_limit_1 in the previous iteration, so it's only
        % actually useful on the first iteration.
        abs_err_limit_2 = abs(p_curr - p_next);
        
        % Whichever is lower, if it's less than the given tolerance, take
        % the current value 
        if min(abs_err_limit_1, abs_err_limit_2) <= abs_tol
            history(1,i) = p_curr;
            history(2,i) = p_next;
            % Get rid of unused part of history
            history = history(:, 1:i); 
            fp = p_next;
            return;
        end
        
        history(1,i) = p_curr;
        history(2,i) = p_next;
        p_curr = p_next;
    end
end

