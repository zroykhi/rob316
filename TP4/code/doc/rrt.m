%% rrt 
% Rapidly-Exploring Random Tree is sampling-based algorithm, solves 
% the problem of motion and path planning providing feasible solutions
% however it does not take into account optimality of the solution.
%
%% Syntax
%  problem = rrt(map, max_iter, is_benchmark, rand_seed, variant)
%  function returns the object of the respective class with the result
%
%% Input
%  map           -- struct with appropriate fields (developer of 
%                the class provides more information on this topic)
%  max_iter      -- number of iteration to solve the problem
%  is_benchmark  -- if true saves snapshots of the tree in a special directory
%                boolean variable
%  rand_seed     -- a random seed 
%  variant       -- what class to choose, class used defines the problem space
%% Output
% *problem* is an object of an appropriate problem space representing class 
%