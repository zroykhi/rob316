% Based on the code by Anthony Chrabieh
% Modifications by D. Filliat for ROB316

clear all
figure
cmap=jet(120);
% load package from octave
try
    pkg load image  
end
%Define Number of Nodes
xmax = 80;
ymax = 20;

%Start and Goal
start = [10,ymax/2];
goal = [xmax,ymax/2-3];

%Nodes
MAP = zeros(xmax,ymax);

%To define objects, set their MAP(x,y) to inf
MAP(40,5:15) = inf;
MAP(35:40,5) = inf;
MAP(35:40,15) = inf;
MAP(60:62,1:7) = inf;
MAP(60:62,9:12) = inf;


%To use Random Objects, uncomment this secion
% NumberOfObjects = 10;
% k = 0;
% while (k < NumberOfObjects)
%     length = max(3,randi(9));
%     x = randi(xmax-2*length)+length;
%     y = randi(ymax-2*length)+length;
%     direction = randi(4);
%     if (direction == 1)
%         x = x:x+length;
%     elseif (direction == 2)
%         x = x-length:x;
%     elseif (direction == 3)
%         y = y:y+length;
%     elseif (direction == 4)
%         y = y-length:y;
%     end
%     if (sum(isinf(MAP(x,y)))>0)
%         continue
%     end
%     MAP(x,y) = inf;
%     k = k + 1;
% end

tic
%Compute Heuristic for each node%%%%%%%%%%%%%%%%%%%%%%%%%%%
weight = 1.4;

for x = 1:size(MAP,1)
    for y = 1:size(MAP,2)
        if(MAP(x,y)~=inf)
            H(x,y) = weight*norm(goal-[x,y]);
            G(x,y) = inf;
        end
    end
end

%Set node Traversal cost%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% W = zeros(size(MAP));
W = 1 ./ bwdist(MAP);


%Plotting%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imshow(1-MAP')
% for octave, comment out the following code
% truesize([500 1000])

hold all
plot(start(1),start(2),'s','MarkerFaceColor','b')
plot(goal(1),goal(2),'s','MarkerFaceColor','m')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%initial conditions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G(start(1),start(2)) = 0;
F(start(1),start(2)) = H(start(1),start(2));

closedNodes = [];
openNodes = [start G(start(1),start(2)) F(start(1),start(2)) 0]; %[x y G F cameFrom]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Solve
solved = false;
while(~isempty(openNodes))
    
    pause(1e-5)

    
    %find node from open set with smallest F value
    [A,I] = min(openNodes(:,4));
    
    %set current node
    current = openNodes(I,:);
    color = cmap(min([round(G(current(1),current(2)))+1 120]),:);
    plot(current(1),current(2),'o','color',color,'MarkerFaceColor',color)

    %if goal is reached, break the loop
    if(current(1:2)==goal)
        closedNodes = [closedNodes;current];
        solved = true;
        break;
    end
    
    %remove current node from open set and add it to closed set
    openNodes(I,:) = [];
    closedNodes = [closedNodes;current];
    
    %for all neighbors of current node
    for x = current(1)-1:current(1)+1
        for y = current(2)-1:current(2)+1
            
            %if out of range skip
            if (x<1||x>xmax||y<1||y>ymax)
                continue
            end
            
            %if object skip
            if (isinf(MAP(x,y)))
                continue
            end
            
            %if current node skip
            if (x==current(1)&&y==current(2))
                continue
            end
            
            %if already in closed set skip
         
            skip = 0;
            for j = 1:size(closedNodes,1)
                if(x == closedNodes(j,1) && y==closedNodes(j,2))
                    skip = 1;
                    break;
                end
            end           
            if(skip > 0)
                continue
            end
           
            
            A = [];
            %Check if already in open set
            if(~isempty(openNodes))
                for j = 1:size(openNodes,1)
                    if(x == openNodes(j,1) && y==openNodes(j,2))
                        A = j;
                        break;
                    end
                end
            end
            
            
            newG = G(current(1),current(2)) + round(norm([current(1)-x,current(2)-y]),1) + W(x,y);
            % code below is for octave 
            % newG = G(current(1),current(2)) + norm([current(1)-x,current(2)-y]) + W(x,y);
            
            %if not in open set, add to open set
            if(isempty(A))
                G(x,y) = newG;
                newF = G(x,y) + H(x,y);
                newNode = [x y G(x,y) newF size(closedNodes,1)];
                openNodes = [openNodes; newNode];
                plot(x,y,'x','color','b')
                continue
            end
            
            %if no better path, skip
            if (newG >= G(x,y))
                continue
            end
            
            G(x,y) = newG;
            newF = newG + H(x,y);
            openNodes(A,3:5) = [newG newF size(closedNodes,1)];
        end
    end
end

if (solved)
    %Path plotting
    j = size(closedNodes,1);
    path = [];
    while(j > 0)
        x = closedNodes(j,1);
        y = closedNodes(j,2);
        j = closedNodes(j,5);
        path = [x,y;path];
    end
    pathLength=0;
    
    plot(path(1,1),path(1,2),'o','color','r','MarkerFaceColor','r')
    for j = 2:size(path,1)
        plot(path(j,1),path(j,2),'o','color','r','MarkerFaceColor','r')
        pathLength=pathLength+norm([path(j,1)-path(j-1,1) path(j,2)-path(j-1,2)]);
        pause(0.001)
    end
    disp(['Path length = ' num2str(pathLength)]);
else
    disp('No Path Found')
end
toc
