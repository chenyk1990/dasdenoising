function [d0 ]=das_fk_dip(d,w)
% das_fk_dip: FK dip filter
%
%
% INPUT
% d: input data (2D)
% w:   half width (in percentage) of the cone filter (i.e., w*nk=nwidth)
%
% OUTPUT
% d0: output data

[n1,n2]=size(d);
nf=2^nextpow2(n1);
nk=2^nextpow2(n2);
nf2=nf/2;
nk2=nk/2;
Dfft1=fft(d,nf,1);
% figure;yc_imagesc(abs(Dfft1));
Dtmp=Dfft1(1:nf2+1,:);

%processing area
Dtmp2=fft(Dtmp,nk,2);
Dtmp2=fftshift(Dtmp2,2);

% nw=400;
nw=w*nk;
[nn1,nn2]=size(Dtmp2);
mask=zeros(nn1,nn2);

for i1=1:nn1
    for i2=1:nn2
%         if i1< (nn1/nw)*(i2-(nk2-nw)) && i1< (n1/nw)*(nk2+nw-i2)
          if i1> (nn1/nw)*(i2-(nk2)) && i1> (nn1/nw)*((nk2)-i2)
            mask(i1,i2)=1;
        end
    end
end

Dtmp2=Dtmp2.*mask;
Dtmp=ifft(ifftshift(Dtmp2,2),nk,2);

%honor symmetry for inverse fft
Dfft2=zeros(nf,nk);
Dfft2(1:nf2+1,:)=Dtmp;
Dfft2(nf2+2:end,:)=conj(flipud(Dtmp(2:end-1,:)));
d0=real(ifft(Dfft2,nf,1));
d0=d0(1:n1,1:n2);




return