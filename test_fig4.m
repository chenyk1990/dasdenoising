% Script to plot Figure 5
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
    [pp]=str_dip2d(d1,2,10,2,0.01, 1, 0.000001,[50,50,1],1);%figure;das_imagesc(pp);colormap(jet);
    ns=8;order=2;eps=0.01;
    d1=das_pwsmooth_lop_mf(d1,pp,ns,order,eps,0);%SOMF
    d_bpsomf=d1;
    
    %% FK
    d1=d1-das_fk_dip(d1,0.02);%
    d_bpsomffk=d1;
end


%ii=3: FORGE_78-32_iDASv3-P11_UTC190423213209.sgy, 1484, 3.394402, 0.910045

t=[0:n1-1]*0.0005;
x=1:n2;
ngap=50;

eq2=[eq,zeros(n1,ngap),zeros(size(eq))];
d_bp2=[d_bp,zeros(n1,ngap),eq-d_bp];
d_bpsomf2=[d_bpsomf,zeros(n1,ngap),eq-d_bpsomf];
d_bpsomffk2=[d_bpsomffk,zeros(n1,ngap),eq-d_bpsomffk];
x=1:ngap+n2*2;

%% begin plotting
% figure('units','normalized','Position',[0.0 0.0 0.45, 1],'color','w');
nr=15;%number of stations in the first column
x0=0.1;y0=0.05;dy=0.13/2;dx=0;
%length: 0.5x0.5, 0.5x0.25, 0.25x0.5
%% axis XY
dh=(1-0.2)/3;dw=0.25;
dh1=0.04;%axis height
dy=0.04;

dh1=0.06;dy=dh1;
nr=3;
labels={'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(h)','(i)'};
ylm=[-199,201];
ylm2=[-199,401];
ylm3=[-199,401];
% traces=[623:631];
traces=[15,16,310,311,624,625,631,778,779];

%trace:624,625,631: perfect
%311,

il=0;
figure('units','normalized','Position',[0.0 0.0 0.5, 1],'color','w');
for ir=1:3
%% first column
ix=traces(3*(ir-1)+1);
a1=axes('Parent',gcf,'Position',[x0,y0+dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpsomffk(:,ix),'k','linewidth',2); ylim(ylm);
if ir<=2
    set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');
else
    xlabel('Time (s)');set(gca,'linewidth',2,'fontweight','bold');
end
a1=axes('Parent',gcf,'Position',[x0,y0+2*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpsomf(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');ylim(ylm);
a1=axes('Parent',gcf,'Position',[x0,y0+3*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bp(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');ylim(ylm);
a1=axes('Parent',gcf,'Position',[x0,y0+4*dy+dh*(nr-ir),dw,dh1]);
plot(t,eq(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold'); ylim(ylm);title(strcat('Channel:',num2str(ix)));

%add component
a1=axes('Parent',gcf,'Position',[x0,y0+dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+SOMF+FK','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0,y0+2*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+SOMF','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0,y0+3*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0,y0+4*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'Raw data','color','r','Fontsize',10,'fontweight','bold');axis off;
%add label
il=il+1;
a1=axes('Parent',gcf,'Position',[x0,y0+5*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(-0.1,0,labels(il),'color','k','Fontsize',15,'fontweight','bold');axis off;

%% Second column
ix=traces(3*(ir-1)+2);
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpsomffk(:,ix),'k','linewidth',2); ylim(ylm2);
if ir<=2
    set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');
else
    xlabel('Time (s)');set(gca,'linewidth',2,'fontweight','bold');
end
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+2*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpsomf(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');ylim(ylm2);
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+3*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bp(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');ylim(ylm2);
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+4*dy+dh*(nr-ir),dw,dh1]);
plot(t,eq(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold'); ylim(ylm2);title(strcat('Channel:',num2str(ix)));

%add component
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+SOMF+FK','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+2*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+SOMF','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+3*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+4*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'Raw data','color','r','Fontsize',10,'fontweight','bold');axis off;
%label
il=il+1;
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+5*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(-0.1,0,labels(il),'color','k','Fontsize',15,'fontweight','bold');axis off;

%% Third column
ix=traces(3*(ir-1)+3);
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpsomffk(:,ix),'k','linewidth',2); ylim(ylm3);
if ir<=2
    set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');
else
    xlabel('Time (s)');set(gca,'linewidth',2,'fontweight','bold');
end
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+2*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpsomf(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');ylim(ylm3);
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+3*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bp(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');ylim(ylm3);
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+4*dy+dh*(nr-ir),dw,dh1]);
plot(t,eq(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');ylim(ylm3);title(strcat('Channel:',num2str(ix)));
%add component
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+SOMF+FK','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+2*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+SOMF','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+3*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+4*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'Raw data','color','r','Fontsize',10,'fontweight','bold');axis off;
%label
il=il+1;
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+5*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(-0.1,0,labels(il),'color','k','Fontsize',15,'fontweight','bold');axis off;

end

print(gcf,'-depsc','-r300','fig4.eps');


