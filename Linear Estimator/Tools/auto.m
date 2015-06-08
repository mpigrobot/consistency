function Rxx=auto(x)

% Hugh Durrant-Whyte 5-Jan-94
% Computes autocorrelation of input data set. N is the number of 
% data points, x is a column matrix holding the input data set.
% Uses fft method as advertised in Maybeck p193.


% first find the size of input vector
[N,nul]=size(x'); 
M=round(N/2);

% then compute PSD of data 
X=fft(x);
Pxx=X.*conj(X)/N;

% then inverse is autocorrelation
Rxx=real(ifft(Pxx));
Rxx=Rxx(1:M);
fact=Rxx(1);
for i=1:M
   Rxx(i)=Rxx(i)/fact;
end




