%% this is the main file of the project
% load parameters and start the simulation

clear all
close all
clc

% overall control parameter
alpha = 0.5;      % 0: coarse actuator tracks r; 1: tracks x_f

% declare parameters
m_f = 0.7e-3;   % fine actuator mass [kg]
m_c = 8.5;      % coarse actuator mass [kg]

k_af = 2.59e-2; % fine actuator constant [N/v]
k_ac = 51;      % coarse actuator constant [N/v]

k = 42;         % stiffness factor [N/m]
c = 3.5e-2;     % damping factor [N/(m/s)]

F_max = 250;    % max. actuation force [N]
xf_max = 1e-3;  % max. fine actuation range [m]
Dc_Max = 40.2;  % max. measured friction [N]

res_optic = 1.25e-9; % resolution of the interferometer [m]
speed_optic = 0.4;  % max. measurable movement [m/s]

q1 = 1.53e-6;   % variance of noise injected at u_f [V^2]
q2 = 0.465;     % variance of noise injected at u_c [v^2]

n = 1e-18;      % measurement noise variance for x_f [m^2]

fs= 20e3;       % sampling frequency of controller

% state space model of dual stage actuator
A = [0,         1,      0,     0; ...
    -k/m_f, -c/m_f, k/m_f, c/m_f;...
    0,          0,      0,     1;...
    0,          0,      0,     0];
B = [0,         0;...
    k_af/m_f,   0;...
    0,          0;...
    0,      k_ac/m_c];
C = [1 0 0 0];
D = [0 0];
dwa_ss = ss(A,B,C,D,'statename',{'xf' 'xf_dot' 'xc' 'xc_dot'},'inputname',{'uf' 'uc'},'outputname','xf');

% discret kalman filter
Qn = [q1 0; 0 q2];
Rn = n;
Ts = 1/fs;
% [kest,~,~,~,~] = kalmd(dwa_ss,Qn,Rn,Ts);

% state space model of coarse actuator
A_c = [0 1; 0 0];
B_cu = [0; k_ac/m_c];
B_cd = [0; 1/m_c];

% state space model of low pass filter
A_lpf = [-284 -370; 370 0];
B_lpf = [440; 0];
C_lpf = [0 0.596];

% state space model of augmented system(consist of coarse actuator, lpf, 
% integral of coarse actuator position error)
A_a = [0            -1 0        0   0;...
       zeros(2,1)    A_c        B_cu*C_lpf;...
       zeros(2,1)   zeros(2)    A_lpf];
B_au = [0; 0; 0; B_lpf];
B_ar = [1 0 0 0 0]';
B_ad = [0; B_cd; 0; 0];

% parameters for equivalent control
S = [-1.7e6 2.28e4 225 1.91 2.71];

% parameters for switch control
k_sw1 = 3;      % factor of relay function in switch control
k_sw2 = 0.1;
k_sigm =0.185;  % factor of sigmoid function in switch control

% Parmeter for trajectory
L = 0.1;        % travel distance [m]
T = 0.55;       % travel time for traj2 [s]
T_s = 5;        % travel time for traj3 [s] 

% open simulink model
% sim('dwa');