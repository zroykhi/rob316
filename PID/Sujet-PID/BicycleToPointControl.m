function [ u ] = BicycleToPointControl( xTrue,xGoal )
%Computes a control to reach a pose for bicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   xGoal is the goal point
%   u is the control : [v phi]'


% TODO
%Q2
% Kp = 15;
% Ka = 15;
% Kb = 5;
% aMax = pi*240/180;
% dist = sqrt((xTrue(1) - xGoal(1))^2 + (xTrue(2) - xGoal(2))^2);
% diffAng = atan2(xGoal(2)-xTrue(2), xGoal(1)-xTrue(1)) - xTrue(3);
% diffAng = AngleWrap(diffAng);
% v = Kp*dist;
% if dist < 0.005
%     beta = diffAng;
%     omega = beta * Kb;
% else
%     omega = Ka * diffAng;
% end    
% u = [v; omega];

%Q3
% Kp = 15;
% Ka = 15;
% Kb = 5;
% aMax = pi*240/180;
% dist = sqrt((xTrue(1) - xGoal(1))^2 + (xTrue(2) - xGoal(2))^2);
% apha = atan2(xGoal(2)-xTrue(2), xGoal(1)-xTrue(1)) - xTrue(3);
% beta = xGoal(3) - atan2(xGoal(2)-xTrue(2), xGoal(1)-xTrue(1));
% apha = AngleWrap(apha);
% beta = AngleWrap(beta);
% v = Kp*dist;
% omega = Ka*apha + Kb*beta;   
% u = [v; omega];



end

