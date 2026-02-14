%% Ex 2
syms x L th0 GJ mt;
phi1 = ((x/L)^2-x/L);
phi0 = th0*x/L;

K = int( diff(phi1,x) * GJ * diff(phi1,x), x,0, L);
F = int( phi1 * mt - diff(phi1,x) * GJ * diff( phi0, x),x,0,L);
c1 = F/K;
th = simplify(c1*phi1+phi0)

%% EX 3
clear; clc;
syms x L k h EJ P;

phi = (x/L)^2;
K = int(diff(phi,x,2) * EJ * diff(phi,x,2),x,0,L) + int(phi * h * phi,x, 0, L/2) + subs(phi,x,L) * k * subs(phi,x,L);
F = subs(phi,x,L)* P;
c1 = F / K

%% Ex 4
clear; clc;
syms x L EJ0 I0;
EJ = EJ0 * sin(pi*x/L);

phi = sin(pi*x/L);
K = int(diff(phi,x,2) * EJ * diff(phi,x,2),x,0,L);
M = int(phi * I0 * phi,x,0,L);
om = (sqrt(M/K))

