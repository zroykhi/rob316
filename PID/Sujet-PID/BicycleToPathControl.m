function [ u ] = BicycleToPathControl( xTrue, Path )
%Computes a control to follow a path for bicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   Path is set of points defining the path : [ x1 x2 ... ;
%                                               y1 y2 ...]
%   u is the control : [v phi]'

% TODO
%Q4
Kp = 15;
Ka = 15;
dist = sqrt((xTrue(1) - (1))^2 + (xTrue(2) - (2))^2);
apha = atan2(xGoal(2)-xTrue(2), xGoal(1)-xTrue(1)) - xTrue(3);
apha = AngleWrap(apha);
v = Kp*dist;
omega = Ka*apha;   
u = [v; omega];

end

