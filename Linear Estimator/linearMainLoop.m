% Implementation of the linear estimator.Here we choosed the linear Kalman
% filter to handle a 2D constant velocity model.
%% Transition matrices
F = [1, dt,  0,  0;
     0,  1,  0,  0;
     0,  0,  1,  dt;
     0,  0,  0,  1];
E = [dt^2/2,    0;
       dt,      0;
       0,       dt^2/2;
       0,       dt];
H = [1, 0, 0, 0;
     0, 0, 1, 0];
%% Generate truth
[xTrue, zTrue]   = simTruthCV(xInit, F, E, simQ, H, simR, step);
%% Assign memory
muPred           = zeros(xLen, step);
muPred(:,1)      = xInit;
SigmaPred        = zeros(xLen, xLen, step);
SigmaPred(:,:,1) = SigmaInit;
muPost           = zeros(xLen, step);
SigmaPost        = zeros(xLen, xLen, step);
zRows            = size(zTrue, 1);
innov            = zeros(zRows, step);
innov1            = zeros(zRows, step);
innov2            = zeros(zRows, step);
innov3           = zeros(zRows, step);
innov4            = zeros(zRows, step);
SigmaInnov       = zeros(zRows, zRows, step);
SigmaInnov1       = zeros(zRows, zRows, step);
SigmaInnov2       = zeros(zRows, zRows, step);
SigmaInnov3       = zeros(zRows, zRows, step);
SigmaInnov4       = zeros(zRows, zRows, step);
timePredLKF      = zeros(1, step);
timeUpdateLKF    = zeros(1, step);

%% Filtering loop
mu               = xInit;
mu1               = xInit;
mu2              = xInit;
mu3              = xInit;
mu4              = xInit;
Sigma            = SigmaInit;
Sigma1            = SigmaInit;
Sigma2            = SigmaInit;
Sigma3            = SigmaInit;
Sigma4            = SigmaInit;
for i = 1 : step
    if i ~= 1
        predStart = tic;
        [mu, Sigma] = predictLKF(mu, Sigma, F, Q, 'processNoiseMat', E);
        [mu1, Sigma1] = predictLKF(mu1, Sigma1, F, Q1, 'processNoiseMat', E);
        [mu2, Sigma2] = predictLKF(mu2, Sigma2, F, Q2, 'processNoiseMat', E);
        [mu3, Sigma3] = predictLKF(mu3, Sigma3, F, Q3, 'processNoiseMat', E);
        [mu4, Sigma4] = predictLKF(mu4, Sigma4, F, Q4, 'processNoiseMat', E);
        timePredLKF(i) = toc(predStart);
        muPred(:,i)      = mu;
        muPred1(:,i)      = mu1;
        muPred2(:,i)      = mu2;
        muPred3(:,i)      = mu3;
        muPred4(:,i)      = mu4;
        SigmaPred(:,:,i) = Sigma;
        SigmaPred1(:,:,i) = Sigma1;
        SigmaPred2(:,:,i) = Sigma2;
        SigmaPred3(:,:,i) = Sigma3;
        SigmaPred4(:,:,i) = Sigma4;
    end
    updateStart = tic;
    [mu, Sigma, innov(:,i), SigmaInnov(:,:,i)] =...
        updateLKF(mu, Sigma, zTrue(:,i), H, R);
    [mu1, Sigma1, innov1(:,i), SigmaInnov1(:,:,i)] =...
        updateLKF(mu1, Sigma1, zTrue(:,i), H, R1);
    [mu2, Sigma2, innov2(:,i), SigmaInnov2(:,:,i)] =...
        updateLKF(mu2, Sigma2, zTrue(:,i), H, R2);
    [mu3, Sigma3, innov3(:,i), SigmaInnov3(:,:,i)] =...
        updateLKF(mu3, Sigma3, zTrue(:,i), H, R3);
    [mu4, Sigma4, innov4(:,i), SigmaInnov4(:,:,i)] =...
        updateLKF(mu4, Sigma4, zTrue(:,i), H, R4);
    timeUpdateLKF(i) = toc(updateStart);
    muPost(:,i)      = mu;
    muPost1(:,i)      = mu1;
    muPost2(:,i)      = mu2;
    muPost3(:,i)      = mu3;
    muPost4(:,i)      = mu4;
    SigmaPost(:,:,i) = Sigma;
    SigmaPost1(:,:,i) = Sigma1;
    SigmaPost2(:,:,i) = Sigma2;
    SigmaPost3(:,:,i) = Sigma3;
    SigmaPost4(:,:,i) = Sigma4;
end