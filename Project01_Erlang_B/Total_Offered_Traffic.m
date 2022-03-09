clc
clear

% Implement the Erlang-B formula, and calculate the total offered traffic
% load for the following system parameters: load for the following system parameters:
% – Channel number: 1~20, 200~220
% – Blocking rate: 1%, 3%, 5%, 10%
% | function Erlang_B : given channel number and total offered traffic to compute blocking rate
% | function inv_Erlang_B: given channel number and blocking rate and compute total offered traffic
% -----------Question-------------
% (a) Could it be possible that the total offered traffic load is larger than
% the number of available channels? Why?
% It is possible, because the total offered traffic contain the blocking traffic, which not actually used.
% (b) How to determine the traffic that has been served?
% The served traffic equal to ( 1-blocking rate )* total_offered_traffic

br=[0.01 0.03 0.05 0.1];
for i=1:4;
    for m=1:20
        rho(m,i)=inv_Erlang_B(m,br(i));
        rho_served(m,i)=inv_Erlang_B(m,br(i))*(1-br(i));
    end
    for n=1:21
        rho_200(n+199,i)=inv_Erlang_B(n+199,br(i));
        rho_200_served(n+199,i)=inv_Erlang_B(n+199,br(i))*(1-br(i));
    end
end
m=1:20;
figure(1)
plot(m,rho(:,1),m,rho(:,2),'--o',m,rho(:,3),'--',m,rho(:,4),'--*');
title('total offered traffic for different blocking rate')
xlabel('total number of channels')
ylabel('total offered traffic (Erlangs)')
grid on
legend('blocking rate:1%','blocking rate:3%','blocking rate:5%','blocking rate:10%')

figure(2)
plot(m,rho_served(:,1),m,rho_served(:,2),'--o',m,rho_served(:,3),'--',m,rho_served(:,4),'--*');
title('total served traffic for different blocking rate')
xlabel('total number of channels')
ylabel('total served traffic (Erlangs)')
grid on
legend('blocking rate:1%','blocking rate:3%','blocking rate:5%','blocking rate:10%')

n=200:220;

figure(3)
plot(n,rho_200(200:220,1),n,rho_200(200:220,2),'--o',n,rho_200(200:220,3),'--',n,rho_200(200:220,4),'--*');
title('total offered traffic for different blocking rate')
xlabel('total number of channels')
ylabel('total offered traffic (Erlangs)')
grid on
legend('blocking rate:1%','blocking rate:3%','blocking rate:5%','blocking rate:10%')

figure(4)
plot(n,rho_200_served(200:220,1),n,rho_200_served(200:220,2),'--o',n,rho_200_served(200:220,3),'--',n,rho_200_served(200:220,4),'--*');
title('total served traffic for different blocking rate')
xlabel('total number of channels')
ylabel('total served traffic (Erlangs)')
grid on
legend('blocking rate:1%','blocking rate:3%','blocking rate:5%','blocking rate:10%')
