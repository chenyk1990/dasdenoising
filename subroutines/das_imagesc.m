function [] = das_imagesc(data,pclip,mode,x,z)
%das_imagesc
%   fast plot data using pclip
% Input:
%   data: input data
%   pclip: clip value (percential or exact)
%   mode=1? pclip; mode=2: clip
%
if nargin==1
    pclip=99;
    mode=1;%using pclip;
end

if nargin==2
    mode=1;
end

% mi=min(min(abs(data)));
% ma=max(max(abs(data)));

if mode==1
    t=prctile(abs(data(:)),pclip);
    %  figure;
    if nargin==5
        imagesc(x,z,data);caxis([-t,t]);colormap(cseis);
    else
        imagesc(data);caxis([-t,t]);colormap(cseis);
    end
    
else
    if nargin==5
        imagesc(x,z,data);caxis([-pclip,pclip]);colormap(cseis);
    else
        imagesc(data);caxis([-pclip,pclip]);colormap(cseis);
    end
    
end

end

function [map]=cseis()

map = [[0.5*ones(1,40),linspace(0.5,1,88),linspace(1,0,88),zeros(1,40)]',[0.25*ones(1,40),linspace(0.25,1,88),linspace(1,0,88),zeros(1,40)]',[zeros(1,40),linspace(0.,1,88),linspace(1,0,88),zeros(1,40)]'];

end



