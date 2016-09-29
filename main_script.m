close all
%plotting magnitude and phase
filename = 'input/O.m4a';
[y,Fs] = audioread(filename);
%sound(y,Fs);
t = 0:1/Fs:(length(y)-1)/Fs;
L = length(y);
NFFT = 2^nextpow2(L);
R = fft (y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
ftemp = f;
Rmag = abs(R(1:NFFT/2+1));
drop1 = 4000:(length(f));
drop2 = 1:2000;
f(drop1) = [];
f(drop2) = [];
Rmag(drop1) = [];
Rmag(drop2) = [];
figure
subplot(2,1,1)
plot(f,Rmag);
title('Magnitude');
%Rphase = phase(R);
ESREAL = real(R);
ESIMAG = imag(R);
theta = unwrap(atan(ESIMAG./ESREAL));
subplot(2,1,2)
plot(ftemp, theta(1:NFFT/2+1));
title('Phase');
% plotting signal wave form
figure
subplot(2,1,1)
plot(t,y);
title('"O" Waveform');
xlabel('time (seconds)');
ylabel('Amplitude');
% sound(y,Fs); 
% end plotting signal wave form
% finding time domain signal
t = 0:1/Fs:(length(y)-1)/Fs;
L = length(y);
NFFT = 2^nextpow2(L);
R = fft (y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
Rmag = abs(R(1:NFFT/2+1));
figure
subplot(2,1,1);
interest1 = (f > 0) & (f < (800));
plot(f(interest1),Rmag(interest1));
title('Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Frequency Response');
% down sampled signal
scale = 35;
y1 = downsample(y, scale);
t1 = downsample(t, scale);
Fs1 = Fs/scale;
figure
subplot(2,1,1);
plot(t1, y1, 'r');
title('Down Sampled Additional');
sound(y1,Fs1);
t1 = 0:1/Fs1:(length(y1)-1)/Fs1;
L1 = length(y1);
NFFT1 = 2^nextpow2(L1);
R1 = fft (y1,NFFT1)/L1;
f1 = Fs1/2*linspace(0,1,NFFT1/2+1);
Rmag1 = abs(R1(1:NFFT1/2+1));
figure
subplot(2,1,1)
interest = (f1 > 0) & (f1 < (800));
plot(f1(interest),Rmag1(interest));
title('Frequency Domain Down Sample');
xlabel('Frequency (Hz)');
ylabel('Frequency Response');
%Xcorrelation
filename = 'O.m4a';
[y,Fs] = audioread(filename);
%sound(z,Fs);
t = 0:1/Fs:(length (y)-1)/Fs;
plot(t,y); 
x = y;
g1 = -y;
subplot(3,1,1)
plot(t,x);
title('x(t)')
xlabel('t')
ylabel('x(t)');
ylim([-2,2])
subplot(3,1,2)
plot(t,g1);
title('g_1(t)');
xlabel('t')
ylabel('g_1(t)');
ylim([-2,2])
E0 = sum(x.*conj(x))*Fs;
E1 = sum(g1.*conj(g1))*Fs;
c0 = sum(x.*conj(x))*Fs/(sqrt(E0*E0));
c1 = sum(x.*conj(g1))*Fs/(sqrt(E0*E1));
fprintf('Correlation x->x %0.1d/n',c0);
fprintf('Correlation x->g1 %0.1d/n',c1);
