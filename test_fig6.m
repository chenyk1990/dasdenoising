% Script to plot Figure 7
% BY Yangkang Chen
% Dec, 23, 2021

clc;clear;close all;
addpath(genpath('subroutines/'));

%% load data
eq=zeros(2000,960);
[n1,n2]=size(eq);
ii=3;%reasonable
if ~ismember(ii,[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(ii),'.mat'));
end
eq=d1;
load(strcat('mat_bpsomffk/eq-',num2str(ii),'.mat'));
figure;das_imagesc([eq,d1,eq-d1]);

%% pick manually
xx1=1:n2;
figure('units','normalized','Position',[0.2 0.4 1, 0.8],'color','w');
yc_imagesc(d1,99,1,xx1,1:n1);
load first_picks.mat
% [x1,y1]=getpts;
yy1=round(interp1(x1(1:2:end),y1(1:2:end),xx1,'spline'));
times=yy1;

figure;yc_imagesc(d1,99,1,xx1,1:n1);hold on;plot(x1,y1,'ro');plot(xx1,yy1,'bo');


inds=20:20:n2;
traces=d1(:,inds);
traces0=eq(:,inds);

dn=traces;
d0=traces0;
nsta=30;nlta=80;
[ O,R ] = das_picker_stalta(dn,nsta, nlta);
[ O0,R0 ] = das_picker_stalta(d0,nsta, nlta);

times0=[O0-1]*0.0005;
times=[O-1]*0.0005;
timest=[yy1(inds)-1]*0.0005; %true

%name
for ii=1:30
    stname{ii}=strcat('Channel:',num2str(inds(ii)));
end

%% begin plotting
figure('units','normalized','Position',[0.0 0.0 0.45, 1],'color','w');
nr=15;%number of stations in the first column
x0=0.1;y0=0.1;dy=0;dx=0;
%length: 0.5x0.5, 0.5x0.25, 0.25x0.5
%% axis XY
dh=(1-0.2)/nr;dw=0.37;
dh1=dh/2;%axis height
t=[0:1999]*0.0005;
for ir=nr:-1:1
    wav0=traces0(:,ir);
    wav=traces(:,ir);
    a1=axes('Parent',gcf,'Position',[x0,y0+dy+dh*(nr-ir),dw,dh1]);
    plot(t,wav0,'k','linewidth',1.5); hold on; axis off;
    plot(t,wav,'r','linewidth',1.5);

    plot([times0(ir),times0(ir)],[min(wav),max(wav)],'g','linewidth',1.5);
    plot([times(ir),times(ir)],[min(wav),max(wav)],'b','linewidth',1.5);
    plot([timest(ir),timest(ir)],[min(wav),max(wav)],'m-.','linewidth',1.5);
    
    wav0=traces0(:,ir+15);
    wav=traces(:,ir+15);
    a1=axes('Parent',gcf,'Position',[x0+0.5,y0+dy+dh*(nr-ir),dw,dh1]);
    plot(t,wav0,'k','linewidth',1.5);hold on; axis off; 
    plot(t,wav,'r','linewidth',1.5);

    plot([times0(ir+15),times0(ir+15)],[min(wav),max(wav)],'g','linewidth',1.5);
    plot([times(ir+15),times(ir+15)],[min(wav),max(wav)],'b','linewidth',1.5);
    plot([timest(ir+15),timest(ir+15)],[min(wav),max(wav)],'m-.','linewidth',1.5);
end
legend('Raw waveform','Denoised waveform','Picked arrival from raw data','Picked arrival from denoised data','Ground-truth','Position',[x0+0.1,y0-0.1,0.6,0.1],'NumColumns',5);
legend('boxoff');
% 
%% add station name
for ir=nr:-1:1
a1=axes('Parent',gcf,'Position',[0.02,y0+dh*(nr-ir)+dh/4,dw,dh1]);
text(-0.035,0,stname{ir},'color','k','Fontsize',10,'fontweight','bold');axis off;

a1=axes('Parent',gcf,'Position',[0.02+0.5,y0+dh*(nr-ir)+dh/4,dw,dh1]);
text(-0.035,0,stname{ir+15},'color','k','Fontsize',10,'fontweight','bold');axis off;
end
%
%
%% add source info
dw2=(1-x0)/5.0;
a1=axes('Parent',gcf,'Position',[0,0.93,1,dh1]);
text(0.5,0,'Earthquake detection of FORGE\_78-32\_iDASv3-P11\_UTC190423213209.sgy','color','k','Fontsize',14,'fontweight','bold','HorizontalAlignment','center');axis off;
print(gcf,'-depsc','-r300','fig6.eps');



% 
