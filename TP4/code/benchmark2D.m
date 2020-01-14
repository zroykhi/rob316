% benchmark script for 2D mobile robot

function benchmark2D(map,start_pt,goal_pt,algo,variant,max_iter)

MAP = struct('name', map, 'start_point', start_pt, 'goal_point', goal_pt);

nb_test=10;
fail=0;
mean_length=0;
mean_goal_reach=0;


for i=1:nb_test
    if strcmp(algo,'rrt')
         disp('Testing RRT');
        res=rrt(MAP, max_iter,1,cputime*1000,variant);
    elseif strcmp(algo,'rrt_star')
         disp('Testing RRT*');
        res=rrt_star(MAP, max_iter,1,cputime*1000,variant);
    else
        disp('Testing RRT*FN');
        res=rrt_star_fn(MAP, max_iter,3000,1,cputime*1000,variant);
    end
    
    length=res.getPathLength();
    if length == 1e6
        fail=fail+1;
    else
        mean_length=mean_length+length;
        mean_goal_reach=mean_goal_reach+res.ind_reach_goal;
    end
end

if fail<nb_test
    mean_length=mean_length/(nb_test-fail);
    mean_goal_reach=mean_goal_reach/(nb_test-fail);
else
    mean_length=1e6;
    mean_goal_reach=0;
end

disp(['Failures : ', num2str(fail), ' mean_length : ', num2str(mean_length), ' mean iter to reach goal : ',num2str(mean_goal_reach) ]);

end