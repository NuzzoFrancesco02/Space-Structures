clear variables
clc

% --- Ex. 1: statically indet. beams
% ... define variables
syms x 
syms a b
syms F V EJ

% ... real sytem
M1 = - F * x;
M2 = - V * x - F * ( a + x);

% ... dummy system 
dM1 = 0;
dM2 = -x;

% ... PCVW
dWi = int( dM1 * M1 / EJ, x, 0, a) + int( dM2 * M2 / EJ, x, 0, b);
dWe = 0;

eq_PCVW = ( dWi == dWe );

V_res = solve( eq_PCVW, V )



