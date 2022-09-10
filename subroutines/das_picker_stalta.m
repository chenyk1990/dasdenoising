function [ O,R ] = das_picker_stalta(X,nsta, nlta)
% das_picker_fcm: First-arrival picking using STA/LTA algorithm
%
% Input:
%   nsta: short time period
%   nlta: long time period
%   STA/LTA
%   i>=nsta,
%   STA_i = (1/nsta) * sum_{j=i-nsta}^{i} a_j
%   LTA_i = (1/nlta) * sum_{j=i-nlta}^{i} a_j
%   i<nsta,STA_i=0,LTA_i=0
% Output:
%   On-set picker
%
% Written by Yangkang Chen, Jul, 2017
%

if nargin==1
    q=15;nsta=5;nlta=20;
end


[n1,n2]=size(X);

if n1==1
    X=X';
    n1=n2;n2=1;
end

O=zeros(1,n2);
R=zeros(n1,n2);

for i2=1:n2
    xn=X(:,i2);
    
    e=das_stalta(xn,nsta,nlta); %previous code has bug here (fixed nsta/nlta)
    
    ref=das_scale(e,1);
    
    n_onset=min(find(ref>0.98));
    O(i2)=n_onset;
    R(:,i2)=ref;
    
end

end
