function [D,f,k]=das_fk2d_plot(d,dt,dx)
%das_fk2d_plot: FK spectrum (2D) for spectrum comparison
%  IN   d:   	intput data
%       dt:     time sampling
%       dx:     space sampling
%           
%  OUT   D:  	output spectrum
%
%   By Yangkang Chen
%   Jan, 26, 2020
%
%  This program is free software: you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published
%  by the Free Software Foundation, either version 3 of the License, or
%  any later version.
%
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details: http://www.gnu.org/licenses/
%

if nargin==1
   dt=0.004;
   dx=1;
end

[n1,n2]=size(d);
nf = 2^nextpow2(n1);nf2=nf/2;
nk = 2^nextpow2(n2);

D=fftshift(fft(fft(d,nf,1),nk,2));
D=D(nf/2+1:end,:);

f_nq=1/dt/2;
k_nq=1/dx/2;
f=linspace(0,f_nq,nf2);
k=linspace(-k_nq,k_nq,nk);





return


