h_xf = figure('name','desired trajectory and actual x_f');
xf_traj.Data = xf_traj.Data.*1000;
xf_actual.Data = xf_actual.Data.*1000;
plot(xf_traj);
hold on
plot(xf_actual);
grid on
title('Desired trajectory and actual position')
xlabel('t [s]')
ylabel('position [mm]')


h_error = figure('name','position error r_f-x_f');
error_xf.Data = error_xf.Data.*1e9;
plot(error_xf);
grid on
title('position error')
xlabel('t [s]')
ylabel('position error [nm]')

h_dist = figure('name','Distance between fine and coarse actuator');
x_delta.Data = x_delta.Data.*1000;
plot(x_delta);
grid on
title('Distance between fine and coarse actuator')
xlabel('t [s]')
ylabel('position [mm]')

h_input = figure('name','input of DSA');
subplot(2,1,1);
plot(ctrl_input.Time,ctrl_input.Data(:,1));
grid on
title('control input of fine actuator')
xlabel('t [s]')
ylabel('u_f [v]')
subplot(2,1,2);
plot(ctrl_input.Time,ctrl_input.Data(:,2));
grid on
title('control input of coarse actuator')
xlabel('t [s]')
ylabel('u_c [v]')