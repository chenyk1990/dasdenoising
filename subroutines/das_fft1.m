function [X, f] = yc_fft1(x, N, dt)
% das_fft1: 
% by Yangkang Chen, Dec 18, 2019
% 
% INPUT
% x:  data in the time domain
% N:  FFT size
% dt: sampling rate
% 
% OUTPUT
% X: data in the Frequency domain
% f: frequency axis
% 

[n1,n2,n3]=size(x);

if nargin==1
   N=2^nextpow2(n1);
   dt=0.004;
end

if nargin==2
   dt=0.004;
end


X=fft(x,N);
X=X(1:N/2+1,:,:);

if nargout==2
Nyf=1/dt/2;
f=linspace(0,Nyf,N/2+1);
end

return
