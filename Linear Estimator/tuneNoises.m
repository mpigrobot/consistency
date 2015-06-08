% Selecting different noise scalar can obtain other results.
clear all; clc; close all;
rng(123); % Control random number generation
%%
visualize    = 0;
%%
dt           = 1.0;
step         = 100;
xInit        = [0, 4, 0, 2]';
SigmaInit    = 1^2 * eye(4);
xLen         = length(xInit);
 % Tune noises
%% different process noise levels
% % under-estimate process noise level
%    proNoiseScalar = 0.1;
%    obsNoiseScalar = 1.0;
%   % under-estimate process noise level
%    proNoiseScalar1 = 0.2;
%    obsNoiseScalar1 = 1.0;
%   % noises are exactly matched
%    proNoiseScalar2 = 1.0;
%    obsNoiseScalar2 = 1.0;
%   % over-estimate process noise level
%    proNoiseScalar3 = 20;
%    obsNoiseScalar3 = 1.0;
%  %  over-estimate process noise level
%    proNoiseScalar4 = 50;
%    obsNoiseScalar4 = 1.0;
%% different observation noise levels
   % under-estimate observation noise level
   proNoiseScalar = 1.0;
   obsNoiseScalar = 0.7;
   % under-estimate observation noise level
   proNoiseScalar1 = 1.0;
   obsNoiseScalar1 = 0.8;
   % noises are exactly matched
   proNoiseScalar2 = 1.0;
   obsNoiseScalar2 = 1.0;
   % over-estimate observation noise level
   proNoiseScalar3 = 1.0;
   obsNoiseScalar3 = 2;
   % over-estimate observation noise level
   proNoiseScalar4 = 1.0;
   obsNoiseScalar4 = 10;
%% Process noise for filter
sigmaVxNoise = 0.01;
sigmaVyNoise = 0.01;
Q  = (proNoiseScalar * [sigmaVxNoise, 0;  0, sigmaVyNoise]).^2;
Q1  = (proNoiseScalar1 * [sigmaVxNoise, 0;  0, sigmaVyNoise]).^2;
Q2  = (proNoiseScalar2 * [sigmaVxNoise, 0;  0, sigmaVyNoise]).^2;
Q3  = (proNoiseScalar3 * [sigmaVxNoise, 0;  0, sigmaVyNoise]).^2;
Q4  = (proNoiseScalar4 * [sigmaVxNoise, 0;  0, sigmaVyNoise]).^2;
%% Measurement noise for filter
sigmaXNoise  = 0.1;
sigmaYNoise  = 0.1; 
R  = (obsNoiseScalar * diag([sigmaXNoise, sigmaYNoise])).^2;
R1  = (obsNoiseScalar1 * diag([sigmaXNoise, sigmaYNoise])).^2;
R2  = (obsNoiseScalar2 * diag([sigmaXNoise, sigmaYNoise])).^2;
R3  = (obsNoiseScalar3 * diag([sigmaXNoise, sigmaYNoise])).^2;
R4  = (obsNoiseScalar4 * diag([sigmaXNoise, sigmaYNoise])).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaVxNoise,sigmaVxNoise].^2);
simR =  diag([sigmaXNoise,  sigmaYNoise].^2);
%% Main loop of the LKF implemented in a separated script
linearMainLoop;
%% The animation is implemented in a separated script
if visualize
    animation
end