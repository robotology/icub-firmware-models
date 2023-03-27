close all

c = currents.Data;
t = currents.Time;

window = 100;
cm = movmedian(c, window, 1);

tiledlayout(3, 3)
h(1) = nexttile;
plot(t, [c(:,1), cm(:,1)]); grid minor
ylabel('M0 current (mA)')
h(2) = nexttile;
plot(t,[c(:,2), cm(:,2)]); grid minor
ylabel('M1 current (mA)')
h(3) = nexttile;
plot(t, [c(:,3), cm(:,3)]); grid minor
legend({'current','moving avg'})
ylabel('M2 current (mA)')


vq = V.Data;
h(4) = nexttile;
plot(t, vq(:, 1)); grid minor
ylabel('M0 Vq (%)')
h(5) = nexttile;
plot(t,vq(:, 2)); grid minor
ylabel('M1 Vq (%)')
h(6) = nexttile;
plot(t, vq(:, 3)); grid minor
ylabel('M2 Vq (%)')

p = motor_encoders.Data;
h(7) = nexttile;
plot(t, p(:, 1)); grid minor
ylabel('M0 pos (deg)')
xlabel('Time (s)')
h(8) = nexttile;
plot(t, p(:, 2)); grid minor
ylabel('M1 pos (deg)')
xlabel('Time (s)')
h(9) = nexttile;
plot(t, p(:, 3)); grid minor
ylabel('M2 pos (deg)')
linkaxes(h, 'x');
xlabel('Time (s)')
linkaxes(h, 'x')


cnoise = c - cm;
figure
histogram(cnoise(:,1))
std(cnoise(:, 1))
hold on
histogram(cnoise(:,2))
histogram(cnoise(:,3))
grid minor
xlabel("residuals (mA)")
ylabel("occurrences")
std(cnoise(:,2))
std(cnoise(:,3))
legend ({'current 0', ' current 1', 'current 2'})

[cb, Aea, Aea_Ref, Mot_enc, YPR] = csv_to_timeseries('controlboards/wrist3.csv');

p_bldc = dati_amcbldc.get('wrist3').get('position, deg').Values;
currents_bldc = dati_amcbldc.get('wrist3').get('current, mA').Values;
vq_bldc = dati_amcbldc.get('wrist3').get('Vq, %').Values;
velocity_bldc = dati_amcbldc.get('wrist3').get('velocity, deg/s').Values;

p_bldc = resample(p_bldc, Mot_enc.Time);
currents_bldc = resample(currents_bldc, Mot_enc.Time);
vq_bldc = resample(vq_bldc, Mot_enc.Time);
velocity_bldc = resample(velocity_bldc, Mot_enc.Time);

D = est_lag_with_max(p_bldc.Data(:,1), Mot_enc.Data(:,1)); 


plot(p_bldc.Data(D:end, :)); grid minor
hold on
plot(Mot_enc.Data); grid minor

linkaxes([a1 a3], 'x')

% Simulink.sdi.view