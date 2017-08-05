function [ kest ] = observer( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% System state space model
global k c m_f m_c k_af k_ac q1 q2 n fs

A = [0       1      0       0;...
    -k/m_f -c/m_f k/m_f c/m_f;...
    0       0       0       1;...
    0       0       0       0]; 

B = [0          0;...
    k_af/m_f    0;...
    0           0;...
    0       k_ac/m_c];

C = [1 0 0 0];
D = [0 0];

dwa_ss = ss(A, B, C, D);

% discret kalman filter
Qn = [q1 0; 0 q2];
Rn = n;
Ts = 1/fs;
[kest,L,P,M,Z] = kalmd(dwa_ss,Qn,Rn,Ts);
end

