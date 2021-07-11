
% using bisection approach to approximate the inverse solution

function [ rho ] = inv_Erlang_B( m,B )
    num=0;
    rho_min = 0;
    rho_max = m*2;
    B_guess=1;
    while abs(B_guess - B) > 0.00001
        rho_guess=(rho_min+rho_max)/2;
        B_guess = Erlang_B(m, rho_guess);
        if(B_guess>B)
            rho_max=rho_guess;
        else
            rho_min=rho_guess;
        end
        num=num+1;
    end
    rho=rho_guess;
end

