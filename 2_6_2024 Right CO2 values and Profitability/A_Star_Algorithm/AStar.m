function [Optimal_path, path_cost] = AStar(Startx, Starty, Targetx, Targety, targetnum, blockLength, blockWidth, streetWidth, numCustomers)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A* ALGORITHM Demo
% Interactive A* search demo
% 04-26-2005
%   Copyright 2009-2010 The MathWorks, Inc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEFINE THE 2-D MAP ARRAY
% Elis Cucka 11/11/2023

% Max coordinate size in x and y, based on a 3x3 block grid 
% (3 blocks + 4 streets)
MAX_X = blockLength*3 + streetWidth*4;
MAX_Y= blockWidth*3 + streetWidth*4;
% MAX_VAL=500;

% Initialize MAP containing vehicle, target, and obstacles.
% MAP has coordinates based on 
MAP=2*(ones(MAX_X,MAX_Y));

% Obstacles, Vehicles and Spaces in MAP are marked by the following:
% Obstacle = -1,    Target = 0,     Truck/E-Tricycle = 1,   Space = 2

% NOTE: THE COORDINATES ON "MAP" HAVE TO BE FLOORED DUE TO THE PLOTTING 
% BEING DONE ON AN INTEGER-ONLY GRID

% TARGET ------------------------------------------------------------------

% Rounds x and y coordinates of target to an integer value since MAP is 
% based only on integer values
xval = floor(Targetx);
yval = floor(Targety);
xTarget=xval;%X Coordinate of the Target
yTarget=yval;%Y Coordinate of the Target


% VEHICLE -----------------------------------------------------------------

% Rounds x and y coordinates of E-Truck/E-Tricycle to an integer value 
% since MAP is based only on integer values
xval = floor(Startx);
yval = floor(Starty);
xStart=xval; % x-Starting Position
yStart=yval; % y-Starting Position


% OBSTACLES ---------------------------------------------------------------

% MAP = 2*ones(MAX_X,MAX_Y);
% Initializing obstacles
% To make sure customers are not generated in exactly the same spot
% as the obstacle walls, the obstacle walls are shifted by 1 space:
% SHIFTING:
% Bottom sides will be +0.5
% Top sides will be an extra -0.5
% Left sides will be an extra +0.5
% Right sides will be an extra -0.5

% 3x3 blocks are arranged as follows:
%  __________________________________
% |  ________   ________   ________  |
% | |        | |        | |        | |
% | | Block7 | | Block8 | | Block9 | |
% | |________| |________| |________| |
% |  ________   ________   ________  |
% | |        | |        | |        | |
% | | Block4 | | Block5 | | Block6 | |
% | |________| |________| |________| |
% |  ________   ________   ________  |
% | |        | |        | |        | |
% | | Block1 | | Block2 | | Block3 | |
% | |________| |________| |________| |
% |__________________________________|

% Block 1
MAP(streetWidth:streetWidth+blockLength-1, streetWidth) = -1; % Bottom 
MAP(streetWidth:streetWidth+blockLength-1, streetWidth+blockWidth-1) = -1; % Top
MAP(streetWidth, streetWidth:streetWidth+blockWidth-1) = -1; % Left
MAP(streetWidth+blockLength-1, streetWidth:streetWidth+blockWidth-1) = -1; % Right

% Block 2
MAP(streetWidth*2+blockLength:streetWidth*2+blockLength*2-1, streetWidth) = -1; % Bottom
MAP(streetWidth*2+blockLength:streetWidth*2+blockLength*2-1, streetWidth+blockWidth-1) = -1; % Top
MAP(streetWidth*2+blockLength, streetWidth:streetWidth+blockWidth-1) = -1; % Left
MAP(streetWidth*2+blockLength*2-1, streetWidth:streetWidth+blockWidth-1) = -1; % Right

% Block 3
MAP(streetWidth*3+blockLength*2:streetWidth*3+blockLength*3-1, streetWidth) = -1; % Bottom
MAP(streetWidth*3+blockLength*2:streetWidth*3+blockLength*3-1, streetWidth+blockWidth-1) = -1; % Top
MAP(streetWidth*3+blockLength*2, streetWidth:streetWidth+blockWidth-1) = -1; % Left
MAP(streetWidth*3+blockLength*3-1, streetWidth:streetWidth+blockWidth-1) = -1; % Right

% Block 4
MAP(streetWidth:streetWidth+blockLength-1, streetWidth*2+blockWidth) = -1; % Bottom 
MAP(streetWidth:streetWidth+blockLength-1, streetWidth*2+blockWidth*2-1) = -1; % Top
MAP(streetWidth, streetWidth*2+blockWidth:streetWidth*2+blockWidth*2-1) = -1; % Left
MAP(streetWidth+blockLength-1, streetWidth*2+blockWidth:streetWidth*2+blockWidth*2-1) = -1; % Right

% Block 5
MAP(streetWidth*2+blockLength:streetWidth*2+blockLength*2-1, streetWidth*2+blockWidth) = -1; % Bottom
MAP(streetWidth*2+blockLength:streetWidth*2+blockLength*2-1, streetWidth*2+blockWidth*2-1) = -1; % Top
MAP(streetWidth*2+blockLength, streetWidth*2+blockWidth:streetWidth*2+blockWidth*2-1) = -1; % Left
MAP(streetWidth*2+blockLength*2-1, streetWidth*2+blockWidth:streetWidth*2+blockWidth*2-1) = -1; % Right

% Block 6
MAP(streetWidth*3+blockLength*2:streetWidth*3+blockLength*3-1, streetWidth*2+blockWidth) = -1; % Bottom
MAP(streetWidth*3+blockLength*2:streetWidth*3+blockLength*3-1, streetWidth*2+blockWidth*2-1) = -1; % Top
MAP(streetWidth*3+blockLength*2, streetWidth*2+blockWidth:streetWidth*2+blockWidth*2-1) = -1; % Left
MAP(streetWidth*3+blockLength*3-1, streetWidth*2+blockWidth:streetWidth*2+blockWidth*2-1) = -1; % Right

% Block 7
MAP(streetWidth:streetWidth+blockLength-1, streetWidth*3+blockWidth*2) = -1; % Bottom 
MAP(streetWidth:streetWidth+blockLength-1, streetWidth*3+blockWidth*3-1) = -1; % Top
MAP(streetWidth, streetWidth*3+blockWidth*2:streetWidth*3+blockWidth*3-1) = -1; % Left
MAP(streetWidth+blockLength-1, streetWidth*3+blockWidth*2:streetWidth*3+blockWidth*3-1) = -1; % Right

% Block 8
MAP(streetWidth*2+blockLength:streetWidth*2+blockLength*2-1, streetWidth*3+blockWidth*2) = -1; % Bottom
MAP(streetWidth*2+blockLength:streetWidth*2+blockLength*2-1, streetWidth*3+blockWidth*3-1) = -1; % Top
MAP(streetWidth*2+blockLength, streetWidth*3+blockWidth*2:streetWidth*3+blockWidth*3-1) = -1; % Left
MAP(streetWidth*2+blockLength*2-1, streetWidth*3+blockWidth*2:streetWidth*3+blockWidth*3-1) = -1; % Right

% Block 9
MAP(streetWidth*3+blockLength*2:streetWidth*3+blockLength*3-1, streetWidth*3+blockWidth*2) = -1; % Bottom
MAP(streetWidth*3+blockLength*2:streetWidth*3+blockLength*3-1, streetWidth*3+blockWidth*3-1) = -1; % Top
MAP(streetWidth*3+blockLength*2, streetWidth*3+blockWidth*2:streetWidth*3+blockWidth*3-1) = -1; % Left
MAP(streetWidth*3+blockLength*3-1, streetWidth*3+blockWidth*2:streetWidth*3+blockWidth*3-1) = -1; % Right



% Setting coordinates of vehicle and target
MAP(floor(Startx), floor(Starty)) = 0; 
MAP(floor(Targetx), floor(Targety)) = 1;

% axis([1 MAX_X+1 1 MAX_Y+1])
% grid on;
% hold on;


% Scan along the grid.
% If detects target, set target coordinates to xTarget and yTarget
% Else if detects start, set start coordinates to xTarget and yTarget
    % and set start coordinates to xval and yval
% for i=1:MAX_X
%     for j=1:MAX_Y
%         if(MAP(i,j) == 1)
%             xTarget = i;
%             yTarget = j;
% 
%         elseif(MAP(i,j) == -1)
%            %plot(i+.5,j+.5, 'r.', 'MarkerSize', 6);
%         elseif(MAP(i,j) == 0)
%             
%             xval = i;
%             xStart = i;
%             yval = j;
%             yStart = j;
%             
%         end
%     end
% end
% xval and yval will always hold vehicle location (start coordinates)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LISTS USED FOR ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OPEN LIST STRUCTURE
%--------------------------------------------------------------------------
%IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
%--------------------------------------------------------------------------
OPEN=[];
%CLOSED LIST STRUCTURE
%--------------
%X val | Y val |
%--------------
% CLOSED=zeros(MAX_VAL,2);
CLOSED=[];
%Put all obstacles on the Closed list
k=1;%Dummy counter
for i=1:MAX_X
    for j=1:MAX_Y
        if(MAP(i,j) == -1)
            CLOSED(k,1)=i; 
            CLOSED(k,2)=j; 
            k=k+1;
        end
    end
end
CLOSED_COUNT=size(CLOSED,1);
%set the starting node as the first node
% Start coordinates (vehicle) are assigned to xNode and yNode
xNode=xval;
yNode=yval;

OPEN_COUNT=1;
path_cost=0;
% Calculate distance from start to target
goal_distance=distance(xNode, yNode, xTarget, yTarget);
% 
OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance)
path_cost
goal_distance
OPEN(OPEN_COUNT,1)=0;
CLOSED_COUNT=CLOSED_COUNT+1;
CLOSED(CLOSED_COUNT,1)=xNode;
CLOSED(CLOSED_COUNT,2)=yNode;
NoPath=1;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)
 % plot(xNode+.5,yNode+.5,'go');
 exp_array=expand_array(xNode,yNode,path_cost,xTarget,yTarget,CLOSED,MAX_X,MAX_Y);
 exp_count=size(exp_array,1);
 %UPDATE LIST OPEN WITH THE SUCCESSOR NODES
 %OPEN LIST FORMAT
 %--------------------------------------------------------------------------
 %IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
 %--------------------------------------------------------------------------
 %EXPANDED ARRAY FORMAT
 %--------------------------------
 %|X val |Y val ||h(n) |g(n)|f(n)|
 %--------------------------------
 for i=1:exp_count
    flag=0;
    for j=1:OPEN_COUNT
        if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) )
            OPEN(j,8)=min(OPEN(j,8),exp_array(i,5)); %#ok<*SAGROW>
            if OPEN(j,8)== exp_array(i,5)
                %UPDATE PARENTS,gn,hn
                OPEN(j,4)=xNode;
                OPEN(j,5)=yNode;
                OPEN(j,6)=exp_array(i,3);
                OPEN(j,7)=exp_array(i,4);
            end;%End of minimum fn check
            flag=1;
        end;%End of node check
%         if flag == 1
%             break;
    end;%End of j for
    if flag == 0
        OPEN_COUNT = OPEN_COUNT+1;
        OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
     end;%End of insert new element into the OPEN list
 end;%End of i for
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %END OF WHILE LOOP
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Find out the node with the smallest fn 
  index_min_node = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn
   xNode=OPEN(index_min_node,2);
   yNode=OPEN(index_min_node,3);
   path_cost=OPEN(index_min_node,6);%Update the cost of reaching the parent node
  %Move the Node to list CLOSED
  CLOSED_COUNT=CLOSED_COUNT+1;
  CLOSED(CLOSED_COUNT,1)=xNode;
  CLOSED(CLOSED_COUNT,2)=yNode;
  OPEN(index_min_node,1)=0;
  else
      %No path exists to the Target!!
      NoPath=0;%Exits the loop!
  end;%End of index_min_node check
end;%End of While Loop
%Once algorithm has run The optimal path is generated by starting of at the
%last node(if it is the target node) and then identifying its parent node
%until it reaches the start node.This is the optimal path
i=size(CLOSED,1);
Optimal_path=[];
xval=CLOSED(i,1);
yval=CLOSED(i,2);
i=1;
Optimal_path(i,1)=xval;
Optimal_path(i,2)=yval;
i=i+1;
if ( (xval == xTarget) && (yval == yTarget))
    inode=0;
   %Traverse OPEN and determine the parent nodes
   parent_x=OPEN(node_index(OPEN,xval,yval),4);%node_index returns the index of the node
   parent_y=OPEN(node_index(OPEN,xval,yval),5);
   parent_x;
   parent_y;
   while( parent_x ~= xStart || parent_y ~= yStart)
           Optimal_path(i,1) = parent_x;
           Optimal_path(i,2) = parent_y;
           %Get the grandparents:-)
           inode=node_index(OPEN,parent_x,parent_y);
           parent_x=OPEN(inode,4);%node_index returns the index of the node
           parent_y=OPEN(inode,5);
           i=i+1;
    end;
 j=size(Optimal_path,1);
 % ADDED THESE FOLLOWING 2 LINES TO FIX PLOTTING OF WHOLE PATH
 Optimal_path(j+1, 1) = xStart;
 Optimal_path(j+1, 2) = yStart;
 %Plot the Optimal Path!
 %p=plot(xStart + 0.5,yStart+0.5,'bo'); %
%  j=j-1 %increased speed of plotting, it was 1
%  for i=j:-1:1
%   %pause(.25);
%   set(p,'XData',Optimal_path(i,1)+0.5,'YData',Optimal_path(i,2)+0.5); %
%  drawnow ;
%  end
 %plot(Optimal_path(:,1)+0.5,Optimal_path(:,2)+0.5); %
else
 %pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
end



    
end




