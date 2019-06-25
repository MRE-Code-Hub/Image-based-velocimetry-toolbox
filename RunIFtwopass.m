%% OPTICAL FLOW ESTIMATIONS WITH INDICATOR FUNCTION FOR AIR-WATER FLOWS
%Version 1.0 (January 2019)
%Indicator function for filtering optical flow velocity estimations
%in highly aerated flows
%written by M. Kramer
%contact:
%matthias_kramer@hotmail.com

%when using this code, please cite the following reference:
%---------------------------------------------------------------------%
%M. Kramer and H. Chanson (2018)
%Optical flow estimations in aerated spillway flows:
%Filtering and discussion on sampling parameters
%Experimental and Thermal Fluid Science
%---------------------------------------------------------------------%

clear all
close all
tic;

%% Sampling and processing parameters
nsamples=51951; %number of images (-)
n=35; %number of processes samples (-)
f=5000; %video sampling rate (Hz)
horizontalres=1280; %horizontal resolution
verticalres=512; %vertical resolution

N=5; %neighbourhood-size (px)
F=15; %filter-size (px)
P=2; %number of pyramid levels (-)
grad=5; %gradient threshold (1/px)
%note that this threshold is NOT normalised

%% Reading video
%indicate video reader object
files=dir('*.avi');  
r=VideoReader(files(1).name);
 
%preallocation
indsum = zeros(verticalres,horizontalres);
Usum = zeros(verticalres,horizontalres);
Vsum = zeros(verticalres,horizontalres);
uusum=zeros(verticalres,horizontalres);
uvsum=zeros(verticalres,horizontalres);
vvsum=zeros(verticalres,horizontalres);
conversion = 40/(820-218); %cm/px 

%% Optical flow computations
opticFlow=opticalFlowFarneback('NumPyramidLevels',P,'PyramidScale',0.5,'NumIterations',3,'NeighborhoodSize',N,'FilterSize',F); 

 for i=1:1:n     
 %image
 I=read(r,i);
 
 %calculate image gradient
 [Gmag,~]=imgradient(I,'central');
 
 %indicator function
 ind=zeros(verticalres,horizontalres);
 %local thresholding
 ind(abs(Gmag)>=grad)=1;
 %summation
 indsum=indsum+ind;
         
 %calculate optical flow
 flow=estimateFlow(opticFlow,I);
 
 %output u and v
 u=flow.Vx*f*conversion/100; %m/s
 v=-flow.Vy*f*conversion/100; %m/s
 
 %clear velocities if gradient lower than threshold
 u(ind==0)=NaN;
 v(ind==0)=NaN;
 
 %mean velocities
 tmpu=cat(3,Usum,u); 
 Usum=nansum(tmpu,3);
 clear tmpu
 
 tmpv=cat(3,Vsum,v); 
 Vsum=nansum(tmpv,3);
 clear tmpv
  
 %clear some variables
 clear u v
 
 %step counter
 fprintf_r('%i', i); 
 pause(0.01) 
 end

%% Computation of time-averaged flow parameters
%time-averaged optical flow field 
U=Usum./indsum; %m/s
V=Vsum./indsum; %m/s

%amount of non-rejected data
datayield=indsum./n;  
  
%% SECOND PASS
indsum = zeros(verticalres,horizontalres);

 for i=1:1:n
 %image
 I=read(r,i);
 
 %calculate image gradient
 [Gmag,~]=imgradient(I,'central');
 
 %indicator function
 ind=zeros(verticalres,horizontalres);
 %local thresholding
 ind(abs(Gmag)>=grad)=1;
 %summation
 indsum=indsum+ind;
         
 %calculate optical flow
 flow=estimateFlow(opticFlow,I);
 
 %output u and v
 u=flow.Vx*f*conversion/100; %m/s
 v=-flow.Vy*f*conversion/100; %m/s
  
 %fluctuations
 ustr=U-u;
 vstr=V-v;
 
 uu=ustr.^2;
 uu(ind==0)=NaN;
 tmpuu=cat(3,uusum,uu); 
 uusum=nansum(tmpuu,3);
 clear tmpuu
 
 vv=vstr.^2;
 vv(ind==0)=NaN;
 tmpvv=cat(3,vvsum,vv); 
 vvsum=nansum(tmpvv,3);
 clear tmpvv
 
 uv=ustr.*vstr;
 uv(ind==0)=NaN;
 tmpuv=cat(3,uvsum,uv); 
 uvsum=nansum(tmpuv,3);
 clear tmpuv
    
 %clear some variables
 clear u v ustr vstr uu uv vv 
 
 %step counter
 fprintf_r('%i', i); 
 pause(0.01) 
 end

%% Computation of instantaneous flow parameters
urms=sqrt(uusum./indsum);
vrms=sqrt(vvsum./indsum);
uumean=uusum./indsum;
uvmean=vvsum./indsum;
vvmean=vvsum./indsum;

U1=2.73; %m/s

%% PLOT
figure(1)
set(gcf,'Position', [100 100 900 700])
subplot(2,3,1)
imagesc(U./U1);
xticks([]);
yticks([]);
ylabel('y (px)','Interpreter', 'latex','FontSize',10)
set(gca,'TickLabelInterpreter', 'latex');
caxis([-0.4 0.8]);
c = colorbar('eastoutside');
ylabel(c, '$\langle U \rangle/U_1$','Interpreter', 'latex','FontSize',10)
set(c,'TickLabelInterpreter', 'latex');
set(gca,'xlim',[1 horizontalres],'ylim',[1 verticalres]);
box on 

subplot(2,3,2)
imagesc(V./U1);
xticks([]);
yticks([]);
ylabel('y (px)','Interpreter', 'latex','FontSize',10)
set(gca,'TickLabelInterpreter', 'latex');
caxis([-0.1 0.1]);
c = colorbar('eastoutside');
ylabel(c, '$\langle V \rangle/U_1$','Interpreter', 'latex','FontSize',10)
set(c,'TickLabelInterpreter', 'latex');
set(gca,'xlim',[1 horizontalres],'ylim',[1 verticalres]);
box on 
 
subplot(2,3,3)
imagesc(datayield);
set(gca,'TickLabelInterpreter', 'latex');
ylabel('y (px)','Interpreter', 'latex','FontSize',10)
xlabel('x (px)','Interpreter', 'latex','FontSize',10)
view(2)
yticks([]);
caxis([0 1]);
colormap hot
c = colorbar('eastoutside');
ylabel(c, 'data yield','Interpreter', 'latex','FontSize',10)
set(c,'TickLabelInterpreter', 'latex');
set(gca,'xlim',[1 horizontalres],'ylim',[1 verticalres]);
box on 
 
subplot(2,3,4)
imagesc((urms./U1));
xticks([]);
yticks([]);
ylabel('y (px)','Interpreter', 'latex','FontSize',10)
set(gca,'TickLabelInterpreter', 'latex');
caxis([0 0.6]);
c = colorbar('eastoutside');
ylabel(c, '$u_{rms}/U_1$','Interpreter', 'latex','FontSize',10)
set(c,'TickLabelInterpreter', 'latex');
set(gca,'xlim',[1 horizontalres],'ylim',[1 verticalres]);
box on 

subplot(2,3,5)
imagesc(vrms./U1);
xticks([]);
yticks([]);
ylabel('y (px)','Interpreter', 'latex','FontSize',10)
set(gca,'TickLabelInterpreter', 'latex');
caxis([0 0.6]);
c = colorbar('eastoutside');
ylabel(c, '$v_{rms}/U_1$','Interpreter', 'latex','FontSize',10)
set(c,'TickLabelInterpreter', 'latex');
set(gca,'xlim',[1 horizontalres],'ylim',[1 verticalres]);
box on 


subplot(2,3,6)
imagesc(uvmean./(U1^2));
view(2)
xticks([]);
yticks([]);
ylabel('y (px)','Interpreter', 'latex','FontSize',10)
set(gca,'Ydir','reverse')
set(gca,'TickLabelInterpreter', 'latex');
caxis([0 0.6]);
c = colorbar('eastoutside');
ylabel(c, '$uv/U_1^2$','Interpreter', 'latex','FontSize',10)
set(c,'TickLabelInterpreter', 'latex');
set(gca,'xlim',[1 horizontalres],'ylim',[1 verticalres]);
box on 

 
save('data.mat','F','P','N','grad','U','V','urms','vrms','uumean','uvmean','vvmean','datayield','horizontalres','verticalres') 

toc;


