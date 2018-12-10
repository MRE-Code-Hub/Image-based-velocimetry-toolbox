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
n=200; %number of processed frames (-)
f=5000; %video sampling rate (Hz)
horizontalres=1280; %horizontal resolution
verticalres=512; %vertical resolution

N=5; %neighbourhood size (px)
F=15; %filter size (px)
grad=5; %gradient threshold (1/px)
%note that this threshold is NOT normalised

%% Reading video
%indicate video reader object
files=dir('*.avi');  
r=VideoReader(files(1).name);
 
%preallocation
Usum = zeros(verticalres,horizontalres);
Vsum = zeros(verticalres,horizontalres);
indsum = zeros(verticalres,horizontalres);
 
%% Optical flow computations
opticFlow=opticalFlowFarneback('NumPyramidLevels',2,'PyramidScale',0.5,'NumIterations',3,'NeighborhoodSize',N,'FilterSize',F);

for i=1:1:n %loop over frames
 %read image file and fliplr
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
 
 %instantaneous streamwise and normal velocities
 u=flow.Vx*f; %px/s
 v=flow.Vy*f; %px/s
 
 %clear velocities if gradient lower than threshold
 u(ind==0)=NaN;
 v(ind==0)=NaN;
  
 %sum streamwise velocities 
 tmpu=cat(3,Usum,u); 
 Usum=nansum(tmpu,3);
 clear tmpu
 
 %sum normal velocities 
 tmpv=cat(3,Vsum,v); 
 Vsum=nansum(tmpv,3);
 clear tmpv
 
 %for a counter, download the fprintf_r file from mathworks
 %https://au.mathworks.com/matlabcentral/fileexchange/27903-fprintf_r-carriage-return-without-linefeed
 %and uncomment the following line  
 
 %fprintf_r('%i', i); 
 end %end loop frames
 
%% Computation of time-averaged flow parameters
%time-averaged optical flow field 
U=Usum./indsum; %px/s
V=Vsum./indsum; %px/s

%amount of non-rejected data
datayield=indsum./n;
 
%% Plot U, V, data yield
%region of interest (for plotting)
ROIx=1:1280;
ROIy=1:455;

figure(1)
set(gcf,'Position', [400 400 450 500])
subplot(3,1,1)
surf(U(ROIy,ROIx),'EdgeColor','none','LineStyle','none','FaceLighting','phong');
view(2)
xticks([]);
ylabel('y (px)','Interpreter', 'latex','FontSize',10)
set(gca,'Ydir','reverse')
set(gca,'TickLabelInterpreter', 'latex');
caxis([0 5000]);
c = colorbar('eastoutside');
ylabel(c, 'U (px/s)','Interpreter', 'latex','FontSize',10)
set(c,'TickLabelInterpreter', 'latex');
set(gca,'xlim',[1 ROIx(end)],'ylim',[1 ROIy(end)]);
box on 

subplot(3,1,2)
surf(-V(ROIy,ROIx),'EdgeColor','none','LineStyle','none','FaceLighting','phong');
view(2)
xticks([]);
ylabel('y (px)','Interpreter', 'latex','FontSize',10)
set(gca,'Ydir','reverse')
set(gca,'TickLabelInterpreter', 'latex');
caxis([-2000 2000]);
c = colorbar('eastoutside');
ylabel(c, 'V (px/s)','Interpreter', 'latex','FontSize',10)
set(c,'TickLabelInterpreter', 'latex');
set(gca,'xlim',[1 ROIx(end)],'ylim',[1 ROIy(end)]);
box on 
 
subplot(3,1,3)
surf(datayield(ROIy,ROIx),'EdgeColor','none','LineStyle','none','FaceLighting','phong');
set(gca,'Ydir','reverse')
set(gca,'TickLabelInterpreter', 'latex');
ylabel('y (px)','Interpreter', 'latex','FontSize',10)
xlabel('x (px)','Interpreter', 'latex','FontSize',10)
view(2)
caxis([0 1]);
colormap hot
c = colorbar('eastoutside');
ylabel(c, 'data yield','Interpreter', 'latex','FontSize',10)
set(c,'TickLabelInterpreter', 'latex');
set(gca,'xlim',[1 ROIx(end)],'ylim',[1 ROIy(end)]);
box on 

toc;


