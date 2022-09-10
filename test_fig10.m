% Script to plot Figure 10
% BY Yangkang Chen
% Dec, 23, 2021

clc;clear;close all;

NOs=[1,3,20,10,25,11,2];
labels={...                                          %P-arrival sample NO from the SEGY file
    'FORGE\_78-32\_iDASv3-P11\_UTC190423150554.sgy',... %24169
    'FORGE\_78-32\_iDASv3-P11\_UTC190423213209.sgy',... 
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
indt1=10:250;indx1=750:900;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
%% BP
d1=das_bandpass(d1,0.0005,0,200,6,6,0,0);%
%% FK
d1=d1-das_fk_dip(d1,0.02);%
d1_mf=d1;

d1_z1=d1_mf(indt1,indx1);
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
d1_somf=d1;
d1_z2=d1_somf(indt1,indx1);
comp1=[eq,zeros(n1,ngap),d1_mf,zeros(n1,ngap),eq-d1_mf,zeros(n1,ngap),d1_somf,zeros(n1,ngap),eq-d1_somf]; 

%% second one
ii=2;
indt2=50:200;indx2=750:860;
if ~ismember(NOs(ii),[14,16,17,27,47,52])
     load(strcat('mat_raw/eq-',num2str(NOs(ii)),'.mat'));
end
eq=d1;
%% BP
d1=das_bandpass(d1,0.0005,0,200,6,6,0,0);%
%% FK
d1=d1-das_fk_dip(d1,0.02);%
d1_mf=d1;

d2_z1=d1_mf(indt2,indx2);
load(strcat('mat_bpsomffk/eq-',num2str(NOs(ii)),'.mat'));
d1_somf=d1;
d2_z2=d1_somf(indt2,indx2);
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
text((n2*2+ngap*3)/2+n2,-0.02,'BP+FK','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text((n2*2+ngap*3)/2+n2*3+ngap*2,-0.02,'BP+SOMF+FK','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.02,'(a)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(50,0.46,labels{1},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');
hold on;
plot([indx1(1)+n2+ngap,indx1(1)+n2+ngap],t([indt1(1),indt1(end)]),'r','linewidth',2);
plot([indx1(end)+n2+ngap,indx1(end)+n2+ngap],t([indt1(1),indt1(end)]),'r','linewidth',2);
plot([indx1(1)+n2+ngap,indx1(end)+n2+ngap],t([indt1(1),indt1(1)]),'r','linewidth',2);
plot([indx1(1)+n2+ngap,indx1(end)+n2+ngap],t([indt1(end),indt1(end)]),'r','linewidth',2);

plot([indx1(1)+n2*3+ngap*3,indx1(1)+n2*3+ngap*3],t([indt1(1),indt1(end)]),'r','linewidth',2);
plot([indx1(end)+n2*3+ngap*3,indx1(end)+n2*3+ngap*3],t([indt1(1),indt1(end)]),'r','linewidth',2);
plot([indx1(1)+n2*3+ngap*3,indx1(end)+n2*3+ngap*3],t([indt1(1),indt1(1)]),'r','linewidth',2);
plot([indx1(1)+n2*3+ngap*3,indx1(end)+n2*3+ngap*3],t([indt1(end),indt1(end)]),'r','linewidth',2);

annotation(gcf,'arrow',[0.394 0.364],[0.871 0.832],'linewidth',2,'color','r');
annotation(gcf,'textarrow',[0.377 0.377],[0.761 0.791],'String','Artifacts','linewidth',2,'color','g','fontsize',15,'fontweight','bold');
annotation(gcf,'arrow',[0.71 0.68],[0.871 0.832],'linewidth',2,'color','r');
annotation(gcf,'arrow',[0.697 0.697],[0.761 0.791],'linewidth',2,'color','g');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

subplot(2,1,2);das_imagesc(comp2(1:1000,:),98,1,x,t(1:1000));
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(n2/2,-0.02,'Raw data','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text((n2*2+ngap*3)/2+n2,-0.02,'BP+FK','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text((n2*2+ngap*3)/2+n2*3+ngap*2,-0.02,'BP+SOMF+FK','color','k','Fontsize',10,'fontweight','bold','HorizontalAlignment','center');
text(-200,-0.02,'(b)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');
text(50,0.46,labels{2},'color','b','Fontsize',10,'fontweight','bold','HorizontalAlignment','left');
hold on;
plot([indx2(1)+n2+ngap,indx2(1)+n2+ngap],t([indt2(1),indt2(end)]),'r','linewidth',2);
plot([indx2(end)+n2+ngap,indx2(end)+n2+ngap],t([indt2(1),indt2(end)]),'r','linewidth',2);
plot([indx2(1)+n2+ngap,indx2(end)+n2+ngap],t([indt2(1),indt2(1)]),'r','linewidth',2);
plot([indx2(1)+n2+ngap,indx2(end)+n2+ngap],t([indt2(end),indt2(end)]),'r','linewidth',2);

plot([indx2(1)+n2*3+ngap*3,indx2(1)+n2*3+ngap*3],t([indt2(1),indt2(end)]),'r','linewidth',2);
plot([indx2(end)+n2*3+ngap*3,indx2(end)+n2*3+ngap*3],t([indt2(1),indt2(end)]),'r','linewidth',2);
plot([indx2(1)+n2*3+ngap*3,indx2(end)+n2*3+ngap*3],t([indt2(1),indt2(1)]),'r','linewidth',2);
plot([indx2(1)+n2*3+ngap*3,indx2(end)+n2*3+ngap*3],t([indt2(end),indt2(end)]),'r','linewidth',2);

annotation(gcf,'arrow',[0.394 0.364],[0.371 0.332],'linewidth',2,'color','r');
annotation(gcf,'textarrow',[0.307 0.307],[0.281 0.311],'String','Artifacts','linewidth',2,'color','g','fontsize',15,'fontweight','bold');
annotation(gcf,'arrow',[0.71 0.68],[0.371 0.332],'linewidth',2,'color','r');
annotation(gcf,'arrow',[0.627 0.627],[0.281 0.311],'linewidth',2,'color','g');
xticks(xts);set(gca,'xticklabel',{'300','600','960'});

%% add zooming framebox

a1=axes('Parent',gcf,'Position',[0.287,0.68,0.149,0.15]);
das_imagesc(d1_z1,20,2);axis off;

a1=axes('Parent',gcf,'Position',[0.600,0.68,0.149,0.15]);
das_imagesc(d1_z2,20,2);axis off;


a1=axes('Parent',gcf,'Position',[0.287,0.18,0.149,0.15]);
das_imagesc(d2_z1,50,2);axis off;

a1=axes('Parent',gcf,'Position',[0.600,0.18,0.149,0.15]);
das_imagesc(d2_z2,50,2);axis off;

print(gcf,'-depsc','-r300','fig10.eps');
