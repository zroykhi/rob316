function [ u ] = BicycleToPoseControl( xTrue,xGoal )
%Computes a control to reach a pose for bicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   xGoal is the goal point
%   u is the control : [v phi]'

% TODO 
%Q3
Kp = 15;
Ka = 15;
Kb = 5;
dist = sqrt((xTrue(1) - xGoal(1))^2 + (xTrue(2) - xGoal(2))^2);
apha = atan2(xGoal(2)-xTrue(2), xGoal(1)-xTrue(1)) - xTrue(3);
beta = xGoal(3) - atan2(xGoal(2)-xTrue(2), xGoal(1)-xTrue(1));
apha = AngleWrap(apha);
beta = AngleWrap(beta);
if dist < 0.1
    Kp = 5;
    Ka = 15;
    Kb = 20;    
else
    Kp = 10;
    Ka = 15;
    Kb = 5;
end  
v = Kp*dist;
phi = Ka*apha + Kb*beta; 


  
u = [v; phi];

end

