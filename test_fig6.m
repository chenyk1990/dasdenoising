% Script to plot Figure 9
% BY Yangkang Chen
% Dec, 23, 2021

clc;clear;close all;

NOs=[3,20,10,25,11,2];
labels={...                                          %P-arrival sample NO from the SEGY file
    'FORGE\_78-32\_iDASv3-P11\_UTC190423213209.sgy',... %
    'FORGE\_78-32\_iDASv3-P11\_UTC190426070723.sgy',... %24811
    'FORGE\_78-32\_iDASv3-P11\_UTC190426062208.sgy',... %26090
    'FORGE\_78-32\_iDASv3-P11\_UTC190426110008.sgy',... %4921
    'FORGE\_78-32\_iDASv3-P11\_UTC190426062553.sgy',... %8934
    'FORGE\_78-32\_iDASv3-P11\_UTC190423182409.sgy'};   %4210

eq=zeros(2000,960);
[n1,n2]=size(eq);
t=[0:n1]*0.0005;
ngap=50;
x=1:n2*5+4*ngap;
%% first one
ii=1;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
%% BP
d1=das_bandpass(d1,0.0005,0,200,6,6,0,0);%
%% MF
ns=8;
d1=das_mf(d1,ns*2+1,1,2);
%% FK
d1=d1-das_fk_dip(d1,0.02);%
d1_mf=d1;
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
d1_somf=d1;
comp1=[eq,zeros(n1,ngap),d1_mf,zeros(n1,ngap),eq-d1_mf,zeros(n1,ngap),d1_somf,zeros(n1,ngap),eq-d1_somf];

%% second one
ii=2;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
%% BP
d1=das_bandpass(d1,0.0005,0,200,6,6,0,0);%
%% MF
ns=8;
d1=das_mf(d1,ns*2+1,1,2);
%% FK
d1=d1-das_fk_dip(d1,0.02);%
d1_mf=d1;
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
d1_somf=d1;
comp2=[eq,zeros(n1,ngap),d1_mf,zeros(n1,ngap),eq-d1_mf,zeros(n1,ngap),d1_somf,zeros(n1,ngap),eq-d1_somf];

%% set xticks
xts1=[300,600,960];
xts2=xts1+ngap+n2;
xts3=xts1+ngap*2+n2*2;
xts4=xts1+ngap*3+n2*3;
xts5=xts1+ngap*4+n2*4;
xts=[xts1,xts2,xts3,xts4,xts5];

%% combined figure
figure('units','normalized','Position',[0.0 0.0 0.6, 1],'color','w');
subplot(2,1,1);das_imagesc(comp1(1:1000,:),98,1,x,t(1:1000));
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.02,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text((n2*2+ngap*3)/2+n2,-0.02,'BP+MF+FK','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text((n2*2+ngap*3)/2+n2*3+ngap*2,-0.02,'BP+SOMF+FK','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.02,'(a)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(50,0.46,labels{1},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');

annotation(gcf,'textarrow',[0.446 0.454],[0.822 0.791],'String',{'Stronger signal leakage'},'color','r','Fontsize',15,'linewidth',2,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'textarrow',[0.765 0.773],[0.822 0.791],'String',{'Weaker signal leakage'},'color','r','Fontsize',15,'linewidth',2,'fontweight','bold','HorizontalAlignment','center');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

subplot(2,1,2);das_imagesc(comp2(900:1200,:),98,1,x,t(900:1200));
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,0.445,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text((n2*2+ngap*3)/2+n2,0.445,'BP+MF+FK','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text((n2*2+ngap*3)/2+n2*3+ngap*2,0.445,'BP+SOMF+FK','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,0.44,'(b)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(50,0.59,labels{2},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');

annotation(gcf,'textarrow',[0.555 0.563],[0.291 0.260],'String',{'Signal leakage'},'color','r','Fontsize',15,'linewidth',2,'fontweight','bold','HorizontalAlignment','center');
annotation(gcf,'textarrow',[0.870 0.878],[0.291 0.260],'String',{''},'color','r','Fontsize',15,'linewidth',2,'fontweight','bold','HorizontalAlignment','center');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

print(gcf,'-depsc','-r300','fig6.eps');
