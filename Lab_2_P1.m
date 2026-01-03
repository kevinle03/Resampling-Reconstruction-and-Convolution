clear;
%Problem 1A)

n=0:1:9;
n_a=0:1:18;
n_b=0:1:27;
n_c=0:1:36;
n_d=0:1:45;
unitstep_0=n>=0;
unitstep_10=n>=10;
sequence=unitstep_0-unitstep_10;

figure(1);
hold on;
stem(n,sequence);
xlabel("Sample Number ([n])");
ylabel("Signal Amplitude ([A])");
title("Signal Amplitude over Sample Number (Sequence)");
grid on;
hold off;

%Problem 1B)
a=conv(sequence,sequence);
b=conv(a,sequence);
c=conv(b,sequence);
d=conv(c,sequence);

%Problem 1C)
figure(2);
hold on;
stem(n_a,a);
xlabel("Sample Number ([n])");
ylabel("Signal Amplitude ([A])");
title("Signal Amplitude over Sample Number (Convolution A)");
grid on;
hold off;
figure(3);
hold on;
stem(n_b,b);
xlabel("Sample Number ([n])");
ylabel("Signal Amplitude ([A])");
title("Signal Amplitude over Sample Number (Convolution B)");
grid on;
hold off;
figure(4);
hold on;
stem(n_c,c);
xlabel("Sample Number ([n])");
ylabel("Signal Amplitude ([A])");
title("Signal Amplitude over Sample Number (Convolution C)");
grid on;
hold off;
figure(5);
hold on;
stem(n_d,d);
xlabel("Sample Number ([n])");
ylabel("Signal Amplitude ([A])");
title("Signal Amplitude over Sample Number (Convolution D)");
grid on;
hold off;