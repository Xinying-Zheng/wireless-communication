clear

N=1001;
fmT=0.01;
M=8;
[ g_01_8,Rx_01_8,Rx_01_8_theory ] = sum_of_sinusoids( N,M,fmT );
M=16;
[ g_01_16,Rx_01_16,Rx_01_16_theory ] = sum_of_sinusoids( N,M,fmT );
fmT=0.1;
[ g_1_16,Rx_1_16,Rx_1_16_theory ] = sum_of_sinusoids( N,M,fmT );
M=8;
[ g_1_8,Rx_1_8,Rx_1_8_theory ] = sum_of_sinusoids( N,M,fmT );
fmT=0.5;
[ g_5_8,Rx_5_8,Rx_5_8_theory ] = sum_of_sinusoids( N,M,fmT );
M=16;
[ g_5_16,Rx_5_16,Rx_5_16_theory ] = sum_of_sinusoids( N,M,fmT );

%=================================fmT=0.01=================================
figure(1)
plot(0:300,10*log10(abs(g_01_8(1:301))));
title('Envelope (fmT=0.01)')
xlabel('Time,t/T')
ylabel('Envelope Level(dB)')
grid on
h=getframe(1);
imwrite(h.cdata,'018.png');
fmT=0.01;
a=0:fmT:10;
figure(2)
plot(a,Rx_01_8,a,Rx_01_8_theory,'--');
title('Autocorrelation (fmT=0.01)')
xlabel('Time Delay,fm£n')
ylabel('Autocorrelation,£p(£n)');
legend('simulation','theory','simulation');
grid on
h=getframe(2);
imwrite(h.cdata,'018_auto.png');
figure(3)
plot(0:300,10*log10(abs(g_01_16(1:301))));
title('Envelope (fmT=0.01)')
xlabel('Time,t/T')
ylabel('Envelope Level(dB)')
grid on
h=getframe(3);
imwrite(h.cdata,'0116.png');
a=0:fmT:10;
figure(4)
plot(a,Rx_01_16,a,Rx_01_16_theory,'--');
title('Autocorrelation (fmT=0.01)')
xlabel('Time Delay,fm£n')
ylabel('Autocorrelation,£p(£n)');
legend('simulation','theory','simulation');
grid on
h=getframe(4);
imwrite(h.cdata,'0116_auto.png');

%=================================fmT=0.1=================================
figure(5)
plot(0:300,10*log10(abs(g_1_8(1:301))));
title('Envelope (fmT=0.1)')
xlabel('Time,t/T')
ylabel('Envelope Level(dB)')
grid on
h=getframe(5);
imwrite(h.cdata,'18.png');
fmT=0.1;
a=0:fmT:10;
figure(6)
plot(a,Rx_1_8,a,Rx_1_8_theory,'--');
title('Autocorrelation (fmT=0.1)')
xlabel('Time Delay,fm£n')
ylabel('Autocorrelation,£p(£n)');
legend('simulation','theory','simulation');
grid on
h=getframe(6);
imwrite(h.cdata,'18_auto.png');
figure(7)
plot(0:300,10*log10(abs(g_1_16(1:301))));
title('Envelope (fmT=0.1)')
xlabel('Time,t/T')
ylabel('Envelope Level(dB)')
grid on
h=getframe(7);
imwrite(h.cdata,'116.png');
a=0:fmT:10;
figure(8)
plot(a,Rx_1_16,a,Rx_1_16_theory,'--');
title('Autocorrelation (fmT=0.1)')
xlabel('Time Delay,fm£n')
ylabel('Autocorrelation,£p(£n)');
legend('simulation','theory','simulation');
grid on
h=getframe(8);
imwrite(h.cdata,'116_auto.png');

%=========================================================================
figure(9)
plot(0:300,10*log10(abs(g_5_8(1:301))));
title('Envelope (fmT=0.5)')
xlabel('Time,t/T')
ylabel('Envelope Level(dB)')
grid on
h=getframe(9);
imwrite(h.cdata,'58.png');
fmT=0.5;
a=0:fmT:10;
figure(10)
plot(a,Rx_5_8,a,Rx_5_8_theory,'--');
title('Autocorrelation (fmT=0.5)')
xlabel('Time Delay,fm£n')
ylabel('Autocorrelation,£p(£n)');
legend('simulation','theory','simulation');
grid on
h=getframe(10);
imwrite(h.cdata,'58_auto.png');
figure(11)
plot(0:300,10*log10(abs(g_5_16(1:301))));
title('Envelope (fmT=0.5)')
xlabel('Time,t/T')
ylabel('Envelope Level(dB)')
grid on
h=getframe(11);
imwrite(h.cdata,'516.png');
a=0:fmT:10;
figure(12)
plot(a,Rx_5_16,a,Rx_5_16_theory,'--');
title('Autocorrelation (fmT=0.5)')
xlabel('Time Delay,fm£n')
ylabel('Autocorrelation,£p(£n)');
legend('simulation','theory','simulation');
grid on
h=getframe(12);
imwrite(h.cdata,'516_auto.png');