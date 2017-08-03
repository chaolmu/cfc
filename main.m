%% this is the main file of the project
% load parameters and start the simulation

clear all
close all
clc

% declare parameters
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

% open simulink model
sim('dwa');