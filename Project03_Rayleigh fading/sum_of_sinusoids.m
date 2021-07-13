function [ g,Rx,Rx_theory ] = sum_of_sinusoids( K,M,fmT )
%sum_of_sinusoids
N=4*M+2;
n=1:M;
fn=fmT*cos(2*pi*n/N);
beta_n=pi*n./M;
for t=0:K-1
    g_i(t+1)=sqrt(2)*(2*sum(cos(beta_n).*cos(2*pi*fn*t))+sqrt(2)*cos(0)*cos(2*pi*fmT*t));
    g_q(t+1)=sqrt(2)*(2*sum(sin(beta_n).*cos(2*pi*fn*t))+sqrt(2)*sin(0)*cos(2*pi*fmT*t));
end
g=g_i+j*g_q;
Rx=autocorr(g,10/fmT);
for fm_tau=0:fmT:10
    delta=round(fm_tau/fmT);
    Rx_theory(delta+1)=besselj(0,2*pi*fm_tau);
end
end

