% MATLAB R2014b %

%clf;
close(findobj('type','figure','name','os4 animation'));

% Geometry define
%load('sim_result/os4_02_sim_NDI_MG180s.mat');

% Figure:
fig_os4 = figure('name','os4 animation','Position', [80, 60, 1120, 880]);

% FIRST % axes
ax_attitude = subplot(2,2,1);
%sz = get(ax_attitude,'OuterPosition');
%set(ax_longi,'YLim',[-200 200],'YDir','Reverse','YLimMode','manual','NextPlot','add','OuterPosition',[sz(1), 0.08, sz(3), 0.92]);
% set below with 2014b bug
%set(ax_attitude,'XLim',[-15 15],'YLim',[-15 15],'zLim',[-15 15],'xDir','reverse','zDir','reverse','OuterPosition',[0, 0.48, 0.5, 0.5]);
view(ax_attitude, [30,10]);
grid on ;
axis equal;
title(ax_attitude,'attitude');
xlabel(ax_attitude,'x'); ylabel(ax_attitude,'y'); zlabel(ax_attitude,'z');

% Create 3D Aircraft Object %
    % Fuselage a box
    X_fl = [OS4_physical.size.fuselage.x/2 , OS4_physical.size.fuselage.x/2 , -OS4_physical.size.fuselage.x/2 , -OS4_physical.size.fuselage.x/2  OS4_physical.size.fuselage.x/2];
    X_fl(2,:) = X_fl(1,:);
    Y_fl = [-OS4_physical.size.fuselage.y/2 , OS4_physical.size.fuselage.y/2 , OS4_physical.size.fuselage.y/2 , -OS4_physical.size.fuselage.y/2, -OS4_physical.size.fuselage.y/2];
    Y_fl(2,:) = Y_fl(1,:);
    Z_fl = [-OS4_physical.size.fuselage.z/2 , -OS4_physical.size.fuselage.z/2 , -OS4_physical.size.fuselage.z/2 , -OS4_physical.size.fuselage.z/2 , -OS4_physical.size.fuselage.z/2];
    Z_fl(2,:) = -Z_fl(1,:);
    fuselage = surface(X_fl, Y_fl, Z_fl, 'FaceColor',[0.8 0.8 0.8] );
    
    % motor arm
    %t = 0:pi/10:2*pi();
    [ Y_temp, Z_temp, X_temp ] = cylinder( OS4_physical.size.arm.diameter/2 );
    ma_theta = zeros(1,4);
    ma_length = zeros(1,4);
    X_ma = zeros([size(X_temp),4]);
    Y_ma = zeros([size(Y_temp),4]);
    Z_ma = zeros([size(Z_temp),4]);
    for i = 1:4
        ma_theta(i) = atan2( OS4_physical.rotor.pos(2,i) , OS4_physical.rotor.pos(1,i) );  % atan(y/x)
        ma_length(i) = sqrt( OS4_physical.rotor.pos(2,i)^2 + OS4_physical.rotor.pos(1,i)^2 );
        X_ma(1,:,i) = X_temp(1,:)*ma_length(i)*cos(ma_theta(i)) - Y_temp(1,:)*sin(ma_theta(i));
        X_ma(2,:,i) = X_temp(2,:)*ma_length(i)*cos(ma_theta(i)) - Y_temp(2,:)*sin(ma_theta(i));
        Y_ma(1,:,i) = Y_temp(1,:)*cos(ma_theta(i)) + X_temp(1,:)*ma_length(i)*sin(ma_theta(i));
        Y_ma(2,:,i) = Y_temp(2,:)*cos(ma_theta(i)) + X_temp(2,:)*ma_length(i)*sin(ma_theta(i));
        Z_ma(1,:,i) = Z_temp(1,:);
        Z_ma(2,:,i) = Z_temp(2,:);
        
    end
    ma = zeros(1,4);
    for i = 1:4
        ma(i) = surface(X_ma(:,:,i), Y_ma(:,:,i), Z_ma(:,:,i) + OS4_physical.rotor.pos(3,i)+OS4_physical.size.motor.height,'FaceColor','k' );
    end
    
    % Motor
    [ X_mt, Y_mt, Z_mt ] = cylinder( OS4_physical.size.motor.diameter/2 );
    motor = zeros(1,4);
    for i = 1:4
        motor(i) = surface( X_mt + OS4_physical.rotor.pos(1,i), Y_mt+OS4_physical.rotor.pos(2,i), -Z_mt*OS4_physical.size.motor.height + OS4_physical.rotor.pos(3,i) + OS4_physical.size.motor.height );
    end

    % Propeller Rotor
    t = 0:0.1:2*pi;
    X_prop = [OS4_physical.prop.rad * sin(t), 0];
    X_prop(2,:) = zeros(1,64);
    Y_prop = [OS4_physical.prop.rad * cos(t), OS4_physical.prop.rad];
    Y_prop(2,:) = zeros(1,64);
    Z_prop = zeros(2,64);
    propeller = zeros(1,4);
    i = 1;
    propeller(i) = surface( X_prop+OS4_physical.rotor.pos(1,i), Y_prop+OS4_physical.rotor.pos(2,i), Z_prop+OS4_physical.rotor.pos(3,i),'FaceColor','g','EdgeColor','none','LineStyle','none');
    i = 2;
    propeller(i) = surface( X_prop+OS4_physical.rotor.pos(1,i), Y_prop+OS4_physical.rotor.pos(2,i), Z_prop+OS4_physical.rotor.pos(3,i),'FaceColor','b','EdgeColor','none','LineStyle','none');
    i = 3;
    propeller(i) = surface( X_prop+OS4_physical.rotor.pos(1,i), Y_prop+OS4_physical.rotor.pos(2,i), Z_prop+OS4_physical.rotor.pos(3,i),'FaceColor','r','EdgeColor','none','LineStyle','none');
    i = 4;
    propeller(i) = surface( X_prop+OS4_physical.rotor.pos(1,i), Y_prop+OS4_physical.rotor.pos(2,i), Z_prop+OS4_physical.rotor.pos(3,i),'FaceColor',[1 0.5 0],'EdgeColor','none','LineStyle','none');

combinedobj1(1) = fuselage;
combinedobj1(2:5) = ma(1:4);
combinedobj1(6:9) = motor(1:4);
combinedobj1(10:13) = propeller(1:4);

clearvars i t X_fl Y_fl Z_fl X_ma Y_ma Z_ma X_mt Y_mt Z_mt X_prop Y_prop Z_prop X_temp Y_temp Z_temp
clearvars fuselage ma motor propeller
clearvars ma_length ma_theta


% Create 3D Wind direction Object %
    arrow = [0 0.03 0.06 0.03 0.03 0.03 0.03 0.03];
    [ Y_aero, Z_aero, X_aero ] = cylinder( arrow );
    air_dir = surface(X_aero*0.2 + 0.25, Y_aero, Z_aero, 'FaceColor',[1, 0.2, 0.3]);
combinedobj1(14) = air_dir;
clearvars arrow X_aero Y_aero Z_aero air_dir

set(ax_attitude,'XLim',[-0.4 0.4],'YLim',[-0.4 0.4],'zLim',[-0.3 0.3],'xDir','reverse','zDir','reverse','OuterPosition',[0, 0.48, 0.5, 0.5]);

% SECOND % axes
ax_longi = subplot(2,2,2);
title(ax_longi,'longitudinal view');
xlabel(ax_longi,'x');    ylabel(ax_longi,'z');
combinedobj2 = copyobj(combinedobj1(1:13),ax_longi);
rotate(combinedobj2,[1 0 0],-90);
ax_longi_xlim = [-1.5 1.5];
ax_longi_ylim = [-2 0.1];
set(ax_longi,'XLim',ax_longi_xlim,'YLim',ax_longi_ylim, 'YDir','Reverse','YLimMode','manual',...
                                                        'DataAspectRatioMode','manual','DataAspectRatio',[1 1 1],...
                                                        'NextPlot','add','OuterPosition',[0.5, 0.5, 0.51, 0.51]);
grid on;
TF2 = hgtransform('Parent',ax_longi);
set(combinedobj2,'Parent',TF2);             % attach a object to a transform parant

% THIRD axes
ax_3dplot = subplot(2,2,3);

title(ax_3dplot,'3d path view');
xlabel(ax_3dplot,'x');    ylabel(ax_3dplot,'y');    zlabel(ax_3dplot,'z');
combinedobj3 = copyobj(combinedobj1(1:13),ax_3dplot);
ax_3dplot_xlim = [-5 5];
ax_3dplot_ylim = [-5 5];
ax_3dplot_zlim = [-5 0.1];
set(ax_3dplot,'XLim',ax_3dplot_xlim,'YLim',ax_3dplot_ylim,'ZLim',ax_3dplot_zlim,'XDir','Reverse','ZDir','Reverse', ...
            'XLimMode','manual','YLimMode','manual','ZLimMode','manual','DataAspectRatio',[1 1 1], ...
            'NextPlot','add','OuterPosition',[0, 0, 0.52, 0.52]);
ax_3dplot_view = 30;
view(ax_3dplot, [ax_3dplot_view 10]);
grid on;
TF3 = hgtransform('Parent',ax_3dplot);
set(combinedobj3,'Parent',TF3)


% FOURTH % axes
ax_topdown = subplot(2,2,4);
title(ax_topdown,'topdown view');
xlabel(ax_topdown,'y');    ylabel(ax_topdown,'x');
combinedobj4 = copyobj(combinedobj1(1:13),ax_topdown);
rotate(combinedobj4,[1 1 0],180);
ax_topdown_xlim = [-1.5 1.5];
ax_topdown_ylim = [-1.5 1.5];
set(ax_topdown,'XLim',ax_topdown_xlim,  'XLimMode','manual','YLim',ax_topdown_ylim,'YLimMode','manual',...
                                        'DataAspectRatioMode','manual','DataAspectRatio',[1 1 1],...
                                        'NextPlot','add','OuterPosition',[0.5, 0, 0.51, 0.51]);
grid on;
TF4 = hgtransform('Parent',ax_topdown);
set(combinedobj4,'Parent',TF4)

%clearvars sz 

writerObj = VideoWriter('os4sim_animation');
writerObj.FrameRate = 10;
open(writerObj);
% SIMULATION %
time_step = 0.3;
j=1;
last_i = 1;
for i=2:size(os4sim_time.data)
    if floor(os4sim_time.data(i,1)/time_step) == floor(os4sim_time.data(i-1,1)/time_step)
        %jump
    else
        timemark = sprintf('Time:%f',os4sim_time.data(i,1));
        V_psi = os4sim_stateA.data(i,5);
        V_theta = os4sim_stateA.data(i,6);
        flight_info = sprintf('Speed:%f  £r azimuth :%f(deg)  £c elevation :%f(deg) \nQ:[ %f %f %f %f ]',...
                            os4sim_stateA.data(i,4), V_psi*180/pi, V_theta*180/pi, ...
                            os4sim_stateR.data(i,4), os4sim_stateR.data(i,5), os4sim_stateR.data(i,6), os4sim_stateR.data(i,7) );
                        
        txt_time = text(-8,26,timemark,'Parent',ax_attitude,'Units','characters','VerticalAlignment','top','HorizontalAlignment','left') ;
        txt_info = text(-8,25,flight_info,'Parent',ax_attitude,'Units','characters','VerticalAlignment','top','HorizontalAlignment','left') ;
                        
        % claculate body rotation
        theta_b = 2*acos( os4sim_stateR.data(i,4) );    %Q0
        if theta_b ~= 0
            rx = os4sim_stateR.data(i,5)/sin(theta_b/2);       %Q1
            ry = os4sim_stateR.data(i,6)/sin(theta_b/2);       %Q2
            rz = os4sim_stateR.data(i,7)/sin(theta_b/2);       %Q3
        else
            rx = 1;
            ry = 0;
            rz = 0;
        end
        
        % calculate velocity vector rotation

        q0 =  cos(V_theta/2)*cos(V_psi/2);         % cos(theta/2)
        q1 = -sin(V_theta/2)*sin(V_psi/2);        % x sin(theta/2)
        q2 =  sin(V_theta/2)*cos(V_psi/2);        % y sin(theta/2)
        q3 =  cos(V_theta/2)*sin(V_psi/2);        % z sin(theta/2)

        theta_v = 2*acos( q0 );    %Q0
        if theta_v ~= 0
            rx_v = q1/sin(theta_v/2);       %Q1
            ry_v = q2/sin(theta_v/2);       %Q2
            rz_v = q3/sin(theta_v/2);       %Q3
        else
            rx_v = 1;
            ry_v = 0;
            rz_v = 0;
        end
        
        % FIRST % axes
        rotate(combinedobj1(14),[rx_v ry_v rz_v],theta_v*180/pi);     % rotate velocity
        rotate(combinedobj1,[rx ry rz],theta_b*180/pi);                % rotate body and velocity
        
        % SECOND % axes
        plot(ax_longi,os4sim_stateX.data(last_i:i,4),os4sim_stateX.data(last_i:i,6));% hold on;grid on;
        if (os4sim_stateX.data(i,4) < ax_longi_xlim(1));    
            ax_longi_xlim(1) = ax_longi_xlim(1) - 2;
            set(ax_longi,'XLim',ax_longi_xlim);
        elseif (os4sim_stateX.data(i,4) > ax_longi_xlim(2));    
            ax_longi_xlim(2) = ax_longi_xlim(2) + 2;
            set(ax_longi,'XLim',ax_longi_xlim);
        end
        if (os4sim_stateX.data(i,6) < ax_longi_ylim(1));    
            ax_longi_ylim(1) = ax_longi_ylim(1) - 2;
            set(ax_longi,'YLim',ax_longi_ylim);
        elseif (os4sim_stateX.data(i,6) > ax_longi_ylim(2));    
            ax_longi_ylim(2) = ax_longi_ylim(2) + 2;
            set(ax_longi,'YLim',ax_longi_ylim);
        end
        
        
        TL_MAT2 = makehgtform('translate', [os4sim_stateX.data(i,4), os4sim_stateX.data(i,6), 0]);
        RT_MAT2 = makehgtform('axisrotate',[rx ,ry ,rz ],theta_b);
        set(TF2,'Matrix',TL_MAT2*RT_MAT2);
        
        % THIRD % axes
        plot3(ax_3dplot,os4sim_stateX.data(last_i:i,4),os4sim_stateX.data(last_i:i,5),os4sim_stateX.data(last_i:i,6));
        if (os4sim_stateX.data(i,4) < ax_3dplot_xlim(1))
            ax_3dplot_xlim(1) = ax_3dplot_xlim(1) - 2;
            set(ax_3dplot,'XLim',ax_3dplot_xlim);  
        elseif (os4sim_stateX.data(i,4) > ax_3dplot_xlim(2))
            ax_3dplot_xlim(2) = ax_3dplot_xlim(2) + 2;
            set(ax_3dplot,'XLim',ax_3dplot_xlim);  
        end
        if (os4sim_stateX.data(i,5) < ax_3dplot_ylim(1))
            ax_3dplot_ylim(1) = ax_3dplot_ylim(1) - 2;
            set(ax_3dplot,'YLim',ax_3dplot_ylim);  
        elseif (os4sim_stateX.data(i,5) > ax_3dplot_ylim(2))
            ax_3dplot_ylim(2) = ax_3dplot_ylim(2) + 2;
            set(ax_3dplot,'YLim',ax_3dplot_ylim);  
        end
        if (os4sim_stateX.data(i,6) < ax_3dplot_zlim(1))
            ax_3dplot_zlim(1) = ax_3dplot_zlim(1) - 2;
            set(ax_3dplot,'ZLim',ax_3dplot_zlim);  
        elseif (os4sim_stateX.data(i,6) > ax_3dplot_zlim(2))
            ax_3dplot_zlim(2) = ax_3dplot_zlim(2) + 2;
            set(ax_3dplot,'ZLim',ax_3dplot_zlim);  
        end
        TL_MAT3 = makehgtform('translate',[os4sim_stateX.data(i,4),os4sim_stateX.data(i,5),os4sim_stateX.data(i,6)]);
        RT_MAT3 = makehgtform('axisrotate',[rx ,ry ,rz ],theta_b);
        set(TF3,'Matrix',TL_MAT3*RT_MAT3);
        ax_3dplot_view = ax_3dplot_view + 2;    % rotate the view
        view(ax_3dplot, [ax_3dplot_view,10]);
        
        % FOURTH % axes
        plot(ax_topdown,os4sim_stateX.data(last_i:i,5),os4sim_stateX.data(last_i:i,4));
        if (os4sim_stateX.data(i,5) < ax_topdown_xlim(1));    
            ax_topdown_xlim(1) = ax_topdown_xlim(1) - 2;
            set(ax_topdown,'XLim',ax_topdown_xlim);
        elseif (os4sim_stateX.data(i,5) > ax_topdown_xlim(2));    
            ax_topdown_xlim(2) = ax_topdown_xlim(2) + 2;
            set(ax_topdown,'XLim',ax_topdown_xlim);
        end
        if (os4sim_stateX.data(i,4) < ax_topdown_ylim(1));    
            ax_topdown_ylim(1) = ax_topdown_ylim(1) - 2;
            set(ax_topdown,'YLim',ax_topdown_ylim);
        elseif (os4sim_stateX.data(i,4) > ax_topdown_ylim(2));    
            ax_topdown_ylim(2) = ax_topdown_ylim(2) + 2;
            set(ax_topdown,'YLim',ax_topdown_ylim);
        end
        TL_MAT4 = makehgtform('translate',[os4sim_stateX.data(i,5),os4sim_stateX.data(i,4), 0]);
        RT_MAT4 = makehgtform('axisrotate',[rx ,ry ,rz ],theta_b);
        set(TF4,'Matrix',TL_MAT4*RT_MAT4);
        
        drawnow;
        % frame_os4(j) = getframe(fig_os4); % if we want to capture everything
        frame = getframe(fig_os4);
        writeVideo(writerObj,frame);
        
        rotate(combinedobj1,[rx ry rz],-theta_b*180/pi);            % reset attitude
        rotate(combinedobj1(14),[rx_v ry_v rz_v],-theta_v*180/pi);  % reset velocity
        
        delete(txt_time);   % clear text
        delete(txt_info);
        
        j=j+1;
        last_i = i;     % last index for continuous plotting
    end
end

clearvars i j last_i 
clearvars q0 q1 q2 q3 rx ry rz rx_a ry_a rz_a theta theta_a
clearvars AOA SS flight_info timemark txt_time txt_info frame
clearvars ax_attitude combineobj ax_longi ax_longi_ylim ax_3dplot ax_3dplot_xlim ax_3dplot_ylim ax_3dplot_zlim ax_3dplot_view ax_topdown ax_topdown_xlim

% figure('name','Movie')
% movie(F,1,100)

close(writerObj);