% Implementation of the nonlinear estimator-a EKF demo with nolinear motion 
% model and sensor model.
%% Generate truth
[xTrue, zTrue] = simTruth(xInit,@nonlinear.motionModel, relMotion, simQ,...
    @nonlinear.sensorModel, sensorPos, simR, step);
%% Assign memory
muPred           = zeros(xLen, step);
muPred1           = zeros(xLen, step);
muPred2           = zeros(xLen, step);
muPred3           = zeros(xLen, step);
muPred4           = zeros(xLen, step);
muPred(:,1)      = xInit;
muPred1(:,1)      = xInit;
muPred2(:,1)      = xInit;
muPred3(:,1)      = xInit;
muPred4(:,1)      = xInit;
SigmaPred        = zeros(xLen, xLen, step);
SigmaPred1        = zeros(xLen, xLen, step);
SigmaPred2        = zeros(xLen, xLen, step);
SigmaPred3        = zeros(xLen, xLen, step);
SigmaPred4        = zeros(xLen, xLen, step);
SigmaPred(:,:,1) = SigmaInit;
SigmaPred1(:,:,1) = SigmaInit;
SigmaPred2(:,:,1) = SigmaInit;
SigmaPred3(:,:,1) = SigmaInit;
SigmaPred4(:,:,1) = SigmaInit;
muPost           = zeros(xLen, step);
SigmaPost        = zeros(xLen, xLen, step);
zRows            = size(zTrue, 1);
innov            = zeros(zRows, step);
innov1            = zeros(zRows, step);
innov2            = zeros(zRows, step);
innov3            = zeros(zRows, step);
innov4            = zeros(zRows, step);
SigmaInnov       = zeros(zRows, zRows, step);
SigmaInnov1       = zeros(zRows, zRows, step);
SigmaInnov2       = zeros(zRows, zRows, step);
SigmaInnov3       = zeros(zRows, zRows, step);
SigmaInnov4       = zeros(zRows, zRows, step);
%% Filtering loop
mu               = xInit;
mu1               = xInit;
mu2               = xInit;
mu3               = xInit;
mu4               = xInit;
Sigma            = SigmaInit;
Sigma1            = SigmaInit;
Sigma2            = SigmaInit;
Sigma3            = SigmaInit;
Sigma4            = SigmaInit;
tic;
for i = 1 : step
    if i ~= 1
        u = relMotion(:, i-1);
        F = jacobF(mu, u);
        F1 = jacobF(mu1, u);
        F2 = jacobF(mu2, u);
        F3 = jacobF(mu3, u);
        F4 = jacobF(mu4, u);
        [mu, Sigma] = predictEKF(mu, Sigma, u,...
          @nonlinear.motionModel, F, Q);
      [mu1, Sigma1] = predictEKF(mu1, Sigma1, u,...
          @nonlinear.motionModel, F1, Q1);
      [mu2, Sigma2] = predictEKF(mu2, Sigma2, u,...
          @nonlinear.motionModel, F2, Q2);
      [mu3, Sigma3] = predictEKF(mu3, Sigma3, u,...
          @nonlinear.motionModel, F3, Q3);
      [mu4, Sigma4] = predictEKF(mu4, Sigma4, u,...
          @nonlinear.motionModel, F4, Q4);
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
        H = jacobH(mu, sensorPos);
        H1 = jacobH(mu1, sensorPos);
        H2 = jacobH(mu2, sensorPos);
        H3 = jacobH(mu3, sensorPos);
        H4 = jacobH(mu4, sensorPos);
        [mu, Sigma, innov(:,i), SigmaInnov(:,:,i)] =...
          updateEKF(mu, Sigma, @nonlinear.sensorModel, sensorPos,...
        zTrue(:,i), H, R, true, 1);
        [mu1, Sigma1, innov1(:,i), SigmaInnov1(:,:,i)] =...
          updateEKF(mu1, Sigma1, @nonlinear.sensorModel, sensorPos,...
        zTrue(:,i), H1, R1, true, 1);
        [mu2, Sigma2, innov2(:,i), SigmaInnov2(:,:,i)] =...
          updateEKF(mu2, Sigma2, @nonlinear.sensorModel, sensorPos,...
        zTrue(:,i), H2, R2, true, 1);
        [mu3, Sigma3, innov3(:,i), SigmaInnov3(:,:,i)] =...
          updateEKF(mu3, Sigma3, @nonlinear.sensorModel, sensorPos,...
        zTrue(:,i), H3, R3, true, 1);
        [mu4, Sigma4, innov4(:,i), SigmaInnov4(:,:,i)] =...
          updateEKF(mu4, Sigma4, @nonlinear.sensorModel, sensorPos,...
        zTrue(:,i), H4, R4, true, 1);
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
toc;