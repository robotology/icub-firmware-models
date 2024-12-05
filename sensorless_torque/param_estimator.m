clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         INPUT SEQUENCE HERE
%
M=load('data\ergojoint_mid_calibration.mat','data');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

KmOpt = 0.0;
KwOpt = 0.0;
FcOpt = 0.0;
FsOpt = 0.0;
S0Opt = 0.0;
S1Opt = 0.0;
VtOpt = 0.0;

sz = size(M.data);
N = sz(2);
warmup = N/5;

time        = M.data(1,:);
current     = M.data(2,:);
velocity    = M.data(3,:);
torque_meas = M.data(4,:);

velmax = max(abs(velocity));
velthr = velmax/10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STAGE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

errMin = 1E+12;

KmA = 4.29/5; KmB = 4.29*5;
KwA = 0.05/5; KwB = 0.05*5;
FcA = 3.0/5;  FcB = 3.0*5;

for k=1:3

dKm = 0.02*(KmB - KmA);
dKw = 0.02*(KwB - KwA);
dFc = 0.02*(FcB - FcA);

for Km = KmA : dKm : KmB
for Kw = KwA : dKw : KwB
for Fc = FcA : dFc : FcB

err = 0.0;

V2old = velocity(1)^2;

for i=1:N

    V2 = velocity(i)^2;

    if V2 < V2old && abs(velocity(i)) > velthr
        torque_calc = Km*current(i) - Kw*velocity(i);
        err = err + (torque_calc-torque_meas(i)-sign(velocity(i))*Fc)^2;
    end

    V2old = V2;
end

if err < errMin
    errMin = err;
    KmOpt = Km;
    KwOpt = Kw;
    FcOpt = Fc;
end

end
end
end

KmA = KmOpt - 5*dKm; KmB = KmOpt + 5*dKm;
KwA = KwOpt - 5*dKw; KwB = KwOpt + 5*dKw;
FcA = FcOpt - 5*dFc; FcB = FcOpt + 5*dFc;

if KmA < 0
    Kma = 0;
end
if KwA < 0
    KwA = 0;
end
if FcA < 0
    FcA = 0;
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STAGE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

errMin = 1E+12;

FsA = 0.0; FsB = FcOpt;
VtA = 0.01*velmax; VtB = velmax;

for k=1:3

dVt = 0.02*(VtB - VtA);
dFs = 0.02*(FsB - FsA);

for Vt = VtA : dVt : VtB
for Fs = FsA : dFs : FsB

err = 0.0;

V2old = velocity(1)^2;

for i=1:N

    V2 = velocity(i)^2;

    if V2 < V2old && abs(velocity(i)) < 2*velthr
        torque_calc = KmOpt*current(i) - KwOpt*velocity(i);
        err = err + (torque_calc-torque_meas(i)-sign(velocity(i))*(FcOpt+Fs*exp(-abs(velocity(i))/Vt)))^2;
    end

    V2old = V2;
end

if err < errMin
    errMin = err;
    VtOpt = Vt;
    FsOpt = Fs;

    if VtOpt < 0
        VtOpt = 0;
    end
    if FsOpt < 0
        FsOpt = 0;
    end
end

end
end

VtA = VtOpt - 5*dVt; VtB = VtOpt + 5*dVt;
FsA = FsOpt - 5*dFs; FsB = FsOpt + 5*dFs;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STAGE 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

errMin = 1E+12;

S0A = 0.0; S0B = 25.0;
S1A = -25; S1B = 25.0;

for k = 1:3

dS0 = 0.02*(S0B - S0A);
dS1 = 0.02*(S1B - S1A);

for S0 = S0A : dS0 : S0B
for S1 = S1A : dS1 : S1B

err = 0.0;

Z = 0.0;

time_prev = time(1);

for i=1:N

    gV = FcOpt + FsOpt*exp(-abs(velocity(i)/VtOpt));

    Zdot = (velocity(i) - abs(velocity(i))*S0*Z/gV);

    Z = Z + (time(i)-time_prev)*Zdot;
    time_prev = time(i);

    friction_calc = KwOpt*velocity(i) + S0*Z + S1*Zdot;

    torque_motor = KmOpt*current(i);

    if i > warmup
        err = err + ((torque_motor - torque_meas(i)) - friction_calc)^2;
    end
end

if err < errMin
    errMin = err;
    S0Opt = S0;
    S1Opt = S1;
end

end
end
S0A = S0Opt-dS0; S0B = S0Opt+dS0;
S1A = S1Opt-dS1; S1B = S1Opt+dS1;

end

% Km = KmOpt
% Kw = KwOpt
% S0 = S0Opt
% S1 = S1Opt
% Fc_pos = FcOpt
% Fc_neg = FcOpt
% Fs_pos = FcOpt+FsOpt
% Fs_neg = FcOpt+FsOpt
% Vth = VtOpt

fprintf('Estimated LuGre parameters:\n\n')
fprintf('Km       %f Nm/A\nKw       %f Nm/(rad/s)\n',KmOpt,KwOpt)
fprintf('S0       %f Nm/rad\nS1       %f Nm/(rad/s)\n',S0Opt,S1Opt)
fprintf('Fc_pos   %f Nm\nFc_neg   %f Nm\n',FcOpt,FcOpt)
fprintf('Fs_pos   %f Nm\nFs_neg   %f Nm\nVth      %f rad/s\n\n',FcOpt+FsOpt,FcOpt+FsOpt,Vt)


