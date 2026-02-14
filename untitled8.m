%% Ex 1
clear
clc

L1 = 800;
EA = 7.2e6;
EJ = 2.3438e9;
q = 1;
us = 1;
ts = deg2rad(-1); % rotazione inversa rispetto convenzione
L2 = L1*sqrt(2);

k_EJ2 = 2*EJ/L1^3 * [6, -3*L1, -6, -3*L1;
                -3*L1, 2*L1^2, 3*L1, L1^2;
                -6, 3*L1, 6, 3*L1;
                -3*L1, L1^2, 3*L1, 2*L1^2]; % local frame
k_EJ3 = 2*EJ/L1^3 * [6, -3*L1, -6, -3*L1;
                -3*L1, 2*L1^2, 3*L1, L1^2;
                -6, 3*L1, 6, 3*L1;
                -3*L1, L1^2, 3*L1, 2*L1^2]; % local frame

k_EJ1 = 2*EJ/L2^3 * [6 -3*L2, -6, -3*L2;
                -3*L2, 2*L2^2, 3*L2, L2^2;
                -6, 3*L2, 6, 3*L2;
                -3*L2, L2^2, 3*L2, 2*L2^2];

T_truss = @(a) [cos(a), sin(a), 0, 0; 0, 0 , cos(a), sin(a)];
T_beam = @(a) [cos(a), sin(a), 0, 0, 0, 0; sin(a), cos(a), 0, 0, 0, 0; 0, 0, 1, 0, 0, 0; 0, 0, 0, cos(a), sin(a), 0; 0, 0, 0, sin(a), cos(a), 0; 0, 0, 0, 0, 0, 1];

k_EA1 = T_truss(pi/4)'*EA/(L2)*[1, -1; -1, 1]*T_truss(pi/4); % local beam 1
K_EJ1 = zeros(6); K_EJ1([2, 3, 5, 6], [2, 3, 5, 6]) = k_EJ1;
K_EJ1 = T_beam(pi/4)'*K_EJ1;


K_EA2 = zeros(6); K_EA2([1, 4], [1, 4]) = EA/L1 * [1, -1;-1, 1];
K_EA3 = zeros(6); K_EA3([2, 5], [2, 5]) = EA/L1 * [1, -1;-1, 1];
K_EJ2 = zeros(6); K_EJ2([2, 3, 5, 6], [2, 3, 5, 6]) = k_EJ2;
K_EJ3 = zeros(6); K_EJ3([1, 3, 4, 6], [1, 3, 5, 6]) = k_EJ3;
K_EA1 = zeros(6); K_EA1([1, 2, 4, 5], [1, 2, 4, 5]) = k_EA1;

F = [0, -q*L1/2, q*L1^2/12, 0, -q*L1/2, -q*L1^2/12]';

K1a = zeros(6); K1a(1:3, 1:3) = K_EA1(4:6, 4:6) + K_EJ1(4:6,4:6);
K2a = zeros(6); K2a = K_EA2 + K_EJ2;
K3a = zeros(6); K3a(4:6, 4:6) = K_EA3(1:3, 1:3) + K_EJ3(1:3,1:3);

Ka = K1a + K2a + K3a

F2 = -Ka(:, [4, 6])*[us, ts]'  % forze calcolate

Ka = Ka([1, 2, 3, 5], [1, 2, 3, 5]);
Fa = F + F2; Fa = Fa([1, 2, 3, 5]);


U = Ka\Fa