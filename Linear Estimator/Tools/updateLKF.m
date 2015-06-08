function [muPost, SigmaPost, Y, S, K] = updateLKF(mu, Sigma, z, H, R)
% A function to implement the update process of linear Kalman filter
%%
    r = size(mu, 1);
    if r ~= size(Sigma, 1) || r ~= size(Sigma, 2)
       error('Wrong size of mu or Sigma.'); 
    end
    
    if size(H, 1) ~= size(z, 1)
        error('Wrong size of z or H.');
    end
    
    if size(H, 2) ~= size(mu, 1)
        error('Wrong size of H or mu');
    end
%%
    Y         = z - H * mu;
    S         = H * Sigma * H' + R;
    K         = Sigma * H' / S;
    muPost    = mu + K * Y;
    SigmaPost = Sigma - K * S * K';
end