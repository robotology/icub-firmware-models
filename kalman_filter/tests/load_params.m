% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.
%
% Author: Simone Girardi <simone.girardi@iit.it>

load('robot_logger_device.mat');
Ts = 0.001;

N = 25;
p = robot_logger_device.joints_state.positions.data(N, :)';
v = robot_logger_device.joints_state.velocities.data(N, :)';
a = robot_logger_device.joints_state.accelerations.data(N, :)';

L = min([length(p), length(v), length(a)]);
p = p(1:L);
v = v(1:L);
a = a(1:L);
t = (0:L-1)' * Ts;

simin = [t p v a];

order = 3;
assert(order>=3);

x0 = [simin(1, 2:end)'; zeros(order-3, 1)];
Q = [1e-4; 1e-2; 10];
R = 1e-4;
P0 = 9.9e-05;
