function e = getSigmaEllipse(x, c, nsig, n)
%
% INPUTS:
%   x, c - mean and covariance of a 2-D Gaussian
%   nsig - number of sigmas for ellipsoid bound
%   n - number of lines in polyline (default 60)
%
% OUTPUT:
%   e = points of ellipse polyline
%
% Tim Bailey 2006.

if nargin==4, inc = 2*pi/n; else inc = pi/30; end

r = sqrtm(c);
phi = [0:inc:2*pi  0];
a = nsig * r * [cos(phi); sin(phi)];

e(1,:) = a(1,:) + x(1);
e(2,:) = a(2,:) + x(2);