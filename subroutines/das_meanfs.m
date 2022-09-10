function [ dout ] = das_meanfs(din,nfw,ifb,axis,ntimes)
%DAS_MEANFS: mean filter along first or second axis for 2D profile
%  IN   D:   	intput data 
%       nfw:    window size
%       ifb:    if use padded boundary (if not, zero will be padded)
%       axis:    temporal sampling interval (3: both axes)
%       times:   number of filtering times
%      
%  OUT   D1:  	output data
% 
%  Copyright (C) 2018 The University of Texas at Austin
%  Copyright (C) 2018 Yangkang Chen
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

if nargin==0
 error('Input data must be provided!');
end

if nargin==1
 nfw=7;
 ifb=1;
 axis=2;
end

if nargin==2
 ifb=1;
 axis=2;    
end

dtmp=din;
if axis==3
for itime=1:ntimes
dtmp=das_meanf(dtmp,nfw,ifb,1);
dtmp=das_meanf(dtmp,nfw,ifb,2);
end    
else
for itime=1:ntimes
dtmp=das_meanf(dtmp,nfw,ifb,axis);
end
end
dout=dtmp;

return
