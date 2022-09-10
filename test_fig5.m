% Script to plot Figure 6
% BY Yangkang Chen
% Dec, 22, 2021

clc;clear;close all;
addpath(genpath('subroutines/'));

NOs=[1,20,10,25,11,2];
labels={...                                          %P-arrival sample NO from the SEGY file
    'FORGE\_78-32\_iDASv3-P11\_UTC190423150554.sgy',... %24169
    'FORGE\_78-32\_iDASv3-P11\_UTC190426070723.sgy',... %24811
    'FORGE\_78-32\_iDASv3-P11\_UTC190426062208.sgy',... %26090
    'FORGE\_78-32\_iDASv3-P11\_UTC190426110008.sgy',... %4921
    'FORGE\_78-32\_iDASv3-P11\_UTC190426062553.sgy',... %8934
    'FORGE\_78-32\_iDASv3-P11\_UTC190423182409.sgy'};   %4210

eq=zeros(2000,960);
[n1,n2]=size(eq);
t=[0:n1]*0.0005;
ngap=50;
x=1:n2*3+2*ngap;
%% first one
ii=1;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
comp1=[eq,zeros(n1,ngap),d1,zeros(n1,ngap),eq-d1]; 
%% second one
ii=2;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
comp2=[eq,zeros(n1,ngap),d1,zeros(n1,ngap),eq-d1]; 

%% third one
ii=3;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
comp3=[eq,zeros(n1,ngap),d1,zeros(n1,ngap),eq-d1]; 

%% fourth one
ii=4;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
comp4=[eq,zeros(n1,ngap),d1,zeros(n1,ngap),eq-d1]; 

%% fifth one
ii=5;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
comp5=[eq,zeros(n1,ngap),d1,zeros(n1,ngap),eq-d1]; 

%% sixth one
ii=6;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
comp6=[eq,zeros(n1,ngap),d1,zeros(n1,ngap),eq-d1]; 

%% combined figure
figure('units','normalized','Position',[0.0 0.0 0.5, 1],'color','w');
subplot(3,2,1);das_imagesc(comp1,95,1,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap+n2,-0.05,'Denoised data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap*2+n2*2,-0.05,'Noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.1,'(a)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(0.1,0.95,labels{1},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');

subplot(3,2,2);das_imagesc(comp2,95,1,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap+n2,-0.05,'Denoised data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap*2+n2*2,-0.05,'Noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.1,'(b)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(0.1,0.95,labels{2},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');


subplot(3,2,3);das_imagesc(comp3,95,1,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap+n2,-0.05,'Denoised data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap*2+n2*2,-0.05,'Noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.1,'(c)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(0.1,0.95,labels{3},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');

subplot(3,2,4);das_imagesc(comp4,95,1,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap+n2,-0.05,'Denoised data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap*2+n2*2,-0.05,'Noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.1,'(d)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(0.1,0.95,labels{4},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');

inds1=1:400;
subplot(3,2,5);das_imagesc(comp5,95,1,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap+n2,-0.05,'Denoised data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap*2+n2*2,-0.05,'Noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.1,'(e)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(0.1,0.95,labels{5},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');
annotation(gcf,'textarrow',[0.310 0.289],...
    [0.252 0.296],'Color','r','TextColor','r','HorizontalAlignment','center',...
    'String',{'Visible signal'},...
    'LineWidth',2,...
    'FontSize',10,'fontweight','bold');

subplot(3,2,6);das_imagesc(comp6,95,1,x,t);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.05,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap+n2,-0.05,'Denoised data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(n2/2+ngap*2+n2*2,-0.05,'Noise','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.1,'(f)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(0.1,0.95,labels{6},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');
annotation(gcf,'textarrow',[0.740 0.719],...
    [0.252 0.296],'Color','r','TextColor','r','HorizontalAlignment','center',...
    'String',{'Visible signal'},...
    'LineWidth',2,...
    'FontSize',10,'fontweight','bold');

print(gcf,'-depsc','-r300','fig5.eps');





