function [randCustomers] = generateCustomers_Grid(nc)
% Mikhail Smirnov, 7/27/2023

% Generates an (nc x 4) matrix where:
% 1st column is customer index
% 2nd/3rd columns are x & y customer coordinates respectively
% 4th column is speed limit
 
% The customers are randomly generated along the perimeters (sides) of the 
% 9 blocks and plotted.

% ***
% -nc must be an even integer
% -Depot is not a location in the output matrix.
% -To avoid possibility of duplicate customers, replacement in Line 30 must 
%  be set to false.
% ***



% Customer location generation --------------------------------------------
 % Randomly generates customers between coordinates [10 30), [40 60), or [70 90)
 % in both x and y.


% Randomly chooses customer locations
custRange = 0:19; % List of customer locations to choose from
offset = rand(1,20);
custRange = custRange + offset; % To minimize chance of duplicated customers
                                    % Replacement
customers = randsample(custRange, nc, true); % Randomly choose nc customer locations with replacement
% *************
% NOTE: I added the offset to minimize the chance of duplicated customers 
% occuring frequently, but there is still a tiny chance some customers may 
% be duplicated.
% If I truly want to make the customers not duplicated, then in Line 30,
% Replacement must be set to "false", however I can only do this for 20 
% customers (nc = 20). 
% If I want to have Replacement set to false for nc > 20, then the grid 
% size would have to scale with the amount of customers, since the 
% coordinates would only be integer values without the offset and there 
% would only be a limited amount of locations to chose from.
% *************


% Sets the permutation of customer locations to be only between the range 
% of the block locations.
for i=1:nc
    randNumSide = randi(3);
    if randNumSide == 1
        customers(i) = customers(i) + 10; % Sets element to between [10 30)
    elseif randNumSide == 2
        customers(i) = customers(i) + 40; % Sets element to between [40 60)
    else
        customers(i) = customers(i) + 70; % Sets element to between [70 90)
    end
end 





% Randomly chooses a side for each customer
sideCoords = [10 30 40 60 70 90]; % Choice of sides
xy_coords = zeros(20, 2); % (x,y) coordinates

% Either the x or y coordinate has to be randomly set to a constant in
% order to have the other coordinate lie on a side of a block.
for i=1:nc
    % Randomly chooses whether to restrict either x or y coordinate
    randNum = randi(2);

    if randNum == 1
        % Restrict y-coordinate to a side
        xy_coords(i,1) = customers(i); % x-coordinate
        xy_coords(i,2) = randsample(sideCoords, 1); % y-coordinate (picks random side)
    
    else
        % Restrict x-coordinate to a side
        xy_coords(i,1) = randsample(sideCoords, 1); % x-coordinate (picks random side)
        xy_coords(i,2) = customers(i); % y-coordinate
    end
end

% Randomness:
% -Creates random permutation of locations
% -Randomly chooses whether x or y will be restricted to a side
% -Randomly chooses a side


% Possible improvement: Since the less customers you have, the more
% duplicate customers will appear, maybe for higher number of customers
% (100), the grid size should be increased.


% ------------------------------------------------------------------------
% Output:

% Customer node labels
customerIndex = (1:nc)';

% Note: Currently C (or randCustomers) matrix has half of the rows equal to 
% E-Tricycle speed limit and the other half to E-Truck speed limit since we
% assumed SABR would have half customers be E-Tricycle customers and the 
% other half be E-truck customers.

% Sets E-tricycle speed limit
speed1 = 15;
speedLimit = speed1 * ones(nc,1);
% Sets E-truck speed limit
speed2 = 30;
speedLimit((nc/2 + 1):nc) = speed2;

% Piece together the output matrix
randCustomers = [customerIndex xy_coords(:, 1) xy_coords(:, 2) speedLimit];

% % ------------------------------------------------------------------------
% % Test plot of customers: 
% 
% figure(1)   
% hold on
% xlim([0 100])
% ylim([0 100])
% 
% % Drawing blocks:
% % Block 1
% x1 = [10 10 30 30];
% y1 = [10 30 30 10];
% fill(x1, y1, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% % Block 2
% x2 = [40 40 60 60];
% y2 = [10 30 30 10];
% fill(x2, y2, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% % Block 3
% x3 = [70 70 90 90];
% y3 = [10 30 30 10];
% fill(x3, y3, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% % Block 4
% x4 = [10 10 30 30];
% y4 = [40 60 60 40];
% fill(x4, y4, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% % Block 5
% x5 = [40 40 60 60];
% y5 = [40 60 60 40];
% fill(x5, y5, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% % Block 6
% x6 = [70 70 90 90];
% y6 = [40 60 60 40];
% fill(x6, y6, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% % Block 7
% x7 = [10 10 30 30];
% y7 = [70 90 90 70];
% fill(x7, y7, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% % Block 8
% x8 = [40 40 60 60];
% y8 = [70 90 90 70];
% fill(x8, y8, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% % Block 9
% x9 = [70 70 90 90];
% y9 = [70 90 90 70];
% fill(x9, y9, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% 
% 
% % Roads
% xr1 = [0 0 100 100];
% yr1 = [0 10 10 0];
% fill(xr1, yr1, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')
% 
% xr2 = [0 0 100 100];
% yr2 = [30 40 40 30];
% fill(xr2, yr2, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')
% 
% xr3 = [0 0 100 100];
% yr3 = [60 70 70 60];
% fill(xr3, yr3, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')
% 
% xr4 = [0 0 100 100];
% yr4 = [90 100 100 90];
% fill(xr4, yr4, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')
% 
% xr5 = [0 0 10 10];
% yr5 = [0 100 100 0];
% fill(xr5, yr5, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')
% 
% xr6 = [30 30 40 40];
% yr6 = [0 100 100 0];
% fill(xr6, yr6, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')
% 
% xr7 = [60 60 70 70];
% yr7 = [0 100 100 0];
% fill(xr7, yr7, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')
% 
% xr8 = [90 90 100 100];
% yr8 = [0 100 100 0];
% fill(xr8, yr8, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')
% 
% % Plot customers in blue
% plot(randCustomers(:,2), randCustomers(:,3), "mo")
% % plot(10, 10, 'pentagram', 'Color', 'red') % Drawn depot as red star
% 
% hold off

end