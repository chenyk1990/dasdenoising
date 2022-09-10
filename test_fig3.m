% Script to plot Figure 4
% BY Yangkang Chen
% Dec, 21, 2021
% This script takes about 5-10 minutes
clc;clear;close all;
%please download seistr package from https://github.com/chenyk1990/seistr
addpath(genpath('seistr/'));
addpath(genpath('subroutines/'));

eq=zeros(2000,960);
[n1,n2]=size(eq);
for ii=3
    if ~ismember(ii,[14,16,17,27,47,52])
        strcat('mat_raw/eq-',num2str(ii),'.mat')
        load(strcat('mat_raw/eq-',num2str(ii),'.mat'));
    end
    d1=d1;
    eq=d1;
    
    %% BP
    d1=das_bandpass(d1,0.0005,0,200,6,6,0,0);%
    d_bp=d1;
    
    %% SOMF
%     [pp]=str_dip2d(d1,2,10,2,0.01, 1, 0.000001,[50,50,1],1);%figure;das_imagesc(pp);colormap(jet);
    ns=8;order=2;eps=0.01;
%     d1=das_pwsmooth_lop_mf(d1,pp,ns,order,eps,0);%SOMF
    d_bpsomf=d1;
    load(strcat('mat_bpsomffk/eq-',num2str(ii),'.mat'));
    %% FK
    d1=d1-das_fk_dip(d1,0.02);%
    d_bpsomffk=d1;
end

%ii=3: FORGE_78-32_iDASv3-P11_UTC190423213209.sgy, 1484, 3.394402, 0.910045

t=[0:n1]*0.0005;
x=1:n2;
ngap=50;

eq2=[eq,zeros(n1,ngap),zeros(size(eq))];
d_bp2=[d_bp,zeros(n1,ngap),eq-d_bp];
d_bpsomf2=[d_bpsomf,zeros(n1,ngap),eq-d_bpsomf];
d_bpsomffk2=[d_bpsomffk,zeros(n1,ngap),eq-d_bpsomffk];
x=1:ngap+n2*2;

%% set xticks
xts1=[300,600,960];
xts2=xts1+ngap+n2;
% xts3=xts1+ngap*2+nx*2;
% xts4=xts1+ngap*3+nx*3;
% xts5=xts1+ngap*4+nx*4;
% xts6=xts1+ngap*5+nx*5;
% xts7=xts1+ngap*6+nx*6;
% xts8=xts1+ngap*7+nx*7;
xts=[xts1,xts2];
%% combined figure
figure('units','normalized','Position',[0.0 0.0 0.5, 1],'color','w');
subplot(4,2,1);das_imagesc(eq2,100,2,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.1,'(a)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'rectangle',[0.13 0.894 0.334 0.030],'linewidth',2,'color','g');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

subplot(4,2,2);das_imagesc(d_bp2,100,2,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'BP','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2+ngap+n2/2,-0.05,'Removed noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'textarrow',[0.679 0.700],...
    [0.85 0.90],'Color','r','TextColor','r','HorizontalAlignment','center',...
    'String',{'High-amplitude erratic noise'},...
    'LineWidth',2,...
    'FontSize',10,'fontweight','bold');
text(-200,-0.1,'(b)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'rectangle',[0.57 0.894 0.334 0.030],'linewidth',2,'color','g');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

subplot(4,2,3);das_imagesc(d_bpsomf2,100,2,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'BP+SOMF','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2+ngap+n2/2,-0.05,'Removed noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'textarrow',[0.190 0.192],...
    [0.65 0.694],'Color','r','TextColor','r','HorizontalAlignment','center',...
    'String',{'Horizontal noise'},...
    'LineWidth',2,...
    'FontSize',10,'fontweight','bold');
text(-200,-0.1,'(c)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'rectangle',[0.13 0.675 0.334 0.030],'linewidth',2,'color','g');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

subplot(4,2,4);das_imagesc(d_bpsomffk2,100,2,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'BP+SOMF+FK','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2+ngap+n2/2,-0.05,'Removed noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.1,'(d)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'rectangle',[0.57 0.675 0.334 0.030],'linewidth',2,'color','g');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

inds1=1:400;
subplot(4,2,5);das_imagesc(eq2(inds1,:),100,2,x,t(inds1));
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.01,'Raw data (zoomed)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.02,'(e)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

subplot(4,2,6);das_imagesc(d_bp2(inds1,:),100,2,x,t(inds1));
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.01,'BP (zoomed)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2+ngap+n2/2,-0.01,'Removed noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.02,'(f)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'textarrow',[0.679 0.700],...
    [0.42 0.47],'Color','r','TextColor','r','HorizontalAlignment','center',...
    'String',{'High-amplitude erratic noise'},...
    'LineWidth',2,...
    'FontSize',10,'fontweight','bold');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

subplot(4,2,7);das_imagesc(d_bpsomf2(inds1,:),100,2,x,t(inds1));
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.01,'BP+SOMF (zoomed)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2+ngap+n2/2,-0.01,'Removed noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.02,'(g)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'textarrow',[0.189 0.210],...
    [0.202 0.246],'Color','r','TextColor','r','HorizontalAlignment','center',...
    'String',{'Horizontal noise'},...
    'LineWidth',2,...
    'FontSize',10,'fontweight','bold');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

subplot(4,2,8);das_imagesc(d_bpsomffk2(inds1,:),100,2,x,t(inds1));
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.01,'BP+SOMF+FK (zoomed)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2+ngap+n2/2,-0.01,'Removed noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.02,'(h)','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});


print(gcf,'-depsc','-r300','fig3.eps');



