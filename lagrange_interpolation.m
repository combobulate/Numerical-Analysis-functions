function f = lagrange_interpolation(xs, fs, x)
    %LAGRANGE_INTERPOLATION interpolates f(x) for a particular x when a
    %   range of other (x, f(x)) values are known, but the function itself 
    %   is not known. This interpolated value is given by
    %       f(x) = sum_i(L_i(x)*f(x_i))
    %       L_i(x) =    (x-x_0)...(x-x_{i-1})(x-x_{i+1})(x-x_n)
    %                -----------------------------------------------
    %                (x_i-x_0)...(x_i-x_{i-1})(x_i-x_{i+1})(x_i-x_n)
    %
    %   INPUT PARAMETERS:
    %       xs = row vector of x values for which f(x) is known
    %       fs = row vector of the corresponding f(x) values
    %       x = scalar or row vector of x value or values to interpolate
    %   
    %   OUTPUT PARAMETERS:
    %       f = scalar or row vector of interpolated f(x) value or values
    
    if (size(xs,1) ~= 1) || size(xs,2) == 1
        error('xs is not a row vector.');
    elseif (size(fs, 1) ~= 1) || size(fs,2) == 1
        error('fs is not a row vector.');
    elseif size(fs, 2) ~= size(xs, 2)
        error('xs and fs have different numbers of points.');
    elseif (size(x,1) ~= 1)
        error('x is not a scalar or row vector.')
    end
    
    n = length(xs);
    L = zeros(length(x), n-1);
    for k = 0:n-1
        sub = [xs(1:k) xs(k+2:n)];
        num = x'-sub;
        dnm = xs(k+1)-sub;
        L(:,k+1) = prod(num,2)/prod(dnm);
    end
    
    f = (sum(fs.*L, 2))';
end

