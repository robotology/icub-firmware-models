% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.
%
% Author: Simone Girardi <simone.girardi@iit.it>

Ts = 0.001;

order = 3;
assert(order>=3);
A = [zeros(order-1, 1) eye(order-1); zeros(1, order)];
B = zeros(order, 1);
C = zeros(1, order); C(1) = 1;
D = 0;
sys = ss(A, B, C, D);

sysd = c2d(sys, Ts, 'zoh');

x0 = zeros(3, 1);
Q = [1e-4; 1e-2; 10];
R = 1e-4;
