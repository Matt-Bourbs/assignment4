% Assignment-4
% Matthieu Bourbeau
% 100975211

%% PART 2
% The circuit in Figure 1 was simulated using a transient circuit.
% The finite difference method was used to derive a solution for 
% VdV/dt + GV = F.
% The circuit was simulated for a step inputthat transitions from 0 to 1 
% at 0.03s, a sinusoidal input of 33Hz and a gaussian pulse with a 
% magnitude of 1, std dev. of 0.03s and a delay of 0.06s.

dt = 0.001;

Atrans = Cm/dt + G;

V1 = zeros(7,1);
V2 = zeros(7,1);
V3 = zeros(7,1);
Vo1(1) = 0;
Vo2(1) = 0;
Vo3(1) = 0;
Vi1(1) = 0;
Vi2(1) = 0;
Vi3(1) = 0;
F1 = zeros(7,1);
F2 = zeros(7,1);
F3 = zeros(7,1);
count = 1;

for t = dt:dt:1
    if t >= 0.03
        F1(1) = 3;
    end
    F2(1) = sin(2*pi*t/0.03);
    F3(1) = exp(-0.5*((t - 0.06)/0.03)^2);
    V1 = Atrans\(Cm*V1/dt + F1);
    V2 = Atrans\(Cm*V2/dt + F2);
    V3 = Atrans\(Cm*V3/dt + F3);
    Vi1(count +1) = V1(1);
    Vi2(count +1) = V2(1);
    Vi3(count +1) = V3(1);
    Vo1(count +1) = V1(5);
    Vo2(count +1) = V2(5);
    Vo3(count +1) = V3(5);
    count = count+1;
end

figure(1)
plot(0:dt:1,Vi1)
hold on
plot(0:dt:1,Vo1)
title('Voltage vs Time')
xlabel('Time (s)')
ylabel('Voltage')
legend('Input','Output')

figure(2)
plot(0:dt:1,Vi2)
hold on
plot(0:dt:1,Vo2)
title('Voltage vs Time')
xlabel('Time (s)')
ylabel('Voltage')
legend('Input','Output')

figure(3)
plot(0:dt:1,Vi3)
hold on
plot(0:dt:1,Vo3)
title('Voltage vs Time')
xlabel('Time (s)')
ylabel('Voltage')
legend('Input','Output')

Xin = fft(Vi1);
P2in = abs(Xin/1000);
P1in = P2in(1:1000/2+1);
P1in(2:end-1) = 2*P1in(2:end-1);
f = (1/dt)*(0:(1000/2))/1000;
figure(4)
plot(f,P1in)

Xo = fft(Vo1);
P2o = abs(Xo/1000);
P1o = P2o(1:1000/2+1);
P1o(2:end-1) = 2*P1o(2:end-1);
f = (1/dt)*(0:(1000/2))/1000;
hold on
plot(f,P1o)
title('Frequency Content Step Input')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
ylim([0 3])
legend('Input','Output')

Xin = fft(Vi2);
P2in = abs(Xin/1000);
P1in = P2in(1:1000/2+1);
P1in(2:end-1) = 2*P1in(2:end-1);
figure(5)
plot(f,P1in)

Xo = fft(Vo2);
P2o = abs(Xo/1000);
P1o = P2o(1:1000/2+1);
P1o(2:end-1) = 2*P1o(2:end-1);
hold on
plot(f,P1o)
title('Frequency Content Sinusoidal Input')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
ylim([0 3])
legend('Input','Output')

Xin = fft(Vi3);
P2in = abs(Xin/1000);
P1in = P2in(1:1000/2+1);
P1in(2:end-1) = 2*P1in(2:end-1);
figure(6)
plot(f,P1in)

Xo = fft(Vo3);
P2o = abs(Xo/1000);
P1o = P2o(1:1000/2+1);
P1o(2:end-1) = 2*P1o(2:end-1);
hold on
plot(f,P1o)
title('Frequency Content Gaussian Input')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
ylim([0 3])
legend('Input','Output')