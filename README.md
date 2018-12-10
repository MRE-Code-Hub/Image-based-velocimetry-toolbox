Indicator function for optical flow estimations in air-water flows
==================================================================

Image-based velocimetry techniques have captured great interest in the laboratory study of air-water flows, for example **bubble image velocimetry** (BIV), **particle tracking** or **optical flow** (OF). Because recorded video sequences of highly aerated flows are often subject to image noise, a new filtering technique is proposed. This indicator function relies on the image gradient magnitude and works directly on the image plane, including the following benefits: 

- Removal of erroneous data.
- Filtering of foreground movement.
- Filtering of air-water interfaces.

The uploaded source file allows computation of filtered air-water flow velocity fields with the Farnebäck method ([handle](https://www.ida.liu.se/ext/WITAS-ev/Computer_Vision_Technologies/PaperInfo/farneback02.html)), as implemented in Matlab R2017a. If using the uploaded files for publishing research, please cite the following reference to credit the authors and to direct readers to the original research work:

M. Kramer and H. Chanson (2018). Optical flow estimations in aerated spillway flows: Filtering and discussion on
sampling parameters, Experimental and Thermal Fluid Science ([DOI](https://doi.org/10.1016/j.expthermflusci.2018.12.002))


1 Contents
----------
The code is written in Matlab R2017a. This repository contains source code and a representative video file:
- RunIF.m: main code to run the optical flow technique with indicator function.
- Hydraulic jump data: short video sequence of the air-water flow in a hydraulic jump, recorded with a phantom v2011 high-speed video camera.


2 Sampling and processing parameters in air-water flows
-------------------------------------------------------
Important sampling and processing paramters for OF estimations (Farnebäck method) in high-velocity air-water flows were evaluated in Kramer and Chanson (2018, [DOI](https://doi.org/10.1016/j.expthermflusci.2018.12.002)). Main findings are summarised as follows:

- Neighbourhood size **N**: the pixel-wise solution is integrated over a specified neighbourhood size, assuming
that there is only little variation in the displacement field within the specified area. It was found that the results converged for neighbourhood sizes of N < 5 px.
- Filter size **F**:  after the computation of displacements, averaging is done using a Gaussian filter with specified size. Sensitivity analyses showed that optimum filter sizes are between 10 px < F < 15 px. 
- Image pyramid level: the algorithm allows computation of subsampled frames, were the resolution is decreasing with increasing pyramid level. The results were independent of the image pyramid level, which may not hold true for other applications with different sampling parameters (Bung and Valero 2017,
[handle](http://hdl.handle.net/2268/214198)).
- Sampling frequency: based on performed sensitivity analyses, a sampling rate of > 2,000 fps (or better 5,000 fps) is recommended, being in accordance with Zhang and Chanson (2017, [DOI](https://doi.org/10.1016/j.expthermflusci.2017.09.010)).
- Sampling duration: for **statistically steady** flows, a minimum sampling duration of > 10 s is appropriate, but higher durations are desirable in terms of more accurate and reproducible results. 
- Gradient threshold **g<sub>t</sub>**: the indicator function is a simple filter based on the image gradient magnitude and requires a normalised threshold value. A value of g<sub>t</sub> = 1.1 (normalised) was chosen to achieve a significantly improved description of the flow and to provide minimum loss of information. Note that the selected value is not unique and sensitivity analyses should be performed when applying this concept to other flow situations.

3 How to run the code?
----------------------
Copy the source code and the *.avi file into the same folder and run "RunIF.m".

4 Shortcomings and measurement accuracy
----------------------------------------
The majority of image-based velocity measurements in laboratory air-water flows were taken from a sidewall perspective, implying that flow information could only be estimated next to the inside wall (boundary layer). Further, there is no common accepted *post-hoc* methodology for uncertainty analyses of OF techniques in aerated flows. Comparison of phase-detection probe measurements with time-averaged OF velocities indicated accurate OF results for void fractions C < 0.5 (Zhang and Chanson 2017, [DOI](https://doi.org/10.1016/j.expthermflusci.2017.09.010); Kramer and Chanson 2018, [DOI](https://doi.org/10.1016/j.expthermflusci.2018.12.002)). 

The Farnebäck algorithm may be used to detect turbulent motion in air-water flows, as shown for synthetic images in Bung and Valero (2017, [handle](http://hdl.handle.net/2268/214198)). However, a thorough validation of turbulent fluctuations still needs to be established for real air-water flow sequences, especially as they are adversely affected by image noise. At the moment, little is known about the performance of OF techniques in unsteady air-water flows. 


5 Contact
----------
For **feedback**, **questions** and **recommendations**, please use the issue-section or the following Email:

- Matthias Kramer, The University of Queensland, Brisbane, Australia. Email: m.kramer@uq.edu.au, [ORCID](https://orcid.org/0000-0001-5673-2751)

