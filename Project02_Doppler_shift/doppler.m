clear
clc
% % Consider that an MS with a velocity v receives an unmodulated
% carrier with a frequency carrier with a frequency fc The incidence angle theta(t) of the incoming 
% wave c. The incidence angle theta(t) of the incoming wave is assumed to be uniformly distributed 
% between –pi and pi. delta_f=0.01;
% --> f_D,n(t)=fm*cos(\theta_n*(t))
% if v=10 km/hr and fc=2 GHz , plot the distribution function (cdf) and probability density function  (pdf)

N=10000000;                 % number of simulation points;
v_c=3*10^8;                 % Speed of light
% (a)
v=20*1000/3600;             % km/hr -> m/s
fc=2*10^9;                  % carrier frequency
landa_c=v_c/fc;             % wavelength
fm=v/landa_c;               % maximum doppler shift
theta=(2*rand(1,N)-1).*pi;  % Uniform distribution form -pi to pi
fd=fm*cos(theta);           % Doppler shift

figure(1)
cdfplot(fd);
xlabel('Doppler Frequency (f)')
title('simulated cdf of doppler shift with v=20km/hr and fc=2GHz')
set(gcf,'Position',[600 250 750 500])
h=getframe(1);
imwrite(h.cdata,'s_20_cdf.png');

figure(12)
[n,a]=hist(fd,-40:delta_f:40);
plot(a,n/N);
xlabel('Doppler Frequency (f)')
ylabel('Probability')
title('simulated pdf of doppler shift with v=20km/hr and fc=2GHz')
grid on
set(gcf,'Position',[600 250 750 500])
h=getframe(12);
imwrite(h.cdata,'s_20_pdf.png');

% (b)
% if v=10 km/hr and fc=2 GHz, plot cdf and pdf
v=90*1000/3600;             % 90km/hr-> ? m/s
fc=26*10^9;                 % carrier frequency
landa_c=v_c/fc;             % wavelength
fm=v/landa_c;               % maximum doppler shift
theta=(2*rand(1,N)-1).*pi;  % Uniform distribution form -pi to pi
fd=fm*cos(theta);           % Doppler shift

figure(2)
cdfplot(fd);
xlabel('Doppler Frequency (f)')
title('simulated cdf of doppler shift with v=90km/hr and fc=26GHz')
set(gcf,'Position',[600 250 750 500])
h=getframe(2);
imwrite(h.cdata,'s_90_cdf.png');

figure(22)
[n,a]=hist(fd,-2200:delta_f:2200);
plot(a,n/N);
xlabel('Doppler Frequency (f)')
ylabel('Probability')
title('simulated pdf of doppler shift with v=90km/hr and fc=26GHz')
grid on
set(gcf,'Position',[600 250 750 500])
h=getframe(22);
imwrite(h.cdata,'s_90_pdf.png');

% (c) if fc=2 GHz and v is uniformly distributed between 20 km/hr and 90 km/hr
N=14000000;
v=(70*rand(1,N)+20)*1000/3600;  % 90km/hr-> ? m/s
fc=2*10^9;                      % carrier frequency
landa_c=v_c/fc;                 % wavelength
fm=v./landa_c;                  % maximum doppler shift
theta=(2*rand(1,N)-1).*pi;      % Uniform distribution form -pi to pi
fd=fm.*cos(theta);              % Doppler shift

figure(3)
cdfplot(fd);
xlabel('Doppler Frequency (f)')
title('simulated cdf of doppler shift with v=20~90km/hr and fc=2GHz')
set(gcf,'Position',[600 250 750 500])
h=getframe(3);
imwrite(h.cdata,'s_20_90_cdf.png');

figure(32)
[n,a]=hist(fd,-170:delta_f*10:170);
plot(a,n/N);
xlabel('Doppler Frequency (f)')
ylabel('Probability')
title('simulated pdf of doppler shift with v=20~90km/hr and fc=2GHz')
grid on
set(gcf,'Position',[600 250 750 500])
h=getframe(32);
imwrite(h.cdata,'s_20_90_pdf.png');

% (d)Derive the pdf and the pdf of the observed Doppler shift for fixed v and fc
theta=(-1:0.0000002:1).*pi;     % form -pi to pi
theta_all=(-1:0.0002:1).*pi;
v=20*1000/3600;                 % km/hr-> m/s
v2=90*1000/3600;
v_all=[20:0.05:90].*1000./3600;
fc=2*10^9;                      % carrier frequency
fc_2=26*10^9;
landa_c=v_c/fc;                 % wavelength
landa_c_2=v_c/fc_2;
fm=v/landa_c;                   % maximum doppler shift
fm_2=v2/landa_c_2;
fm_all=v_all./landa_c;
fd=fm*cos(theta);               % Doppler shift
fd_2=fm_2*cos(theta);
for i=1:70/0.05+1
    tmp=fm_all(i).*cos(theta_all);
    if i==1 
        tmp1=tmp;
    elseif i>1&& i<=200
        tmp1=[tmp1 tmp];
    elseif i==201
        tmp2=tmp;
    elseif i>201 && i<=400
        tmp2=[tmp2 tmp];
    elseif i==401
        tmp3=tmp;
    elseif i>401 && i<=600
        tmp3=[tmp3 tmp];
    elseif i==601
        tmp4=tmp;        
    elseif i>601 && i<=800
        tmp4=[tmp4 tmp];
    elseif i==801
        tmp5=tmp;        
    elseif i>801 && i<=1000
        tmp5=[tmp5 tmp];
    elseif i==1001
        tmp6=tmp;        
    elseif i>1001 && i<=1200
        tmp6=[tmp6 tmp]; 
    elseif i==1201
        tmp7=tmp;        
    else
        tmp7=[tmp7 tmp];        
    end
end
fd_all=[tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7];

figure(4)
N=10000000;
cdfplot(fd);
xlabel('Doppler Frequency (f)')
title('theoretical cdf of doppler shift with v=20km/hr and fc=2GHz')
set(gcf,'Position',[600 250 750 500])
h=getframe(4);
imwrite(h.cdata,'t_20_cdf.png');

figure(42)
[n,a]=hist(fd,-40:delta_f:40);
plot(a,n/10000001);
xlabel('Doppler Frequency (f)')
ylabel('Probability')
title('theoretical pdf of doppler shift with v=20km/hr and fc=2GHz')
grid on
set(gcf,'Position',[600 250 750 500])
h=getframe(42);
imwrite(h.cdata,'t_20_pdf.png');

figure(5)
cdfplot(fd_2);
xlabel('Doppler Frequency (f)')
title('theoretical cdf of doppler shift with v=90km/hr and fc=26GHz')
set(gcf,'Position',[600 250 750 500])
h=getframe(5);
imwrite(h.cdata,'t_90_cdf.png');

figure(52)
[n,a]=hist(fd_2,-2200:delta_f:2200);
plot(a,n/10000001);
xlabel('Doppler Frequency (f)')
ylabel('Probability')
title('theoretical pdf of doppler shift with v=90km/hr and fc=26GHz')
grid on
set(gcf,'Position',[600 250 750 500])
h=getframe(52);
imwrite(h.cdata,'t_90_pdf.png');


figure(6)
cdfplot(fd_all);
xlabel('Doppler Frequency (f)')
title('theoretical cdf of doppler shift with v=20~90km/hr and fc=2GHz')
set(gcf,'Position',[600 250 750 500])
h=getframe(6);
imwrite(h.cdata,'t_20_90_cdf.png');

figure(62)
[n,a]=hist(fd_all,-170:delta_f*10:170);
plot(a,n/14011401);
xlabel('Doppler Frequency (f)')
ylabel('Probability')
title('theoretical pdf of doppler shift with v=20~90km/hr and fc=2GHz')
grid on
set(gcf,'Position',[600 250 750 500])
h=getframe(62);
imwrite(h.cdata,'t_20_90_pdf.png');