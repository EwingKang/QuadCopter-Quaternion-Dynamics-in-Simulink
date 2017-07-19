# QuadCopter-Quaternion-Dynamics-in-Simulink
Full quadcopter dynamics simulation using quaternion with propeller aerodynamics.

# Introduction
This is a pure-simulink quadrotor dynamics simulation without the requirement of any toolbox. The core kinematic is written using "Qauternion". And the propeller aerodynamics/ rotational dynamics is carefully modeled.   
Quaternion is a famous method of representing attitude in space that preserve the intuativness and "complete" i.e. no pole. The quadrotor dynamics is dominate by simple rigid body dynamics, thus becoming a popular solution for autonomous vehicle.  
I'm trying to model the dynamics as best as I can get it. Because I'm studying in AeroAstro department, I put more effort on the simulation of aerodynamics/rotational dynamics of the propeller. This includes the washing disk delay/damping of the air, interaction of propeller subject to different airflow, and ground effect.   
It is not my own work of proposing these aerodynamic model and definately not the quaternion part, you may find my reference in the following section. The name of this simulink "OS4" is actually the name a quadrotor model created by Samir BOUABDALLAH in EPFL (ÉCOLE POLYTECHNIQUE FÉDÉRALE DE LAUSANNE). The thesis is my main reference for creating this simulation and is stated in the reference.

# Requirement
* MATLAB 2014b
* Simulink
* no toolbox is needed

# Usage  
When the simulation started, it triggers the <OS4dynamics_01_init.m> and create multiple data in the workspace of MATLAB. This includes the initial condition of the system and all the physical parameters. That is to say, if you want to change anything about the dynamics, the only file you'll need to modify is <OS4dynamics_01_init.m>  

Likewise, all the result of the simulation is export to the workspace for further analysis, plotting, animating, and so on.   
  
There are two files you may run to generate visual data: 
* OS4dynamics_plot_01.m  
* OS4dynamics_animation_01.m  
The animation script will generate a .avi video file in the current folder. Please rename it to keep the next generation from overwrite it.  
NOTE: some of the data might be missing and require manual marked-out on the code. This is because some of the data might require the input of controller, which will be release in another project. Contact me if you have any problem running these program.  
  

# Reference

### for Quaternion
* Adrian Frank, James McGrew, Mario Valenti, Daniel Levine, Jonathan P. How, "Hover, Transition, and Level Flight Control Designfor a Single-Propeller Indoor Airplane", 2007, Tech. Rpt. ACL in Dept. of AA, MIT   
* Frantisek Michal Sobolic, "Agile Flight Control Techniques for a Fixed-WingAircraft", 2009, MS Thesis, MIT   
* Nikolas Trawny and Stergios I. Roumeliotis, "Indirect Kalman Filter for 3D Attitude Estimation: A Tutorial for Quaternion Algebra", 2005, Dpt. of Cmpr. Sci. & Egnrg., U. of Minnesota   
* D. M. Henderson, "Euler Angles, Quaternions, and Transfrmation Matrices", 1977, NASA-TM-74839, Johnson Space Ctr.   


### for quadrotor dynamics  
* Samir BOUABDALLAH, "design and control of quadrotorswith application to autonomous flying", 2007, PhD. Thesis NO 3727, ÉCOLE POLYTECHNIQUE FÉDÉRALE DE LAUSANNE     
* Paul Edward Ian Pounds, "Design, Construction and Control of aLarge Quadrotor Micro Air Vehicle", 2007, PhD. Thesis, Australian National University   
 
### for aerodynamics
* Pedro Val´erio Menino Simpl´ıcio, "Helicopter Nonlinear Flight Controlusing Incremental Nonlinear Dynamic Inversion" 2011, PhD Thesis, Instituto SuperiorT´ecnico   

### for quadrotor control  
* Taeyoung Lee, Melvin Leok, and N. Harris McClamroch, "Geometric Tracking Control of a Quadrotor UAV on SE(3)"   
* Taeyoung Lee, Melvin Leok, and N. Harris McClamroch, "Geometric Tracking Control of a QuadrotorUAV for Extreme Maneuverability", 2011,  18th IFAC World Congress Milano (Italy)   
  
# Disclaimer

# Authorization
```
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Copyright (c) 2016, Ewing Kang                                                 %   
%                                                                                %  
% Permission is hereby granted, free of charge, to any person obtaining a copy   %  
% of this software and associated documentation files (the "Software"), to deal  %  
% in the Software without restriction, including without limitation the rights   %  
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      %  
% copies of the Software, and to permit persons to whom the Software is          %    
% furnished to do so, subject to the following conditions:                       %  
%                                                                                %  
% The above copyright notice and this permission notice shall be included in     %  
% all copies or substantial portions of the Software.                            %  
%                                                                                %  
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     %  
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       %  
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    %  
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         %  
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  %  
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN      %  
% THE SOFTWARE.                                                                  %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
```
