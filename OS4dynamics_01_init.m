function OS4dynamics_01_init()
[ initX, initR] = OS4dynamics_init_state();
OS4physical = OS4physical_init();
initC = OS4actuator_init(OS4physical);

assignin('base', 'OS4_initX', initX);
assignin('base', 'OS4_initR', initR);
assignin('base', 'OS4_physical', OS4physical);
assignin('base', 'OS4_initC', initC);

end

function [ linear, angular] = OS4dynamics_init_state()

speed = [0.1 0 0];
position =[0.1 0.1 -4];

linear.pos = position;
linear.vel = speed;
linear.vinf = sqrt(speed(1)^2+speed(2)^2+speed(3)^2);
%initX=[1 ;0; -0.1; 0; 0; 0];        % tail sit
%initX=[2 ;0; 0.5; 0; 0; 0];         % straight & level launch

roll_rate = 0;      % p
pitch_rate = 0;     % q
yaw_rate = 0;       % r

t3 = 0;         % yaw
t2 = -30*pi/180;         % pitch
t1 = 0;         % row

q0 = sin(t1/2)*sin(t2/2)*sin(t3/2) + cos(t1/2)*cos(t2/2)*cos(t3/2);         % cos(theta/2)
q1 = -cos(t1/2)*sin(t2/2)*sin(t3/2) + sin(t1/2)*cos(t2/2)*cos(t3/2);         % x sin(theta/2)
q2 = sin(t1/2)*cos(t2/2)*sin(t3/2) + cos(t1/2)*sin(t2/2)*cos(t3/2);        % y sin(theta/2)
q3 = -sin(t1/2)*sin(t2/2)*cos(t3/2) + cos(t1/2)*cos(t2/2)*sin(t3/2);        % z sin(theta/2)

% pqr %cos 2/theta ;x sin 2/theta;y sin 2/theta; z sin 2/theta
%angular=[0; 0; 0; cos(40*pi/180); 0; sin(40*pi/180); 0];          % tail sit 
%initR=[0; 0; 0; cos(5*pi/180); 0; sin(5*pi/180); 0];          % 10 degree

angular.w = [roll_rate , pitch_rate , yaw_rate];
angular.q = [q0 , q1 , q2 , q3];

%clearvars speed alpha beta position
%clearvars roll_rate pitch_rate yaw_rate 
%clearvars rho theta phi 

end

function physical = OS4physical_init()
% 2007 design and control of quadrotors with application to autonomous
% flying        p.144
physical.inertia.mass = 0.65;
physical.inertia.Ixx = 7.5e-3;
physical.inertia.Iyy = 7.5e-3;
physical.inertia.Izz = 1.3e-2;
physical.inertia.Ixy = 0;
physical.inertia.Ixz = 0;
physical.inertia.Iyz = 0;
physical.inertia.Ip = 6e-5;

physical.prop.chord = 0.04;
physical.prop.rad = 0.075;
%physical.prop.theta0 = 0.26;       % pitch of incidence 14.9 deg
%physical.prop.thetatw = 0.045;     % twist pitch 2.57 deg
%physical.prop.thetatip = 4.4*pi/180;
physical.prop.thetatip = 12*pi/180;
physical.prop.sigma = 0.054;       % Rotor Disk solidity = Ablade/Adisk
physical.prop.a0 = 5.5;            % Lift slope

physical.size.fuselage.x = 0.08;
physical.size.fuselage.y = 0.08;
physical.size.fuselage.z = 0.07;
physical.size.fuselage.area = physical.size.fuselage.x * physical.size.fuselage.y;

al = 0.23;
physical.size.arm.length = al;     % arm length 
physical.size.arm.diameter = 0.01;
physical.size.motor.diameter = 0.02;
physical.size.motor.height = 0.015;

physical.rotor.pos(1:3,1) = [al/sqrt(2) ; al/sqrt(2); -0.05];    % forward-right
physical.rotor.pos(1:3,2) = [-al/sqrt(2);-al/sqrt(2); -0.05];  % backward-left
physical.rotor.pos(1:3,3) = [al/sqrt(2) ;-al/sqrt(2); -0.05];  % forward-left
physical.rotor.pos(1:3,4) = [-al/sqrt(2); al/sqrt(2); -0.05];  % backward-right
physical.rotor.dir = [-1, -1, 1, 1];    % -z dir (up) +z dir (down)

physical.downwash.tau = 0.01;
end

function controller = OS4actuator_init(OS4physical)
    controller.rotor.omega = [2100 2100 2100 2100];
    
    V_ind = 6;      % induced velocity
    controller.propeller.lambda_0 = V_ind ./ (controller.rotor.omega .* OS4physical.prop.rad);
    
end
