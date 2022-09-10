% Script to plot Figure 3
% BY Yangkang Chen
% Dec, 20, 2021

clc;clear;close all;
addpath(genpath('subroutines/'));

%% load data (This data is from https://github.com/chenyk1990/dasdenoising-dataonly/blob/main/subroutines/micro_sf_3001_334_3.mat)
load micro_sf_3001_334_3.mat
d=das_scale(data(:,:,1),2);
dt=0.0005;
t=[0:nt-1]*dt;
h=[0:nx-1]*dx+0;

%% load noise (This data is from https://github.com/chenyk1990/dasdenoising-dataonly/blob/main/subroutines/micro_sf_3001_334_3.mat)
load fig2noise.mat

randn('state',211111);
nnn=das_seisdither(nn,round(das_meanf(20*randn(1,nx),20,1,2)));
% figure;imagesc([nn,nnn]);

randn('state',2111112);
nnn2=das_seisdither(nn2,round(das_meanfs(10*randn(1,nt),20,1,2,100)));
% figure;imagesc([nn2,nnn2]);

% dn=d+0.2*nn+0.2*nn2';
dn1=d+0.2*nnn;
dn2=d+0.2*nn2';

tt=dn2-das_fk_dip(dn2',0.02)';
% figure;imagesc([dn2,tt,dn2-tt]);

%% calculate FK
% dt=0.004;

[D1,f,k]=das_fk2d_plot(dn1,dt,1);
[D2,f2,k2]=das_fk2d_plot(dn2',dx,1);

d1=dn1-das_fk_dip(dn1,0.2);
D11=das_fk2d_plot(d1,dt,1);

d2=dn2-das_fk_dip(dn2',0.02)';
D22=das_fk2d_plot(d2',dx,1);
%%
figure('units','normalized','Position',[0.0 0.0 1, 1],'color','w');
subplot(2,4,1);
imagesc(h,t,dn1);caxis([-0.5,0.5]);
ylabel('Time (s)','Fontsize',20,'fontweight','bold');
xlabel('Lateral distance (km)','Fontsize',20,'fontweight','bold');
title('Horizontal noise','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
colormap(jet);

subplot(2,4,2);
imagesc(k,f,abs(D1));caxis([0,1000]);
ylabel('Frequency (Hz)','Fontsize',20,'fontweight','bold');
xlabel('Normalized wavenumber','Fontsize',20,'fontweight','bold');
title('FK spectrum','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
ylim([0,200]);

subplot(2,4,3);
imagesc(h,t,d1);caxis([-0.5,0.5]);
ylabel('Time (s)','Fontsize',20,'fontweight','bold');
xlabel('Lateral distance (km)','Fontsize',20,'fontweight','bold');
title('Denoised data','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
colormap(jet);

subplot(2,4,4);
imagesc(k,f,abs(D11));caxis([0,1000]);
ylabel('Frequency (Hz)','Fontsize',20,'fontweight','bold');
xlabel('Normalized wavenumber','Fontsize',20,'fontweight','bold');
title('FK spectrum (w=0.2)','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
ylim([0,200]);



subplot(2,4,5);
imagesc(h,t,dn2);caxis([-0.5,0.5]);
ylabel('Time (s)','Fontsize',20,'fontweight','bold');
xlabel('Lateral distance (km)','Fontsize',20,'fontweight','bold');
title('Vertical noise','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
colormap(jet);

subplot(2,4,6);
imagesc(k2,f2,abs(D2));caxis([0,100]);
ylabel('Wavenumber (1/km)','Fontsize',20,'fontweight','bold');
xlabel('Normalized frequency','Fontsize',20,'fontweight','bold');
title('FK spectrum','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
ylim([0,20]);

subplot(2,4,7);
imagesc(h,t,d2);caxis([-0.5,0.5]);
ylabel('Time (s)','Fontsize',20,'fontweight','bold');
xlabel('Lateral distance (km)','Fontsize',20,'fontweight','bold');
title('Denoised data','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
colormap(jet);

subplot(2,4,8);
imagesc(k2,f2,abs(D22));caxis([0,100]);
ylabel('Wavenumber (1/km)','Fontsize',20,'fontweight','bold');
xlabel('Normalized frequency','Fontsize',20,'fontweight','bold');
title('FK spectrum (w=0.02)','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
ylim([0,20]);
print(gcf,'-depsc','-r300','fig2.eps');
