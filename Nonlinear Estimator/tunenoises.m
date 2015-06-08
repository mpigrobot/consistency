% Selecting different noise scalar can obtain other results.
close all; clear all; clc;
rng(853); % Control random number generation
%%
enableVis = 0;
makeVideo = 0;
%%
load rose.mat;
clear laser;
relMotion = relMotion(:, 250:5:2400) * 7; % Only use a part of the data.
step      = size(relMotion, 2);   
meanRel   = mean(abs(relMotion), 2);% 2250
meanRel(3)= radtodeg(meanRel(3));
disp(meanRel);
rob = [0 -3 -3; 0 -1 1] * 0.3;
%%
xInit        = [0, 0, 0]';
SigmaInit    = diag([0.1, 0.1, degtorad(0.01)].^2);
xLen         = length(xInit);
%%
sensorPos    = [1.5, 3];
% Tune noises
%% different process noise levels
% under-estimate process noise level
  proNoiseScalar = 0.3;
  obsNoiseScalar = 1.0;
  % under-estimate process noise level
  proNoiseScalar1 = 0.5;
  obsNoiseScalar1 = 1.0;
  % noises are exactly matched
  proNoiseScalar2 = 1.0;
  obsNoiseScalar2 = 1.0;
  % over-estimate process noise level
  proNoiseScalar3 = 10;
  obsNoiseScalar3 = 1.0;
  % over-estimate process noise level
  proNoiseScalar4 = 50;
  obsNoiseScalar4 = 1.0;
%% different observation noise levels
%   % under-estimate observation noise level
%   proNoiseScalar = 1.0;
%   obsNoiseScalar = 0.6;
%   % under-estimate observation noise level
%   proNoiseScalar1 = 1.0;
%   obsNoiseScalar1 = 0.8;
%   % noises are exactly matched
%   proNoiseScalar2 = 1.0;
%   obsNoiseScalar2 = 1.0;
%   % over-estimate observation noise level
%   proNoiseScalar3 = 1.0;
%   obsNoiseScalar3 = 2;
%   % over-estimate observation noise level
%   proNoiseScalar4 = 1.0;
%   obsNoiseScalar4 = 10;
%% Process noise sigma
sigmaXNoise    = 0.01;
sigmaYNoise    = 0.01;
sigmaThetaNoise = degtorad(0.01);
Q  = diag(proNoiseScalar * ...
    [sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
Q1  = diag(proNoiseScalar1 * ...
    [sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
Q2  = diag(proNoiseScalar2 * ...
    [sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
Q3  = diag(proNoiseScalar3 * ...
    [sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
Q4  = diag(proNoiseScalar4 * ...
    [sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
%% Measurement noise sigma
sigmaBNoise  = degtorad(0.1);
sigmaRNoise  = 0.1;
R  = diag(obsNoiseScalar * [sigmaBNoise, sigmaRNoise]).^2;
R1  = diag(obsNoiseScalar1 * [sigmaBNoise, sigmaRNoise]).^2;
R2  = diag(obsNoiseScalar2 * [sigmaBNoise, sigmaRNoise]).^2;
R3  = diag(obsNoiseScalar3 * [sigmaBNoise, sigmaRNoise]).^2;
R4  = diag(obsNoiseScalar4 * [sigmaBNoise, sigmaRNoise]).^2;
%% Noise for simulating truths
% NOTE: the simQ and simR can be different from Q and R!!
simQ =  diag([sigmaXNoise, sigmaXNoise, sigmaXNoise]).^2;
simR =  diag([sigmaBNoise, sigmaRNoise]).^2;
%% Main loop of the LKF implemented in a separated script
nonLinearMainLoop;
%% The animation is implemented in a separated script
if enableVis 
    animation
end
