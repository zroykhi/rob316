function problem = rrt_star_fn(map, max_iter, max_nodes, is_benchmark, rand_seed, variant)
%RRT_STAR_FN -- RRT*FN is sampling-based algorithm. It is a new variant 
% of RRT* algorithm,  which limits the number of nodes in the tree 
% and hence decreases the memory needed for storing the tree. 
% 
% problem = RRT_STAR_FN(map, max_iter, max_nodes, is_benchmark, rand_seed, variant)
% function returns the object of the respective class with the result
%
% map           -- struct with appropriate fields (developer of 
%               the class provides more information on this topic)
% max_iter      -- number of iteration to solve the problem
% max_node      -- number of nodes in the tree
% is_benchmark  -- if true saves snapshots of the tree in a special directory
%               boolean variable
% rand_seed     -- a random seed 
% variant       -- what class to choose, class used defines the problem space
%
%
% for detailed information consult with the help of the _RRT*FN Toolbox_
%
% Olzhas Adiyatov
% 05/26/2013

%%% Configuration block
if nargin < 6
    clear all;
    close all;
    clc;
    
    % load conf
    RAND_SEED   = 1;
    MAX_ITER    = 30e3;
    MAX_NODES   = 4001;
     is_benchmark=0;
    % here you can specify what class to use, each class represent
    % different model.
    % FNSimple2D provides RRT and RRT* for 2D mobile robot represented as a dot 
    % FNRedundantManipulator represents redundant robotic manipulator, DOF is
    % defined in configuration files.

        variant     = 'FNSimple2D';
        MAP = struct('name', 'bench_june1.mat', 'start_point', [-12.5 -5.5], 'goal_point', [7 -3.65]);
%     variant     = 'FNRedundantManipulator';
%     MAP = struct('name', 'bench_redundant_3.mat', 'start_point', [0 0], 'goal_point', [35 35]);
%     variant     = 'GridBased2Dimrotate';
%     MAP = struct('name', 'grid_map.mat', 'start_point', [150 150], 'goal_point', [250 50]);
    %[180 284]

else
    MAX_NODES   = max_nodes;
    MAX_ITER    = max_iter;
    RAND_SEED   = rand_seed;
    MAP         = map;  
end

addpath(genpath(pwd));

%%% loading configuration file with object model specific options 
if exist(['configure_' variant '.m'], 'file')
    run([ pwd '/configure_' variant '.m']);
    CONF = conf;
else
    disp('ERROR: There is no configuration file!')
    return
end

ALGORITHM = 'RRTSFN';

problem = eval([variant '(RAND_SEED, MAX_NODES, MAP, CONF);']);

max_nodes_reached = false;

%%% Starting a timer
tic;
for ind = 1:MAX_ITER
    
    
    new_node = problem.sample();
    [nearest_node_ind,new_node] = problem.nearest(new_node);
    new_node = problem.steer(nearest_node_ind, new_node); % if new node is very distant from the nearest node we go from the nearest node in the direction of a new node
    if(~problem.obstacle_collision(new_node, nearest_node_ind))
        neighbors = problem.neighbors(new_node, nearest_node_ind);
        if numel(neighbors) == 0 %this expression will show us that something is completely wrong
            %disp([' no neighbors detected at ' num2str(ind)]);
        end
        min_node = problem.chooseParent(neighbors, nearest_node_ind, new_node);
        if (problem.nodes_added == MAX_NODES)
            new_node_ind = problem.reuse_node(min_node, new_node);
        else
            new_node_ind = problem.insert_node(min_node, new_node,ind);
        end
        problem.rewire(new_node_ind, neighbors, min_node);
        if (problem.nodes_added == MAX_NODES)
                problem.best_path_evaluate();
            problem.forced_removal();
        end
    end
    
    % display progress each 100 iterations
    if(mod(ind, 100) == 0)  && ~is_benchmark
        disp([num2str(ind) ' iterations ' num2str(problem.nodes_added-1) ' nodes in ' num2str(toc) ' rewired ' num2str(problem.num_rewired)]);
    end
end

    if ~is_benchmark
        problem.plot
        disp(['Path Length : ', num2str(problem.getPathLength()), ' goal reached at iter ', num2str(problem.ind_reach_goal)]);
    end