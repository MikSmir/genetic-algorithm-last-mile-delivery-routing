function [C_depot] = addDepot(C, depotCoordinates, speedLimit)
% Mikhail Smirnov, 7/27/2023

% This function adds a common depot to the C matrices by adding two rows
% with the same coordinates representing the fc and lc (common depot)
% at the very end to return an (nc+2) x 4 matrix.

% depotCoordinates should be an 1x2 row vector (x,y coordinates)

% Initialize output matrix (C with depot)
[rowSize, columnSize] = size(C);
C_depot = ones(rowSize + 2, columnSize);

% Extend matrix C by 2 rows-----------------------------------------------
% Copy C matrix into C_depot, leave last two rows empty
C_depot(1:rowSize, :) = C;
C_depot = circshift(C_depot, 1); % Shift rows down to free first row


% Make the first and last rows of C_depot be the common depots
depotVec = [rowSize+1 depotCoordinates(1) depotCoordinates(2) speedLimit];
C_depot(1, :) = depotVec;
C_depot(rowSize+2, :) = depotVec;
% Fixes node label of last row
C_depot(rowSize+2,1) = rowSize+2;

end