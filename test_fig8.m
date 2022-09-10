clc;clear;close all;
addpath(genpath('subroutines/'));

%% load data
eq=zeros(2000,960);
[n1,n2]=size(eq);
ii=1;
if ~ismember(ii,[14,16,17,27,47,52])
    load(strcat('mat_raw/eq-',num2str(ii),'.mat'));
end
eq=d1;

%% BP
d111=das_bandpass(d1,0.0005,0,200,6,6,0,0);%
d_bp=d111;

%% SOMF
% [pp]=str_dip2d(d111,2,10,2,0.01, 1, 0.000001,[50,50,1],1);%figure;das_imagesc(pp);colormap(jet);
ns=8;order=2;eps=0.01;
% d11=das_pwsmooth_lop_mf(d111,pp,ns,order,eps,0);%SOMF
% d_bpsomf=d11;

%% FK
% d1=d11-das_fk_dip(d11,0.02);%
% d_bpsomffk=d1;

load(strcat('mat_bpsomffk/eq-',num2str(ii),'.mat'));
figure;das_imagesc([eq,d1,eq-d1]);

% save fig88.mat d_bp d_bpsomf d_bpsomffk
load fig88.mat
figure;das_imagesc([d1,d_bpsomffk,d1-d_bpsomffk]);

%% pick manually
xx1=1:n2;
figure('units','normalized','Position',[0.2 0.4 1, 0.8],'color','w');
yc_imagesc(d1,99,1,xx1,1:n1);
load second_picks.mat
% [x1,y1]=getpts;
% save second_picks.mat x1 y1

yy1=round(interp1(x1(1:2:end),y1(1:2:end),xx1,'spline'));
times=yy1;

figure;yc_imagesc(d1,99,1,xx1,1:n1);hold on;plot(x1,y1,'ro');plot(xx1,yy1,'bo');


inds=20:20:n2; %works fine
inds=100:10:n2;
inds=inds(1:30);
traces=d1(:,inds);
traces0=eq(:,inds);

dn=traces;
d0=traces0;
nsta=30;nlta=300;
O=ones(size(inds));O0=ones(size(inds));
[ O,R ] = das_picker_stalta(dn,nsta, nlta);
[ O0,R0 ] = das_picker_stalta(d0,nsta, nlta);

[ O_bp,R_bp ] = das_picker_stalta(d_bp(:,inds),nsta, nlta);
[ O_bpsomf,R_bpsomf ] = das_picker_stalta(d_bpsomf(:,inds),nsta, nlta);
[ O_bpsomffk,R_bpsomffk ] = das_picker_stalta(d_bpsomffk(:,inds),nsta, nlta);

times0=[O0-1]*0.0005;
times=[O-1]*0.0005;
timest=[yy1(inds)-1]*0.0005; %true

times_bp=[O_bp-1]*0.0005;
times_bpsomf=[O_bpsomf-1]*0.0005;
times_bpsomffk=[O_bpsomffk-1]*0.0005;
norm(times_bpsomffk-times)

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
    wav0=traces0(:,ir)/4;
    wav=traces(:,ir);
    a1=axes('Parent',gcf,'Position',[x0,y0+dy+dh*(nr-ir),dw,dh1]);
    plot(t,(wav0),'k','linewidth',1.5); hold on; axis off;
    plot(t,wav,'r','linewidth',1.5);
    plot([times0(ir),times0(ir)],[min(wav),max(wav)],'g','linewidth',1.5);
    plot([times(ir),times(ir)],[min(wav),max(wav)],'b','linewidth',1.5);
    plot([times_bp(ir),times_bp(ir)],[min(wav),max(wav)],'y','linewidth',1.5);
    plot([times_bpsomf(ir),times_bpsomf(ir)],[min(wav),max(wav)],'c','linewidth',1.5);
    plot([timest(ir),timest(ir)],[min(wav),max(wav)],'m-.','linewidth',1.5);
    ylim([min(wav)-0.4,max(wav)+0.4]);
    
    wav0=traces0(:,ir+15)/4;
    wav=traces(:,ir+15);
    a1=axes('Parent',gcf,'Position',[x0+0.5,y0+dy+dh*(nr-ir),dw,dh1]);
    plot(t,(wav0),'k','linewidth',1.5);hold on; axis off;
    plot(t,wav,'r','linewidth',1.5);
    plot([times0(ir+15),times0(ir+15)],[min(wav),max(wav)],'g','linewidth',1.5);
    plot([times(ir+15),times(ir+15)],[min(wav),max(wav)],'b','linewidth',1.5);
    plot([times_bp(ir+15),times_bp(ir+15)],[min(wav),max(wav)],'y','linewidth',1.5);
    plot([times_bpsomf(ir+15),times_bpsomf(ir+15)],[min(wav),max(wav)],'c','linewidth',1.5);
    plot([timest(ir+15),timest(ir+15)],[min(wav),max(wav)],'m-.','linewidth',1.5);
    ylim([min(wav)-0.4,max(wav)+0.4]);

end
legend('Raw waveform','Denoised waveform','Picked arrival from raw data','Picked arrival from BP+SOMF+FK','Picked arrival from BP','Picked arrival from BP+SOMF','Ground-truth','Position',[x0+0.1,y0-0.1,0.6,0.1],'NumColumns',4);
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
text(0.5,0,'Earthquake detection of FORGE\_78-32\_iDASv3-P11\_UTC190423150554.sgy','color','k','Fontsize',14,'fontweight','bold','HorizontalAlignment','center');axis off;
print(gcf,'-depsc','-r300','fig8.eps');



%% new figure
nsta=10;
nlta=200;
[ A_eq,~ ] = das_picker_stalta(eq,nsta, nlta);
[ A_bp,~ ] = das_picker_stalta(d_bp,nsta, nlta);
[ A_bpsomf,~ ] = das_picker_stalta(d_bpsomf,nsta, nlta);
[ A_bpsomffk,~ ] = das_picker_stalta(d_bpsomffk,nsta, nlta);

%% error
inds=50:500;
e0=sum(abs(A_eq(inds)-yy1(inds)))/length(inds)*0.0005;
e3=sum(abs(A_bpsomffk(inds)-yy1(inds)))/length(inds)*0.0005;
e2=sum(abs(A_bpsomf(inds)-yy1(inds)))/length(inds)*0.0005;
e1=sum(abs(A_bp(inds)-yy1(inds)))/length(inds)*0.0005;

x=1:960;
t=[0:1000-1]*0.0005;
figure('units','normalized','Position',[0.0 0.0 0.6, 1],'color','w');
subplot(5,2,[1,3]);
das_imagesc(eq(1:1000,:),98,1,x,t);
hold on;plot(xx1,[yy1-1]*0.0005,'mo','linewidth',1.5);
plot(xx1,[A_eq-1]*0.0005,'go','linewidth',1.5);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
% xlabel('Channel','Fontsize',10,'fontweight','bold');
xlim([0,570]);
tl=sprintf('Raw data (Error=%.3f s)',e0);
title(tl,'Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(-60,-0.02,'(a)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');

subplot(5,2,[2,4]);
das_imagesc(d_bp(1:1000,:),98,1,x,t);
hold on;plot(xx1,[yy1-1]*0.0005,'mo','linewidth',1.5);
plot(xx1,[A_bp-1]*0.0005,'yo','linewidth',1.5);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
% xlabel('Channel','Fontsize',10,'fontweight','bold');
xlim([0,570]);
tl=sprintf('BP (Error=%.3f s)',e1);
title(tl,'Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(-60,-0.02,'(b)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');

subplot(5,2,[5,7]);
das_imagesc(d_bpsomf(1:1000,:),98,1,x,t);
hold on;plot(xx1,[yy1-1]*0.0005,'mo','linewidth',1.5);
plot(xx1,[A_bpsomf-1]*0.0005,'co','linewidth',1.5);
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
xlim([0,570]);
tl=sprintf('BP+SOMF (Error=%.3f s)',e2);
title(tl,'Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(-60,-0.02,'(c)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');

subplot(5,2,[6,8]);
das_imagesc(d_bpsomffk(1:1000,:),98,1,x,t);
hold on;plot(xx1,[yy1-1]*0.0005,'mo','linewidth',1.5);
plot(900,1,'go','linewidth',1.5); %for legend
plot(xx1,[A_bpsomffk-1]*0.0005,'bo','linewidth',1.5);
plot(900,1,'yo','linewidth',1.5); %for legend
plot(900,1,'co','linewidth',1.5); %for legend
ylabel('Time (s)','Fontsize',10,'fontweight','bold');
xlabel('Channel','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
xlim([0,570]);
tl=sprintf('BP+SOMF+FK (Error=%.3f s)',e3);
title(tl,'Fontsize',10,'fontweight','bold');
text(-60,-0.02,'(d)','color','k','Fontsize',15,'fontweight','bold','HorizontalAlignment','center');

legend('Ground-truth','Picked arrival from raw data','Picked arrival from BPSOMFFK','Picked arrival from BP','Picked arrival from BPSOMF','Position',[0.1,0.1,0.6,0.1],'NumColumns',3);
legend('boxoff');


annotation(gcf,'ellipse',...
    [0.224537037037037 0.437086092715232 0.244212962962963 0.0278145695364239],'color','r','LineWidth',2);
annotation(gcf,'rectangle',...
    [0.825231481481481 0.654304635761589 0.0763888888888898 0.186754966887417],'color','r','LineWidth',2);
annotation(gcf,'arrow',[0.328703703703704 0.305555555555556],...
    [0.747019867549669 0.721854304635762],'color','r','LineWidth',2);
annotation(gcf,'ellipse',...
    [0.140046296296296 0.652980132450331 0.320601851851851 0.0304635761589401],'color','r','LineWidth',2);
annotation(gcf,'ellipse',...
    [0.137731481481481 0.694039735099338 0.320601851851851 0.0304635761589404],'color','r','LineWidth',2);
annotation(gcf,'textarrow',[0.333333333333333 0.329861111111111],...
    [0.746019867549669 0.682119205298013],...
    'String',{'Effect of horizontal noise'},'color','r','LineWidth',2,'fontsize',15,'fontweight','bold');
annotation(gcf,'textarrow',[0.333333333333333 0.344907407407407],...
    [0.544370860927152 0.470198675496689],...
    'String',{'Effect of horizontal noise'},'color','r','LineWidth',2,'fontsize',15,'fontweight','bold');

annotation(gcf,'textarrow',[0.778935185185184 0.822916666666667],...
    [0.758940397350993 0.757615894039735],'String',{'Effect of erratic noise'},'color','r','LineWidth',2,'fontsize',15,'fontweight','bold');

print(gcf,'-depsc','-r300','fig9.eps');






