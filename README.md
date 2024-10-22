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
- Gradient threshold **g<sub>t</sub>**: the indicator function is a simple filter based on the image gradient magnitude and requires a threshold value. Sensitivity analyses should be performed when applying this concept to other flow situations.

3 How to run the code?
----------------------
Copy the source code and the *.avi file into the same folder and run "RunIF.m".

4 Shortcomings and measurement accuracy
----------------------------------------
The majority of image-based velocity measurements in laboratory air-water flows were taken from a sidewall perspective, implying that flow information could only be estimated next to the inside wall (boundary layer). Further, there is no common accepted *post-hoc* methodology for uncertainty analyses of OF techniques in aerated flows. Comparisons of phase-detection probe measurements with time-averaged OF velocities indicate accurate OF results for void fractions C < 0.5 (Zhang and Chanson 2017, [DOI](https://doi.org/10.1016/j.expthermflusci.2017.09.010); Kramer and Chanson 2018, [DOI](https://doi.org/10.1016/j.expthermflusci.2018.12.002)). 

The Farnebäck algorithm may be used to detect turbulent motion in air-water flows, as shown for synthetic images in Bung and Valero (2017, [handle](http://hdl.handle.net/2268/214198)). However, a thorough validation of turbulent fluctuations still needs to be established for real air-water flows, especially as recorded sequences are adversely affected by image noise and background motion. At the moment, little is known about the performance of OF techniques in unsteady air-water flows. 


5 Contact
----------
For **feedback**, **questions** and **recommendations**, please use the issue-section or the following Email:

- Matthias Kramer, The University of Queensland, Brisbane, Australia. Email: m.kramer@uq.edu.au, [ORCID](https://orcid.org/0000-0001-5673-2751)


6 Selected References
------------
- Ryu, Y., Chang, K. A., and Lim, H. J. (2005). Use of bubble image velocimetry
for measurement of plunging wave impinging on structure and associated greenwater. Measurement Science and Technology 16, pages 1945-1953.
- Bung, D. B. (2011). Non-intrusive measuring of air-water flow properties in selfaerated
stepped spillway flow. In: Proceedings of the 34th IAHR World Congress, Brisbane, Australia, pages 2380-2387.
- Leandro, J., Bung, D. B., and Carvalho, R. (2014). Measuring void fraction and velocity fields of a stepped spillway for skimming 
flow using non-intrusive methods. Experiments in Fluids 55.
- Bung, D. and Valero, D. (2016). Image processing techniques for velocity estimation
in highly aerated flows: bubble image velocimetry vs. optical flow. In: Proceedings of the 4th IAHR Europe Congress, Liege, Belgium, pages 151-157.
- Bung, D. B. and Valero, D. (2016). Optical flow estimation in aerated flows. Journal of Hydraulic Research 54, pages 575-580.
- Bung, D. B. and Valero, D. (2017). FlowCV - an open source toolbox for computer vision applications in turbulent flows. In: E-Proceedings of the 37th IAHR World Congress, Kuala Lumpur, Malaysia, 10 pages.
- Zhang, G. and Chanson, H. (2018). Application of local optical flow methods to high-velocity free-surface flows: Validation and application to stepped chutes, Experimental and Thermal Fluid Science 90, pages 186-199.
- Kramer, M. and Chanson, H. (2018). Free-surface instabilities in high-velocity air-water flows down stepped chutes. In: 7th International Symposium on Hydraulic Structures (ISHS), Aachen, Germany, 11 pages.
- Kramer, M. and Chanson H. (2018). Optical flow estimations in aerated spillway flows: Filtering and discussion on
sampling parameters, Experimental and Thermal Fluid Science.

