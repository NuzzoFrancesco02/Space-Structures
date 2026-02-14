%% EX 1
clear variables

% ... symbolic variables
syms x
syms L EA
syms F
syms A0 A1

% ... solution of the ODE
u0(x) = A1 * x + A0;

% ... BCS
bc1 = u0(0) == 0;
bc2 = EA * subs( diff ( u0, x), x, L) == F;
eqnBCS = [ bc1; bc2 ];

% ... 
S = solve( eqnBCS, [A0 A1] );
uSol = subs( u0, [A0 A1], [S.A0 S.A1])

%%
clear variables
syms x u0(x)
syms L EA
syms F

% ... Ode
ode = EA * diff(u0(x),x,2); %2nd derivative

% ... BCS
bc1 = u0(0) == 0;
bc2 = EA * subs( diff ( u0, x), x, L) == F;

% ... solve
uSol = dsolve(ode, bc1, bc2)

%% EX 4
clear variables

% ... symbolic variables
syms x 
syms L EA K
syms n_hat
syms A0 A1

% ... solution 2nd order ODE
u0(x) = A0 + A1 * x + - 0.5 * n_hat / EA * x^2;

% ... define BCS
bc1 = u0(0) == 0;
bc2 = EA * subs( diff(u0,x), x, L) + K * u0(L);

eqnBCS = [bc1 bc2];

% ... solve
S = solve( eqnBCS, [A0 A1] );
uSol = subs( u0, [A0 A1], [S.A0 S.A1])
pretty(simplify(uSol))
