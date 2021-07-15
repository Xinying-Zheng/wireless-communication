clear
clc

Es=1;
index=1;
x_r=[1 1 -1 -1];
x_i=[1 -1 1 -1];
QPSK_c=sqrt(1/2)*(x_r+j*x_i);
N=10e4;

for L=1:1:4
    index=1;
    for SNR=1:2:9
        count=zeros(4,1);        
        for k=1:N
            R_diversity=zeros(4,1);
	    %1.Selective Combining 2.Maximal Ratio Combining 
	    %3.Euqual Gain Combining 4.Direct Combining
            % generating random bits
            S=round(rand(1,2));
            % QPSK mapping
            decimal=S(1)*2+S(2);
            C=QPSK_c(decimal+1);
            
            mean_fading=1;
            K=1;
            N0_fading=K*mean_fading^2;
            N0=(mean_fading^2+N0_fading)*Es/(10^((SNR+10*log10(2))/10));            
            for L2=1:1:L
                % Ricean fading channel
                G=(mean_fading+j*mean_fading)+sqrt(N0_fading/2)*(randn(1)+j*randn(1));
                % AWGN channel        
                Z=sqrt(N0/2)*(randn(1)+j*randn(1));
                R=G*C+Z;
                if(abs(conj(G).*R)>=abs(R_diversity(1)))
                    R_diversity(1)=conj(G).*R;
                end
                R_diversity(2)=R_diversity(2)+conj(G)*R;
                R_diversity(3)=R_diversity(3)+conj(G)*R/abs(G);
                R_diversity(4)=R_diversity(4)+R;
            end
            for i=1:4                
                % MD detection
                [H1,I]=min(QPSK_c-R_diversity(i));
                decimal=I(1)-1;
                % demapping
                if(decimal==0)
                    bits=[0 0];
                elseif(decimal==1)
                    bits=[0 1];
                elseif(decimal==2)
                    bits=[1 0];
                else
                    bits=[1 1];
                end
                %count errors
                count(i)=count(i)+sum(abs(S-bits));
            end
        end    
        BER(:,index,L)=count./(N*2);
        index=index+1;
    end
end
snr=1:2:9;
figure(2)
subplot(221)
semilogy(snr,BER(1,:,1),'-o',snr,BER(1,:,2),'-x',snr,BER(1,:,3),'-d',snr,BER(1,:,4),'-s');
grid on;
title('Selective Combining(Ricean)');
xlabel('SNR(dB)');
ylabel('BER');
legend('L=1','L=2','L=3','L=4');
ylim([10^-4 10^0])

subplot(222)
semilogy(snr,BER(2,:,1),'-o',snr,BER(2,:,2),'-x',snr,BER(2,:,3),'-d',snr,BER(2,:,4),'-s');
grid on;
title('Maximal Ratio Combining(Ricean)');
xlabel('SNR(dB)');
ylabel('BER');
legend('L=1','L=2','L=3','L=4');
ylim([10^-4 10^0])

subplot(223)
semilogy(snr,BER(3,:,1),'-o',snr,BER(3,:,2),'-x',snr,BER(3,:,3),'-d',snr,BER(3,:,4),'-s');
grid on;
title('Equal Gain Combining(Ricean)');
xlabel('SNR(dB)');
ylabel('BER');
legend('L=1','L=2','L=3','L=4');
ylim([10^-4 10^0])

subplot(224)
semilogy(snr,BER(4,:,1),'-o',snr,BER(4,:,2),'-x',snr,BER(4,:,3),'-d',snr,BER(4,:,4),'-s');
grid on;
title('Direct Combining(Ricean)');
xlabel('SNR(dB)');
ylabel('BER');
legend('L=1','L=2','L=3','L=4');
ylim([10^-4 10^0])

set(gcf,'Position',[400 150 1050 800])
h=getframe(2);
imwrite(h.cdata,'ricean.png');