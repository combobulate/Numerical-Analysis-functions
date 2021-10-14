function f = linear_spline(xs, fs, x)
    %LINEAR_SPLINE interpolates f(x) for a particular x when a
    %   range of other (x, f(x)) values are known, but the function itself 
    %   is not known. This interpolated value is given by
    %       f(x) = f(x_1) + b_1(x - x_1)      if x_0 <= x < x_1
    %               ...
    %              f(x_n) + b_n(x - x_n)      if x_{n-1} <= x <= x_n
    %       b_i = [f(x_i) - f(x_{i-1})]/[x_i - x_{i-1}]
    %
    %   INPUT PARAMETERS:
    %       xs = row vector of ascending x values for which f(x) is known
    %       fs = row vector of the corresponding f(x) values
    %       x = scalar or row vector of ascending x value or values to
    %           interpolate
    %   
    %   OUTPUT PARAMETERS:
    %       f = scalar or row vector of interpolated f(x) value or values
    
    if (size(xs,1) ~= 1) || size(xs,2) == 1
        error('xs is not a row vector.');
    elseif (size(fs, 1) ~= 1) || size(fs,2) == 1
        error('fs is not a row vector.');
    elseif size(fs, 2) ~= size(xs, 2)
        error('xs and fs have different numbers of points.');
    elseif size(x,1) ~= 1
        error('x is not a scalar or row vector.')
    elseif ~issorted(xs)
        error('xs is not sorted.')
    end
    
    f = zeros(1, length(x));
    xsl = length(xs);
    xl = length(x);
    
    if length(x) == 1
        for i = 2:xsl
            if (xs(i-1) <= x && x < xs(i)) || x == x(xsl)
                f = fs(i) + (x - xs(i))*(fs(i) - fs(i-1))/(xs(i) - xs(i-1));
            end
        end
    else
        % By restricting input to sorted xs and x arrays, we can more
        % efficiently interpolate. For each interval in xs, interpolate x
        % values until you're out of bounds, then move on to the next
        % interval of xs.
        
        xpos = 1;
        for i = 2:xsl
            while xpos <= xl && ((xs(i-1) <= x(xpos) && x(xpos) < xs(i)) || x(xpos) == xs(xsl))
                f(xpos) = fs(i) + (x(xpos) - xs(i))*(fs(i) - fs(i-1))/(xs(i) - xs(i-1)); 
                xpos = xpos + 1;
            end
        end
    end
end

