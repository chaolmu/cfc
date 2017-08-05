%% this is the main file of the project
% load parameters and start the simulation

clear all
close all
clc

% declare parameters
global m_f m_c k_af k_ac k c q1 q2 n fs
m_f = 0.7e-3;   % fine actuator mass [kg]
m_c = 8.5;      % coarse actuator mass [kg]

k_af = 2.59e-2; % fine actuator constant [N/v]
k_ac = 51;      % coarse actuator constant [N/v]

k = 42;         % stiffness factor [N/m]
c = 3.5e-2;     % damping factor [N/(m/s)]

F_max = 250;    % max. actuation force [N]
xf_max = 1e-3;  % max. fine actuation range [m]

res_optic = 1.25e-9; % resolution of the interferometer [m]
speed_optic = 0.4;  % max. measurable movement [m/s]

q1 = 1.53e-6;   % variance of noise injected at u_f [V^2]
q2 = 0.465;     % variance of noise injected at u_c [v^2]

n = 1e-18;      % measurement noise variance for x_f [m^2]

fs= 20e3;       % sampling frequency of controller

% control params
S = [-1.7e6 2.28e4 225 1.91 2.71];
B_au = [0 0 0 440 0]';
B_ar = [1 0 0 0 0]';
B_ad = [0 0 1/m_c 0 0]';
ksw_min = abs(inv(S*B_au)*s*B_ad)*40.2;

% open simulink model
% sim('dwa');