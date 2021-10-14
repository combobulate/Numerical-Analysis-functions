function [root, approximations] = bisection(func, a, b, iterations)
%BISECTION Find a root of the function func between points a and b
%   Input parameters:
%       func - a function handle
%       a, b - bounds of a real interval [a, b]
%       iterations - number of iterations to run. Must have at least one
%           iteration in order to find a midpoint. This is a terrible
%           estimate though; needs at least 4 iterations for at least one
%           decimal place of precision
%   Outputs:
%       root - the midpoint found after the indicated number of iterations,
%           presumed to be the root within some bound of accuracy
%       approximations - array of midpoints found after each iteration

%   Do some preliminary error analysis to avoid the wrong kind of math
%   problems:
%   Make sure the interval for finding the root was input with a<b. Don't fix,
%   just reject.
    if ~(a<b)
        fprintf('Error: a = %f is greater than or equal to b = %f\n', a, b);
        return;
    end
    funca = func(a);
    funcb = func(b);
%   Make sure a root is guaranteed in the input interval based on IVT.
    if sign(funca) == sign(funcb)
        fprintf('Error: same signs, f(a) = %f, f(b) = %f\n', funca, funcb);
        return;
    end
%   Also make sure we don't have a root already:
    if funca == 0
        fprintf('Error: f(a) = 0, already a root\n');
        return;
    elseif funcb == 0
        fprintf('Error: f(b) = 0, already a root\n');
        return;
    end
%   Check for sufficient iterations to initialize the midpoint
    if iterations < 1
        fprintf('Error: at least one iteration required to find a midpoint\n');
        return;
    end
    
%   For each iteration: get a midpoint, check the sign of the function at
%   that midpoint, and compare to the sign at the bounds of the current
%   interval. The half of the current interval which has differing signs
%   definitely crosses zero, so use that for the next iteration.
    approximations = zeros(1, iterations);
    for iter = 1:iterations
        mid = (a + b)/2;
        fMid = func(mid);
        if sign(fMid) == sign(func(a))
            a = mid;
        else
            b = mid;
        end
        approximations(iter) = mid;
    end
    root = mid;
end

