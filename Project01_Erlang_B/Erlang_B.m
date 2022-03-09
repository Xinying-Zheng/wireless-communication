
% Erlang B formula : Blocking Prob. 
% - B(rho, m)= (rho^m)/(m!*\sum^m_{k=0}(rho^k/k!))
% if we compute B by above equation, the result will overflow in large m
% the approach is change the equation into recursive form (ref. folk theorem)
% B_{m+1}=(B_m*(rho/m))/(1+B_m*(rho/m)) , B_0=1......(1)

function [ B ] = Erlang_B( m,rho )
    B=1;
    for i=1:m
        B=(rho*B/i)/(1+rho*B/i);
    end
end

% If we want to driver the recursive form. we can first write the equation of B{m+1} and B{m}
% Then we subtute the B{m} into numberator of B{m+1} the we can compute the numberator and denominator.
% and we can obtain the equation (1).


