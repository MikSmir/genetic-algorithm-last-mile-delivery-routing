function [nodeCoordsMatrix] = nodeCoords(C, route, depotCoordinates)
% Mikhail Smirnov, 7/27/2023

% Generates matrix that groups the nodes of the customers with the
% coordinates of the customers for the optimal path.
% -----------------------------
% First column = nodes, Second/third columns = (x,y) coords
% C = originally generated population matrix with depots (T, A, B,
% Cluster1, Cluster 2, etc)

tempRoute = route(2:nnz(route)-1); % Ignore depots
[m, ~] = size(C);
tempC = C(2:m-1, :); % Ignore depots
tempNodeCoordsMatrix = zeros(nnz(route), 3);
% Fill up matrix in correct order of nodes & customers:
for i = 1:length(tempRoute)
    tempNodeCoordsMatrix(i, :) = tempC(tempRoute(i), 1:3);
end
nodeCoordsMatrix = circshift(tempNodeCoordsMatrix,1); % Shift rows down
nodeCoordsMatrix(1, :) = [nnz(route)-1; depotCoordinates(1); depotCoordinates(2)]; % Depot
nodeCoordsMatrix(nnz(route), :) = [nnz(route); depotCoordinates(1); depotCoordinates(2)]; % Depot

% nnz() function had to be used to find length of vectors to avoid
% counting 0's in CABR. The function counts the number of nonzero elements
% in a matrix. This means it should only be used to count a vector of a
% route rather than an entire matrix to avoid overcounting.