function [ds] = das_pwsmooth_lop_mf(dn,dip,ns,order,eps,type_mf)
% das_pwsmooth_lop_mf: structure-oriented median filtering (SOMF)
%
% INPUT:
% dn: noisy data (2D array)
% dip: slope (2D array)
% ns:       spray radius
% order:    PWD order
% eps: regularization (default:0.01);
% type_mf: MF or SVMF
%
% OUTPUT:
% ds:  filtered data
%

[n1,n2]=size(dn);

if ns~=1  
    ns2=2*ns+1;%spray diameter
    [utmp] = str_pwspray_lop2d(dn,dip,ns,order,eps);
    u=reshape(utmp,n1,ns2,n2);
    
    for i2=1:n2
        if type_mf==0   %MF
            u(:,:,i2)= das_mf(u(:,:,i2),ns2,1,2);
        else            %SVMF
            u(:,:,i2)= das_svmf(u(:,:,i2),ns2,1,2);
        end
    end
    
    ds=squeeze(u(:,ns+1,:));
else
    ds=dn;
end


return




