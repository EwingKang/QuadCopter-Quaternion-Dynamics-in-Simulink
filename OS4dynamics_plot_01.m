%% plot all data
%function quaternionACdynamics_plot()
%close all;
close(findobj('type','figure','name','os4 animation'));
close(findobj('type','figure','name','rotation pqr'));
close(findobj('type','figure','name','absolute speed VxeVyeVze'));
close(findobj('type','figure','name','position XYZ'));
close(findobj('type','figure','name','Aerodynamics related'));
close(findobj('type','figure','name','Body Velocity'));
close(findobj('type','figure','name','Heading Vector'));
close(findobj('type','figure','name','Path top-down'));
close(findobj('type','figure','name','Path longitudinal'));
close(findobj('type','figure','name','Path lateral'));
close(findobj('type','figure','name','3D Path'));
close(findobj('type','figure','name','Motor Commands'));
close(findobj('type','figure','name','Actuater Sensor'));
close(findobj('type','Heading and Desire'));
close(findobj('type','Right wing Direction'));

figure('name','rotation pqr')
plot(os4sim_time.data,os4sim_stateR.data(:,1),'r'); hold on
plot(os4sim_time.data,os4sim_stateR.data(:,2),'g'); hold on
plot(os4sim_time.data,os4sim_stateR.data(:,3),'b');
legend('p','q','r');
%{
figure('name','quaternion')
plot(os4sim_time.data,os4sim_stateR.data(:,4),'r'); hold on
plot(os4sim_time.data,os4sim_stateR.data(:,5),'g'); hold on
plot(os4sim_time.data,os4sim_stateR.data(:,6),'b'); hold on
plot(os4sim_time.data,os4sim_stateR.data(:,7),'cyan');
legend('cos(theta/2)','ax*sin(theta/2)','ay*sin(theta/2)','az*sin(theta/2)');
%}
figure('name','absolute speed VxeVyeVze')
plot(os4sim_time.data,os4sim_stateX.data(:,1),'r'); hold on
plot(os4sim_time.data,os4sim_stateX.data(:,2),'g'); hold on
plot(os4sim_time.data,os4sim_stateX.data(:,3),'b');
legend('Vxe','Vye','Vze');

figure('name','position XYZ')
plot(os4sim_time.data,os4sim_stateX.data(:,4),'r'); hold on
plot(os4sim_time.data,os4sim_stateX.data(:,5),'g'); hold on
plot(os4sim_time.data,os4sim_stateX.data(:,6),'b');
legend('X','Y','Z');

figure('name','Aerodynamics related')
plot(os4sim_time.data,os4sim_stateA.data(:,4),'r'); hold on
plot(os4sim_time.data,os4sim_stateA.data(:,5)*180/pi,'g'); hold on
plot(os4sim_time.data,os4sim_stateA.data(:,6)*180/pi,'b');
legend('Vinf','£r azimuth (deg)','£c elevation (deg)');

figure('name','Body Velocity')
plot(os4sim_time.data,os4sim_stateB.data(:,1),'r'); hold on
plot(os4sim_time.data,os4sim_stateB.data(:,2),'g'); hold on
plot(os4sim_time.data,os4sim_stateB.data(:,3),'b');
legend('Vxb','Vyb','Vzb');

figure('name','Heading Vector')
plot(os4sim_time.data,os4sim_stateHeading.data(:,1),'r'); hold on
plot(os4sim_time.data,os4sim_stateHeading.data(:,2),'g'); hold on
plot(os4sim_time.data,os4sim_stateHeading.data(:,3),'b');
legend('x','y','z');

figure('name','Path top-down')
plot(os4sim_stateX.data(:,5),os4sim_stateX.data(:,4));
xlabel('y');    ylabel('x');

figure('name','Path longitudinal')
plot(os4sim_stateX.data(:,4),os4sim_stateX.data(:,6));
xlabel('x');    ylabel('z');
set(gca,'YDir','Reverse');      axis equal;

figure('name','Path lateral')
plot(os4sim_stateX.data(:,5),os4sim_stateX.data(:,6));
xlabel('y');    ylabel('z');
set(gca,'YDir','Reverse');

figure('name','3D Path')
plot3(os4sim_stateX.data(:,4),os4sim_stateX.data(:,5),os4sim_stateX.data(:,6));
xlabel('x');    ylabel('y');    zlabel('z');    grid on;    axis equal;
set(gca,'YDir','Reverse','ZDir','Reverse');
%set(gca,'YDir','Reverse','ZDir','Reverse','XLim',[-2 2],'YLim',[-2 2]);

figure('name','Motor Commands')
plot(os4sim_time.data,os4sim_control.data(:,1)*100,'g'); hold on
plot(os4sim_time.data,os4sim_control.data(:,2)*100,'b'); hold on
plot(os4sim_time.data,os4sim_control.data(:,3)*100,'r'); hold on
plot(os4sim_time.data,os4sim_control.data(:,4)*100,'color',[1 0.5 0]); hold on  % TVC y
plot(os4sim_time.data,os4sim_control.data(:,5),'--g'); hold on  % TVC y
plot(os4sim_time.data,os4sim_control.data(:,6),'--b'); hold on  % TVC y
plot(os4sim_time.data,os4sim_control.data(:,7),'--r'); hold on  % TVC y
plot(os4sim_time.data,os4sim_control.data(:,8),'color',[1 0.5 0],'LineStyle','--'); hold on  % TVC y
plot(os4sim_time.data,os4sim_control.data(:,9)/100,':g'); hold on  % TVC y
plot(os4sim_time.data,os4sim_control.data(:,10)/100,':b'); hold on  % TVC y
plot(os4sim_time.data,os4sim_control.data(:,11)/100,':r'); hold on  % TVC y
plot(os4sim_time.data,os4sim_control.data(:,12)/100,'color',[1 0.5 0],'LineStyle',':'); hold on  % TVC y
legend('£n_1 (0.01N*m)','£n_2','£n_3','£n_4','T_1 (N)','T_2','T_3','T_4','£s_1 (100rad/s)','£s_2','£s_3','£s_4');
%{
figure('name','Actuater Sensor')
plot(os4sim_time.data,os4sim_control.data(:,8),'r'); hold on
plot(os4sim_time.data,os4sim_control.data(:,10),'b'); hold on
plot(os4sim_time.data,os4sim_control.data(:,9),'g'); hold on
plot(os4sim_time.data,os4sim_control.data(:,14),'color',[0.2 0.8 0.2]); hold on  % TVC y
plot(os4sim_time.data,os4sim_control.data(:,12),'k');
plot(os4sim_time.data,os4sim_stateR.data(:,1)*180/pi,'color',[0.7 0 0]); hold on
plot(os4sim_time.data,os4sim_stateR.data(:,2)*180/pi,'color',[0 0 0.5]); hold on
plot(os4sim_time.data,os4sim_stateR.data(:,3)*180/pi,'color',[0 0.7 0]);
legend('ailron (deg)','canard','rudder','TVC y','throttle (kN)','p (deg/s)','q','r');
%}
%{
figure('name','Heading and Desire')
plot(os4sim_time.data,os4sim_stateHeading.data(:,1),'r'); hold on
plot(os4sim_time.data,os4sim_stateHeading.data(:,2),'g'); hold on
plot(os4sim_time.data,os4sim_stateHeading.data(:,3),'b'); hold on 
%plot(os4sim_controltime.data,os4sim_stateDesireHeading.data(:,1),'color',[0.7 0 0]); hold on
%plot(os4sim_controltime.data,os4sim_stateDesireHeading.data(:,2),'color',[0 0.7 0]); hold on
%plot(os4sim_controltime.data,os4sim_stateDesireHeading.data(:,3),'color',[0 0 0.7]);
legend('x','y','z','xd','yd','zd');


figure('name','Right wing Direction')
plot(os4sim_time.data,os4sim_stateHeading.data(:,4),'r'); hold on
plot(os4sim_time.data,os4sim_stateHeading.data(:,5),'g'); hold on
plot(os4sim_time.data,os4sim_stateHeading.data(:,6),'b'); hold on 
%plot(os4sim_controltime.data,os4sim_stateDesireHeading.data(:,4),'color',[0.7 0 0]); hold on
%plot(os4sim_controltime.data,os4sim_stateDesireHeading.data(:,5),'color',[0 0.7 0]); hold on
%plot(os4sim_controltime.data,os4sim_stateDesireHeading.data(:,6),'color',[0 0 0.7]);
legend('x','y','z','xd','yd','zd');
%}