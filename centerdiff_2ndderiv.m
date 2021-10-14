function us = centerdiff_2ndderiv(fs, h)

    N = length(fs);
    
    if N <= 1
        error('Need at least 2 points');
    end
    
    A = 2*eye(N) + diag(-1*ones(1,N-1),1) + diag(-1*ones(1,N-1),-1);
    us = A\((h^2)*fs');
end

