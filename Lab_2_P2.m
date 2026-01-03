clear;
%Problem 2A)

[impr, fs]=audioread('roomIR.wav');


%Problem 2B)

figure(1);
hold on;
plot(impr);
xlabel("Time (s)");
ylabel("Impulse Noise Waveform ([A])");
title("Impulse Noise Waveform over Time");
grid on;
hold off;

%soundsc(impr,fs);

%Problem 2C)
[y,fs1] = audioread('convolution.wav');
%soundsc(y,fs1)

%Problem 2D)

convolved_signal=conv(impr,y);
soundsc(y,fs1)