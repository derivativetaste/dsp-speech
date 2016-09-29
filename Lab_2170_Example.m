filename = 'O.m4a';
[y,Fs] = audioread(filename);
sound(y,Fs);
t = 0:1/Fs:(length(y)-1)/Fs;

plot(t,y);
