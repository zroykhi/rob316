function [ u ] = UnicycleToPoseControl( xTrue,xGoal )
%Computes a control to reach a pose for unicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   xGoal is the goal point
%   u is the control : [v omega]'

% TODO
Kp = 20;
Ka = 20;
Kb = 20;
aMax = pi*120/180;
dist = sqrt((xTrue(1) - xGoal(1))^2 + (xTrue(2) - xGoal(2))^2);
diffAng = atan2(xGoal(2)-xTrue(2), xGoal(1)-xTrue(1)) - xTrue(3);
diffAng = AngleWrap(diffAng);
if diffAng > aMax
    v = 0;
else
    v = Kp*dist;
end
if dist < 0.005
    beta = diffAng;
    omega = beta * Kb;
else
    omega = Ka * diffAng;
end    
u = [v; omega];
end

