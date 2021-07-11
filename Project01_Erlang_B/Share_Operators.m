clc
clear
% Assume that there are 600 channels equally shared by 1) one, 2) two, or 3) 
% three operators by using the frequency reuse factor N = 5.
% (a)Find the maximum offered traffic load per cell for the three cases
% with the blocking rate equal to 1%, 3%, 5%, or 10% maximum offered traffic load per cell for the 
% three cases with the blocking rate equal to 1%, 3%, 5%, or 10%
% (b)Which case (one, two, or three operators) is more efficient? 
% total=600; br=[0.01 0.03 0.05 0.1]; channel=[total/5 total/2/5 total/3/5];
% - one operator most efficient.

for i=1:4;
    for j=1:3
        rho(j,i)=inv_Erlang_B( channel(j), br(i) )*j;
        Gc(j,i)=rho(j,i)/j/channel(j);
    end
end


m=[1 2 3];
figure(1)
plot(m,rho(:,1),m,rho(:,2),'--o',m,rho(:,3),'--',m,rho(:,4),'--*') 
title('maximum offered traffic load per cell for different blocking rate')
xlabel('number of operators')
ylabel('total offered traffic (Erlangs)')
grid on
legend('blocking rate:1%','blocking rate:3%','blocking rate:5%','blocking rate:10%')

figure(2)
plot(m,Gc(:,1),m,Gc(:,2),'--o',m,Gc(:,3),'--',m,Gc(:,4),'--*') 
title('trunking efficiency for different blocking rate')
xlabel('number of operators')
ylabel('offered traffic per channel (Erlangs)')
grid on
legend('blocking rate:1%','blocking rate:3%','blocking rate:5%','blocking rate:10%')