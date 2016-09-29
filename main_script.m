close all
filename = 'O.m4a';
[y,Fs] = audioread(filename);

%plotting signal wave form
figure
subplot(2,1,1)
plot(t,y);
title('"O" Waveform');
xlabel('time (seconds)');
ylabel('Amplitude');
%sound(y,Fs); 
%end plotting signal wave form

%finding time domain signal
t = 0:1/Fs:(length(y)-1)/Fs;
L = length(y);
NFFT = 2^nextpow2(L);
R = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
Rmag = abs(R(1:NFFT/2+1));
figure
subplot(2,1,1);
interest1 = (f > 0) & (f < (800));
plot(f(interest1),Rmag(interest1));
title('Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Frequency Response');


%down sampled signal
scale = 35;
y1 = downsample(y, scale);
t1 = downsample(t, scale);
Fs1 = Fs/scale;
figure
subplot(2,1,1);
plot(t1, y1, 'r');
title('Sampled at Nyquist Frequency');
%sound(y1,Fs1);

t1 = 0:1/Fs1:(length(y1)-1)/Fs1;
L1 = length(y1);
NFFT1 = 2^nextpow2(L1);
R1 = fft(y1,NFFT1)/L1;
f1 = Fs1/2*linspace(0,1,NFFT1/2+1);
Rmag1 = abs(R1(1:NFFT1/2+1));
figure
subplot(2,1,1)
interest = (f1 > 0) & (f1 < (800));
plot(f1(interest),Rmag1(interest));
title('Frequency Domain Down Sample');
xlabel('Frequency (Hz)');
ylabel('Frequency Response');