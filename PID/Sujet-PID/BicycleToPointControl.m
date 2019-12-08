function [ u ] = BicycleToPointControl( xTrue,xGoal )
%Computes a control to reach a pose for bicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   xGoal is the goal point
%   u is the control : [v phi]'


% TODO
%Q2 mean time: 1374
Kp = 25;
Ka = 15;
dist = sqrt((xTrue(1) - xGoal(1))^2 + (xTrue(2) - xGoal(2))^2);
diffAng = atan2(xGoal(2)-xTrue(2), xGoal(1)-xTrue(1)) - xTrue(3);
diffAng = AngleWrap(diffAng);
v = Kp*dist;  
omega = Ka * diffAng;
u = [v; omega];

end

