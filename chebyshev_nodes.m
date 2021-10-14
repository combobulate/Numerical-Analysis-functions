function nodes = chebyshev_nodes(a, b, n)
    %CHEBYSHEV_NODES creates an array of n Chebyshev nodes between a and b.
    %   These are unevenly spaced values on a real number line such that 
    %   they are closest together near the interval endpoints and furthest
    %   appart at the interval midpoint. These nodes allow for minimizing
    %   interpolation error when compared to evenly spaced nodes.
    %
    %   INPUT PARAMETERS:
    %       a = scalar; lower bound of interval in which to find nodes
    %       b = scalar; upper bound of interval in which to find nodes
    %       n = integer; number of nodes to find between a and b
    %   such that for the nodes x_i, 0<=i<=n:
    %       a < x_0 < x_1 < ... < x_n < b
    %   
    %   OUTPUT PARAMETERS:
    %   An array of n nodes.
    
    x = zeros(1,n);
    
    for i = 1:n
        x(i) = (b+a)/2 - ((b-a)/2) * cos (pi*(2*i-1)/(2*n));
    end
    
    nodes = x;
    
end

