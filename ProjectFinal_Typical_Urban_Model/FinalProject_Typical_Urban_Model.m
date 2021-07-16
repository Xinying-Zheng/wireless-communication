% Implement the Reduced Typical Urban (TU) Model with modification 
% (Doppler Spectrum: CLASS, GAUS1 and GAUS2; M = 16)
% Input parameters:
% Doppler spectrum parameters: a1, v11, v21, a2, v12, v22
% MS velocity
% 6 taps power delay profiles, ¡Ë

clc
clear all;
close all

%% set parameters
ClASS=zeros(3,30000);
GAUS1=zeros(1,30000);
GAUS2=zeros(2,30000);
CLASS1=zeros(3,30000);
M=16;
t=0:0.001:30;
Normal=zeros(1,6);
% generate Hadamard matrix which columns are orthogonal (-1,1)
Hadamard_Trans=hadamard(M);
GAUS11=zeros(1,30000);
GAUS21=zeros(2,30000);
% in this project I used the 6 tap,the tap1, tap 2 and tap3 for CLASS, the tap4 for GAUS1 ,tap5 and tap6 for GAUS2 
piont=sqrt([0.189 0.379 0.239 0.095 0.061 0.037]);

%% run the CLASS model
for Tap=1:3   %tap 1~3 is CLASS
    for a=1:30000
        for M_num=1:M
            beta=pi*M_num/17+(2*pi*(Tap-1)*M_num/17);
            gamma=2*pi*M_num/(2*(2*16+1));   
            fc3=2^(3/2)*Hadamard_Trans(Tap,M_num)*(cos(pi*M_num/17)+1i*sin(pi*M_num/17))*cos(2*pi*120*0.01*cos(gamma)*t(1,a)+beta);
	    % summation over M
            ClASS(Tap,a)=fc3+ClASS(Tap,a);
        end
    end
    gu=sqrt(mean(ClASS(Tap,:).*conj(ClASS(Tap,:))));
    CLASS1(Tap,:)=(ClASS(Tap,:)/gu)*piont(Tap);
    Normal(Tap)=mean(CLASS1(Tap,:).*conj(CLASS1(Tap,:)));
end
%plot the autocorrelation,time domain fading gain and power spectral density of CLASS modle
Autoc_CLASS=autocorr(ClASS(2,:),4999);
figure;
plot(Autoc_CLASS);         
title('Autocorrelation-CLASS');

Gain_CLASS=log10(abs(ClASS(2,:)));
figure;
plot(Gain_CLASS);  
title('Time-domain Fading Gain-CLASS');


psd_CLASS=fft([Autoc_CLASS(1:3000),zeros(1,4999-3000)],4999);   
figure;
plot(linspace(-1,1,length(psd_CLASS)),abs(psd_CLASS));  
title('Power Spectral Density-CLASS');

%% run the GAUS1 modle
Vx=linspace(-1,1,16);
Vx(2:end-1) = Vx(2:end-1)+Vx(2:end-1).*unifrnd(-1,1,1,14)*1e-2;
r1=6.649*exp(-0.5*(Vx+0.8).^2/(0.05^2));
r2=0.6649*exp(-0.5*(Vx-0.4).^2/(0.1^2));
%combine 
B1=r1+r2;

Tap=4; %tap4 is GAUS1
for a=1:30000
    for M_num=1:16
        fc4=sqrt(B1(M_num))*exp(1i*(2*pi*120*Vx(M_num)*(t(a)+300)));
        GAUS1(1,a)=fc4+GAUS1(1,a);
    end
    gu=sqrt(mean(GAUS1(1,:).*conj(GAUS1(1,:))));
    GAUS11(1,:)=(GAUS1(1,:)/gu)*piont(Tap);
    Normal(Tap)=mean(GAUS11(1,:).*conj(GAUS11(1,:)));
end

%plot the autocorrelation,time domain fading gain and power spectral density of GAUS1 modle
Autoc_GAUS1=autocorr(GAUS1(1,:),1499);   
figure;
plot(Autoc_GAUS1(1:40));                
title('Autocorrelation-GAUS1');


Gain_GAUS1=log10(abs(GAUS1(1,:)));
figure;
plot(Gain_GAUS1);         
title('Time-domain Fading Gain-GAUS1');


psd_GAUS1=fft([Autoc_GAUS1(1:35),zeros(1,1500-35)],1500);    
figure;
plot(linspace(-4,4,length(psd_GAUS1)),abs(fftshift(psd_GAUS1))); 
title('Power Spectral Density-GAUS1');

%% run the GAUS2 modle

r1=3.8*exp(-0.5*(Vx-0.7).^2/(0.1^2));
r2=(3.8/(10^1.5))*exp(-0.5*(Vx+0.4).^2/(0.15^2));
D=[0 30];
Vx=linspace(-1,1,16);
Vx(2:end-1) = Vx(2:end-1)+Vx(2:end-1).*unifrnd(-1,1,1,14)*1e-2;
%combine 
i2=r1+r2;

for Tap=5:6 %tap5,6 is GAUS2
    for a=1:30000
        for M_num=1:16
            fc5=sqrt(i2(M_num))*exp(1i*(2*pi*120*Vx(M_num)*(t(a)+D(Tap-4))));
            GAUS2(Tap-4,a)=fc5+GAUS2(Tap-4,a);
        end
    end
    gu=sqrt(mean(GAUS2(Tap-4,:).*conj(GAUS2(Tap-4,:))));
    GAUS21(Tap-4,:)=(GAUS2(Tap-4,:)/gu)*piont(Tap);
    Normal(Tap)=mean(GAUS21(Tap-4,:).*conj(GAUS21(Tap-4,:)));
end

%plot the autocorrelation,time domain fading gain and power spectral density of GAUS2 modle
Autoc_GAUS2=autocorr(GAUS2(2,:),2099);  
figure;
plot(Autoc_GAUS2(1:40));                
title('Autocorrelation-GAUS2');

Gain_GAUS2=log10(abs(GAUS2(2,:)));
figure;
plot(Gain_GAUS2);             
title('Time-domain Fading Gain-GAUS2');

psd_GAUS2=fft([Autoc_GAUS2(1:35),zeros(1,2100-35)],2100); %power spectral density is the FFT of time domain signal     
figure;plot(linspace(-4,4,length(psd_GAUS2)),abs(fftshift(psd_GAUS2))); 
title('Power Spectral Density-GAUS2');

%plot the fraction of power of 6ray Typical Urban 
a=1:6; %for 1~6 tap
o=[0 0.2 0.5 1.6 2.3 5];
figure;

stem(o(a),Normal(a));
title('Typical Urban(TU)(6-rays)');
