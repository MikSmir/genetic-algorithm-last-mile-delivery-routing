function [Truck_TSP_Matrix, E_Tricycle_SABR_Matrix, E_Truck_SABR_Matrix, ... 
E_Tricycle_CABR_Matrix, E_Truck_CABR_Matrix] = ... 
nodeCoords_Test(i_Truck_Route_TSP, i_E_Tricycle_Route_SABR, i_E_Truck_Route_SABR, i_E_Tricycle_Route_CABR, i_E_Truck_Route_CABR, numCustomers, C, nc1, nc2)
% Mikhail Smirnov, 7/27/2023

% Generates matrix for each algorithm that includes both the nodes of the 
% and the coordinates for the optimal path.
% -----------------------------
% First column = nodes, Second/third columns = x,y coords

% TSP
% First and last node are depots
Truck_TSP_Matrix(1, :) = [numCustomers+1; 20; 20];
Truck_TSP_Matrix(numCustomers+2, :) = [numCustomers+2; 20; 20];
for i = 2:numCustomers+1
Truck_TSP_Matrix(i, :) = C(i_Truck_Route_TSP(i), 1:3);
end

% SABR
E_Tricycle_SABR_Matrix(1, :) = [numCustomers/2+1; 20; 20]; % Depot
E_Tricycle_SABR_Matrix(numCustomers/2+2, :) = [numCustomers/2+2; 20; 20]; % Depot
for i = 2:numCustomers/2+1
E_Tricycle_SABR_Matrix(i, :) = C(i_E_Tricycle_Route_SABR(i), 1:3);
end
E_Truck_SABR_Matrix(1, :) = [numCustomers/2+1; 20; 20]; % Depot
E_Truck_SABR_Matrix(numCustomers/2+2, :) = [numCustomers/2+2; 20; 20]; % Depot
for i = 2:numCustomers/2+1
E_Truck_SABR_Matrix(i, :) = C(i_E_Truck_Route_SABR(i), 1:3);
end

% CABR
E_Tricycle_CABR_Matrix(1, :) = [nc1-1; 20; 20]; % Depot
E_Tricycle_CABR_Matrix(nc1, :) = [nc1; 20; 20]; % Depot
for i = 2:nc1-1
E_Tricycle_CABR_Matrix(i, :) = C(i_E_Tricycle_Route_CABR(i), 1:3);
end
E_Truck_CABR_Matrix(1, :) = [nc2-1; 20; 20]; % Depot
E_Truck_CABR_Matrix(nc2, :) = [nc2; 20; 20]; % Depot
for i = 2:nc2-1
E_Truck_CABR_Matrix(i, :) = C(i_E_Truck_Route_CABR(i), 1:3);
end









% % nnz() function had to be used to find length of CABR vectors to avoid
% % counting 0's. This means it should only be used to count a vector of a 
% % route rather than an entire matrix to avoid overcounting.
% 
% % TSP
% % First and last node are depots
% Truck_TSP_Matrix(1, :) = [length(i_Truck_Route_TSP)-1; 20; 20];
% Truck_TSP_Matrix(length(i_Truck_Route_TSP), :) = [length(i_Truck_Route_TSP); 20; 20];
% for i = 2:length(i_Truck_Route_TSP)-1
%     Truck_TSP_Matrix(i, :) = C(i_Truck_Route_TSP(i), 1:3);
% end
% 
% % SABR
% E_Tricycle_SABR_Matrix(1, :) = [length(i_E_Tricycle_Route_SABR)-1; 20; 20]; % Depot
% E_Tricycle_SABR_Matrix(length(i_E_Tricycle_Route_SABR), :) = [length(i_E_Tricycle_Route_SABR); 20; 20]; % Depot
% for i = 2:length(i_E_Tricycle_Route_SABR)-1
%     E_Tricycle_SABR_Matrix(i, :) = C(i_E_Tricycle_Route_SABR(i), 1:3);
% end
% E_Truck_SABR_Matrix(1, :) = [length(i_E_Truck_Route_SABR)-1; 20; 20]; % Depot
% E_Truck_SABR_Matrix(length(i_E_Truck_Route_SABR), :) = [length(i_E_Truck_Route_SABR); 20; 20]; % Depot
% for i = 2:length(i_E_Truck_Route_SABR)-1
%     E_Truck_SABR_Matrix(i, :) = C(i_E_Truck_Route_SABR(i), 1:3);
% end
% 
% % CABR
% E_Tricycle_CABR_Matrix(1, :) = [nnz(i_E_Tricycle_Route_CABR)-1; 20; 20]; % Depot
% E_Tricycle_CABR_Matrix(nnz(i_E_Tricycle_Route_CABR), :) = [nnz(i_E_Tricycle_Route_CABR); 20; 20]; % Depot
% for i = 2:nnz(i_E_Tricycle_Route_CABR)-1
%     E_Tricycle_CABR_Matrix(i, :) = C(i_E_Tricycle_Route_CABR(i), 1:3);
% end
% E_Truck_CABR_Matrix(1, :) = [nnz(i_E_Truck_Route_CABR)-1; 20; 20]; % Depot
% E_Truck_CABR_Matrix(nnz(i_E_Truck_Route_CABR), :) = [nnz(i_E_Truck_Route_CABR); 20; 20]; % Depot
% for i = 2:nnz(i_E_Truck_Route_CABR)-1
%     E_Truck_CABR_Matrix(i, :) = C(i_E_Truck_Route_CABR(i), 1:3);
% end

end







end