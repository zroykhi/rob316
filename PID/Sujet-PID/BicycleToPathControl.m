function [ u ] = BicycleToPathControl( xTrue, Path )
%Computes a control to follow a path for bicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   Path is set of points defining the path : [ x1 x2 ... ;
%                                               y1 y2 ...]
%   u is the control : [v phi]'

% TODO
%Q4
Kp = 5;
Ka = 15;
num_lines = length(Path) - 1;
num_points = length(Path);
step = 1;
dist_thredhold = 0.5;
turning_r = 0.3

current_phrase = 1; 

closest_point_idx =1;
min_dist_robot_2_vertice = 100;
for i=1:num_points
    d = norm(Path(1:2,i) - xTrue(1:2,1));
    if d < min_dist_robot_2_vertice
        min_dist_robot_2_vertice = d;
        closest_point_idx = i;
    end
end

if closest_point_idx == 3
    turning_r = 0.8;
    Ka = 25;
elseif closest_point_idx == 4
    Ka = 20;
    turning_r = 0.4
elseif closest_point_idx == 5
    Ka = 22;
    turning_r = 0.7    
end    

if closest_point_idx == 1
    current_phrase = 1;
elseif closest_point_idx == 6
    current_phrase = 5;
elseif closest_point_idx == 4
    if min_dist_robot_2_vertice < turning_r
        current_phrase = closest_point_idx;
    else
        error=abs(p_poly_dist(xTrue(1),xTrue(2),Path(1,:),Path(2,:)));
        for i=2:4
            % s = (x1y2-x1y3+x2y3-x2y1+x3y1-x3y2)
            s = Path(1,i)*Path(2,i+1) - Path(1,i)*xTrue(2) + Path(1,i+1)*xTrue(2) - Path(1,i+1)*Path(2,i)+xTrue(1)*Path(2,i)-xTrue(1)*Path(2,i+1);
            vector = Path(1:2,i+1) - Path(1:2,i);
            d = abs(s) / sqrt(vector' * vector);
            if abs(d - error) < 0.0001
                current_phrase = i;
            end
        end
    end
else
    if min_dist_robot_2_vertice < turning_r
        current_phrase = closest_point_idx;
    else
        diff_err = 100;
        error=abs(p_poly_dist(xTrue(1),xTrue(2),Path(1,:),Path(2,:)));
        for i=1:5
            % s = (x1y2-x1y3+x2y3-x2y1+x3y1-x3y2)
            s = Path(1,i)*Path(2,i+1) - Path(1,i)*xTrue(2) + Path(1,i+1)*xTrue(2) - Path(1,i+1)*Path(2,i)+xTrue(1)*Path(2,i)-xTrue(1)*Path(2,i+1);
            vector = Path(1:2,i+1) - Path(1:2,i);
            i
            error
            d = abs(s) / sqrt(vector' * vector)
            if abs(d - error) < diff_err
                diff_err = abs(d - error);
                current_phrase = i
            end
        end        
    end
end

error=p_poly_dist(xTrue(1),xTrue(2),Path(1,:),Path(2,:));

start_point = Path(1:2,current_phrase);
end_point = Path(1:2,current_phrase+1);
vector = end_point - start_point;
unitVector = vector' / sqrt(vector' * vector);

xGoal = start_point;
dist_robot_to_goal = sqrt((xTrue(1:2,1) - xGoal)'*(xTrue(1:2,1) - xGoal));
dist_robot_to_end = sqrt((xTrue(1:2,1) - end_point)'*(xTrue(1:2,1) - end_point));
dist_goal_to_end = sqrt((xGoal - end_point)'*(xGoal - end_point));

% while dist_robot_to_goal < dist_thredhold    
while dist_goal_to_end>dist_robot_to_end | dist_robot_to_goal < dist_thredhold    
    xGoal = xGoal + step * unitVector';
    unitVector;
    dist_robot_to_goal = sqrt((xTrue(1:2,1) - xGoal)'*(xTrue(1:2,1) - xGoal));
    dist_robot_to_end = sqrt((xTrue(1:2,1) - end_point)'*(xTrue(1:2,1) - end_point));
    dist_goal_to_end = sqrt((xGoal - end_point)'*(xGoal - end_point));
    if dist_goal_to_end > 100
        break
    end
end
apha = atan2(xGoal(2)-xTrue(2), xGoal(1)-xTrue(1)) - xTrue(3);
apha = AngleWrap(apha);
v = Kp*dist_robot_to_goal;
phi = Ka*apha;
current_phrase;
u = [v phi];

if min_dist_robot_2_vertice < 0.05 && closest_point_idx == 6
    u = [0 0];
end    

end

