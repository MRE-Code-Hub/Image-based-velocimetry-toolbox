Indicator function for optical flow estimations in air-water flows
==================================================================

Image-based velocimetry techniques have captured great interest in the laboratory study of air-water flows, for example bubble image velocimetry (BIV) or optical flow (OF). Because recorded video sequences of highly aerated flows are often subject to image noise, a new filtering technique is proposed. This indicator function relies on the image gradient magnitude and works directly on the image plane, including the following benefits: 

- Removal of erroneous data.
- Filtering of foreground movement.
- Filtering of air-water interfaces.

The uploaded source code allows computation of filtered velocity fields in air-water flows with the Farnebäck method ([handle](https://www.ida.liu.se/ext/WITAS-ev/Computer_Vision_Technologies/PaperInfo/farneback02.html)), as implemented in Matlab R2017a. If using the uploaded files for publishing research, please cite the following reference to credit the authors and to direct readers to the original research work:

M. Kramer and H. Chanson (2019). Optical flow estimations in aerated spillway flows: Filtering and discussion on
sampling parameters, Experimental and Thermal Fluid Science ([DOI](https://doi.org/10.1016/j.expthermflusci.2018.12.002))


1 Contents
----------
The code is written in Matlab R2017a. This repository contains source code files and a representative video file:
- RunIF.m: main code to run the optical flow technique with indicator function.
- spillway-data: short video sequence of the air-water flow down a stepped spillway, recorded with a phantom v2011 high-speed video camera.


2 Sampling and processing parameters
------------------------
Important sampling and processing paramters for optical flow estimations (Farnebäck method) and filtering in high-velocity air-water flows are:

- Neighbourhood size N
- Filter size F
- Image pyramid level
- Sampling frequency
- Sampling duration
- Gradient threshold

3 How to run the code?
----------------------
Copy the source code and the *.avi file into the same folder and run "RunIF.m".

4 Contact
----------
I am happy to receive **feedback**, **questions** and **recommendations** in the issue-section or via Email:

- Matthias Kramer, The University of Queensland, Brisbane, Australia. Email: m.kramer@uq.edu.au, [ORCID](https://orcid.org/0000-0001-5673-2751)

