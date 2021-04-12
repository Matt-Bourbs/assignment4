% Assignment-4
% Matthieu Bourbeau
% 100975211

%% PART 3
% The circuit in Figure 1 was improved by adding a noise current source and a
% capacitor, to bandlimit the noise in parallel with R3 seen in Figure 2. 
% The C matrix was modified.
% The circuit was simulated with varying Cn to observe the effect on the
% bandwidth. 
% The circuit was also simulated with varying time step dt.

In = 0.001;
Cn = 0.00001;
Cm(3,3) = Cn;

G
Cm

dt = 0.001;
Atrans = Cm/dt + G;

F = zeros(7,1);
V = zeros(7,1);
Vo(1) = 0;
Vi(1) = 0;

count = 1;

for t = dt:dt:1
    F(1) = exp(-0.5*((t - 0.06)/0.03)^2);
    F(3) = In*normrnd(0,1);
     V = Atrans\(Cm*V/dt + F);
     Vi(count + 1) = F(1);
     Vo(count + 1) = V(5);
     count = count + 1;
end

figure(1)
plot(0:dt:1,Vi)
hold on
plot(0:dt:1,Vo)
title('Voltage vs Time')
xlabel('Time (s)')
ylabel('Voltage')
legend('Input','Output')

Xin = fft(Vi);
P2in = abs(Xin/1000);
P1in = P2in(1:1000/2+1);
P1in(2:end-1) = 2*P1in(2:end-1);
f = (1/dt)*(0:(1000/2))/1000;
figure(2)
plot(f,P1in)

Xo = fft(Vo);
P2o = abs(Xo/1000);
P1o = P2o(1:1000/2+1);
P1o(2:end-1) = 2*P1o(2:end-1);
f = (1/dt)*(0:(1000/2))/1000;
hold on
plot(f,P1o)
title('Frequency Content Noisy Resistor')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
ylim([0 3])
legend('Input','Output')

Csmall = Cm;
Cmed = Cm;
Clarge = Cm;
Csmall(3,3) = 0;
Cmed(3,3) = 0.001;
Clarge(3,3) = 0.1;

Vsmall = zeros(7,1);
Vmed = zeros(7,1);
Vlarge = zeros(7,1);
Vosmall(1) = 0;
Vomed(1) = 0;
Volarge(1) = 0;
Vi(1) = 0;
count = 1;

for t = dt:dt:1
     F(1) = exp(-0.5*((t - 0.06)/0.03)^2);
     F(3) = In*normrnd(0,1);
     Vsmall = (Csmall/dt + G)\(Csmall*Vsmall/dt + F);
     Vmed = (Cmed/dt + G)\(Cmed*Vmed/dt + F);
     Vlarge = (Clarge/dt + G)\(Clarge*Vlarge/dt + F);
     Vosmall(count + 1) = Vsmall(5);
     Vomed(count + 1) = Vmed(5);
     Volarge(count + 1) = Vlarge(5);
     Vi(count + 1) = F(1);
     count = count + 1;
end

figure(3)
plot(0:dt:1,Vi1)
hold on
plot(0:dt:1,Vosmall)
title('Voltage vs Time, Cn = 0')
xlabel('Time (s)')
ylabel('Voltage')
legend('Input','Output')

figure(4)
plot(0:dt:1,Vi)
hold on
plot(0:dt:1,Vomed)
title('Voltage vs Time, Cn = 0.001')
xlabel('Time (s)')
ylabel('Voltage')
legend('Input','Output')

figure(5)
plot(0:dt:1,Vi)
hold on
plot(0:dt:1,Volarge)
title('Voltage vs Time, Cn = 0.1')
xlabel('Time (s)')
ylabel('Voltage')
legend('Input','Output')

dt1 = 0.01;
ViSmallStep(1) = 0;
VoSmallStep(1) = 0;
V = zeros(7,1);
count = 1;

for t = dt1: dt1:1
     F(1) = exp(-0.5*((t - 0.06)/0.03)^2);
     F(3) = In*normrnd(0,1);
     V = (Cm/dt1 + G)\(Cm*V/dt1 + F);
     VoSmallStep(count + 1) = V(5);
     ViSmallStep(count + 1) = F(1);
     count = count + 1;
end

dt2 = 0.1;
ViLargeStep(1) = 0;
VoLargeStep(1) = 0;
V = zeros(7,1);

count = 1;

for t = dt2: dt2:1
     F(1) = exp(-0.5*((t - 0.06)/0.03)^2);
     F(3) = In*normrnd(0,1);
     V = (Cm/dt2 + G)\(Cm*V/dt2 + F);
     VoLargeStep(count + 1) = V(5);
     ViLargeStep(count + 1) = F(1);
     count = count + 1;
end

figure(6)
plot(0:dt1:1,ViSmallStep)
hold on
plot(0:dt1:1,VoSmallStep)
title('Voltage vs Time, dt = 0.003')
xlabel('Time (s)')
ylabel('Voltage')
legend('Input','Output')

figure(7)
plot(0:dt2:1,ViLargeStep)
hold on
plot(0:dt2:1,VoLargeStep)
title('Voltage vs Time, dt = 0.01')
xlabel('Time (s)')
ylabel('Voltage')
legend('Input','Output')