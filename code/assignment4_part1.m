% Assignment-4
% Matthieu Bourbeau
% 100975211

%% PART 1
% Analyzed circuit in Figure 1 to order to determine the G and C matricies. 
% Performed DC and AC simulations on the circuit.
% Using KCL, the differential equations that represent the network were
% determined to be the following:
%
% V1 = Vin
% G1(V2 - V1) + C1(d(V2 - V1)/dt) + Il = 0
% G3V3 - Il = 0
% G3V3 - I3 = 0
% G4(Vo - V4) + GoVo = 0
% V2 - V3 - L(dIl/dt) = 0
% V4 - aI3 = 0
%
% The matrices C, G and the vector F were be used to describe the network
% using CdV/dt + GV = F and (G + jwC)V = F(w).
% For the DC case, the input voltage was swept from -10V to 10V.
% For the AC case, the output voltage along with the gain was plotted as a 
% function of the frequency.
% The gain as a function of random perturbations on C was determined using 
% a normal distribution.

R1 = 1;
R2 = 2;
C = 0.25;
L = 0.2;
R3 = 10;
a = 100;
R4 = 0.1;
R0 = 1000;

G = zeros(7,7);
Cm = zeros(7,7);
G(1,1) = 1;
G(2,1) = -1/R1;
G(2,2) = 1/R1 + 1/R2;
G(2,6) = 1;
G(3,3) = 1/R3;
G(3,6) = -1;
G(4,3) = 1/R3;
G(4,7) = -1;
G(5,4) = -1/R4;
G(5,5) = 1/R4 + 1/R0;
G(6,2) = 1;
G(6,3) = -1;
G(7,4) = 1;
G(7,7) = -a;
Cm(2,1) = -C;
Cm(2,2) = C;
Cm(6,6) = -L;

G
Cm

F = zeros(7,1);
V = zeros(7,1);
count = 1;
for i = -10:10
    F(1) = i;
    V = G\F;
    Vodc(count) = V(5);
    V3(count) = V(3);
    count = count + 1;
end

F

figure(1)
plot(linspace(-10,10,21),Vodc)
hold on
plot(linspace(-10,10,21),V3)
title('Output Voltage Vs Input Voltage')
xlabel('Input')
ylabel('Output')
legend('Vo','V3')

j = sqrt(-1);

count = 1;
F(1) = 1;

for w = 0:1000
    Gac = G + j*w*Cm;
    V = Gac\F;
    Voac(count) =  V(5);
    count = count+1;
end

figure(2)
plot(0: 1000, abs(Voac))
title('Ouput Voltage vs Frequency')
xlabel('Frequency (rad/s)')
ylabel('Vo')

figure(3)
semilogx(0:1000, log10(abs(Voac)))
title('Gain vs Frequency')
xlabel('Frequncy (rad/s)')
ylabel('Gain (dB)')

Crand = Cm;

for i = 1:1000
    Cr = normrnd(C,0.05);
    Crand(2,1) = -Cr;
    Crand(2,2) = Cr;
    V = (j*pi*Crand + G)\F;
    Vorand(i) = V(5);
end

figure(4)
hist(abs(Vorand));
title('Histogram of Gain for Random Capacitor Perturbations')
xlabel('Gain')
ylabel('Number of Occurences')



