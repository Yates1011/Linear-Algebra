%% givensRotation 
% A function to perform Given rotation
% Algorithm 5.1.3, p. 216, Golub & Van Loan, Matrix Computations, 3rd edition
function [c, s] = givensRotation(a,b)
    if b == 0
        c = 1;
        s = 0;
    else
        if abs(b) > abs(a)
            tau = -a/b;
            s = 1/sqrt(1+tau^2);
            c = s * tau;
        else
            tau = -b/a;
            c = 1/sqrt(1+tau^2);
            s = c * tau;
        end
    end
end % givensRotation
