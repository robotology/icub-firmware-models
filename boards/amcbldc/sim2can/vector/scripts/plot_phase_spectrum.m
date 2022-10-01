% Copyright (C) 2022 Fondazione Istitito Italiano di Tecnologia (IIT)
% All Rights Reserved.
%
% Author: Simone Girardi <simone.girardi@iit.it>

%% Plot Specturm of a phase signal from printf in mbdagent_innerloop

signal_name = 'Va';
signal = t.Va;  % signal in time domain
foc_sample_rate = 3.6571428*10^-5;

% downsample_rate is the sample time factor used to print the signal values
downsample_rate = 10;

L = length(signal);                         % Length of signal
Ts = foc_sample_rate * downsample_rate;     % Sampling period
Fs = 1/Ts;                                  % Sampling frequency 

% Compute the Fourier transform of the signal
Y = fft(t.Va);                              

% Compute the two-sided spectrum P2.
% Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Define the frequency domain f and plot the single-sided amplitude spectrum P1.
f = Fs*(0:(L/2))/L;
plot(f,P1)

title(strcat('Single-Sided Amplitude Spectrum of', signal_name))
xlabel('f (Hz)')
ylabel('|Va(f)|')
grid on
grid minor