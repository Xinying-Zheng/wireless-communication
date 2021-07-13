clear

N=100000;   % number of sampling
n=0:300;   % t/T times
fmT=0.01;
[r1,Rx1,Rx1_t]=filtered_Gaussian(N,fmT);
fmT=0.1;
[r2,Rx2,Rx2_t]=filtered_Gaussian(N,fmT);
fmT=0.5;
[r3,Rx3,Rx3_t]=filtered_Gaussian(N,fmT);


%-----------plot the figure-----------------%
figure(1)
plot(n,10*log10(abs(r1(n+1))))
title('Envelope (fmT=0.01)')
xlabel('Time,t/T')
ylabel('Envelope Level(dB)')
grid on
h=getframe(1);
imwrite(h.cdata,'fmT001_envelop.png');
fmT=0.01;
m=0:10/fmT;
figure(2)
plot(m*fmT,Rx1);hold on;
plot(m*fmT,Rx1_t,'--');
title('Autocorrelation (fmT=0.01)')
xlabel('Time Delay,fm£n')
ylabel('Autocorrelation,£p(£n)');
legend('simulation','theory')
grid on
h=getframe(2);
imwrite(h.cdata,'fmT001_auto.png');


figure(3)
plot(n,10*log10(abs(r2(n+1))))
title('Envelope (fmT=0.1)')
xlabel('Time,t/T')
ylabel('Envelope Level(dB)')
grid on
h=getframe(3);
imwrite(h.cdata,'fmT01_envelop.png');
fmT=0.1;
m=0:10/fmT;
figure(4)
plot(m,Rx2(1:10/fmT+1));hold on;
plot(m,Rx2_t(1:10/fmT+1),'--');
title('Autocorrelation (fmT=0.1)')
xlabel('Time Delay,fm£n')
ylabel('Autocorrelation,£p(£n)');
legend('simulation','theory')
grid on
h=getframe(4);
imwrite(h.cdata,'fmT01_auto.png');


figure(5)
plot(n,10*log10(abs(r3(n+1))))
title('Envelope (fmT=0.5)')
xlabel('Time,t/T')
ylabel('Envelope Level(dB)')
grid on
h=getframe(5);
imwrite(h.cdata,'fmT05_envelop.png');
fmT=0.5;
m=0:10/fmT;
figure(6)
plot(m,Rx3(1:10/fmT+1));hold on;
plot(m,Rx3_t(1:10/fmT+1),'--');
title('Autocorrelation (fmT=0.5)')
xlabel('Time Delay,fm£n')
ylabel('Autocorrelation,£p(£n)');
legend('simulation','theory')
grid on
h=getframe(6);
imwrite(h.cdata,'fmT05_auto.png');
