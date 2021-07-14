function [ r_tilde,Rx,Rx_theory ] = filtered_Gaussian( N,fmT )
%   filtered_Gaussian
ohm_p=2;
zeta=2-cos(pi*fmT/2)-sqrt((2-cos(pi*fmT/2))^2-1);
sigma=sqrt((1+zeta)/(1-zeta)*ohm_p/2);
w_i=sigma*randn(1,N);
w_q=sigma*randn(1,N);
g_i(1)=0;
g_q(1)=0;
for i=1:N
    % shift (different path) and add the guassian noise
    g_i(i+1)=zeta*g_i(i)+(1-zeta)*w_i(1,i);
    g_q(i+1)=zeta*g_q(i)+(1-zeta)*w_q(1,i);
end
% generate entire signal
r_tilde=g_i+j*g_q;
% autocorr of simulate
Rx=autocorr(r_tilde(2:N+1),10/fmT);
% autocorr of theory
for fm_tau=0:fmT:10
    delta=round(fm_tau/fmT);
    Rx_theory(delta+1)=(sigma^2*(1-zeta)/(1+zeta)).*zeta.^(fm_tau/fmT);
end

end

