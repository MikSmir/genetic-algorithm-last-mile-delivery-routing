function [randCustomers] = generateCustomers_intGrid(nc)
% Mikhail Smirnov, 8/03/2023

% INTEGER-ONLY VERSION

% Generates an (nc x 4) matrix where:
% 1st column is customer index
% 2nd/3rd columns are x & y customer coordinates respectively
% 4th column is speed limit
 
% The customers are randomly generated along the perimeters (sides) of the 
% 9 blocks and plotted.

% ***
% -nc must be an even integer
% -Depot is not a location in the output matrix.
% -To avoid possibility of duplicate customers, replacement in Line 31 must 
%  be set to false.
% ***



% Customer location generation --------------------------------------------
 % Randomly generates customers between coordinates [50 150), [200 300), or [350 450)
 % in both x and y.


% Randomly chooses customer locations
custRange = 50:150; % List of customer locations to choose from
                                    % Replacement
customers = randsample(custRange, nc, false); % Randomly choose nc customer locations without replacement
% CANNOT HAVE MORE THAN 100 CUSTOMERS FOR "without replacement"

% *******************************
% If I want to have Replacement set to false for nc > 100, then the grid 
% size would have to scale with the amount of customers, since the 
% coordinates would only be finite integer values and there 
% would only be a limited amount of locations to chose from.
% There would be a small chance of duplicated customers.
% ********************************


% Sets the permutation of customer locations to be only between the range 
% of the block locations.
for i=1:nc
    randNumSide = randi(3);
    if randNumSide == 1
        customers(i) = customers(i) + 0; % Sets element to between [50 150]
    elseif randNumSide == 2
        customers(i) = customers(i) + 150; % Sets element to between [200 300]
    else
        customers(i) = customers(i) + 300; % Sets element to between [350 450]
    end
end 





% Randomly chooses a side for each customer
sideCoords = [50 150 200 300 350 450]; % Choice of sides
xy_coords = zeros(nc, 2); % (x,y) coordinates

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

% Sets E-tricycle speed limit
speed1 = 15;
speedLimit = speed1 * ones(nc,1);
% Sets E-truck speed limit
speed2 = 30;
speedLimit((nc/2 + 1):nc) = speed2;

% Piece together the output matrix
randCustomers = [customerIndex xy_coords(:, 1) xy_coords(:, 2) speedLimit];

% ------------------------------------------------------------------------
% Test plot of customers: 

figure(1)   
hold on
xlim([0 500])
ylim([0 500])

% Drawing blocks:
% Block 1
x1 = [50 50 150 150];
y1 = [50 150 150 50];
fill(x1, y1, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% Block 2
x2 = [200 200 300 300];
y2 = [50 150 150 50];
fill(x2, y2, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% Block 3
x3 = [350 350 450 450];
y3 = [50 150 150 50];
fill(x3, y3, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% Block 4
x4 = [50 50 150 150];
y4 = [200 300 300 200];
fill(x4, y4, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% Block 5
x5 = [200 200 300 300];
y5 = [200 300 300 200];
fill(x5, y5, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% Block 6
x6 = [350 350 450 450];
y6 = [200 300 300 200];
fill(x6, y6, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% Block 7
x7 = [50 50 150 150];
y7 = [350 450 450 350];
fill(x7, y7, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% Block 8
x8 = [200 200 300 300];
y8 = [350 450 450 350];
fill(x8, y8, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
% Block 9
x9 = [350 350 450 450];
y9 = [350 450 450 350];
fill(x9, y9, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)


% Roads
xr1 = [0 0 50 50];
yr1 = [0 500 500 0];
fill(xr1, yr1, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

xr2 = [150 150 200 200];
yr2 = [0 500 500 0];
fill(xr2, yr2, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

xr3 = [300 300 350 350];
yr3 = [0 500 500 0];
fill(xr3, yr3, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

xr4 = [450 450 500 500];
yr4 = [0 500 500 0];
fill(xr4, yr4, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

xr5 = [0 0 500 500];
yr5 = [0 50 50 0];
fill(xr5, yr5, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

xr6 = [0 0 500 500];
yr6 = [150 200 200 150];
fill(xr6, yr6, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

xr7 = [0 0 500 500];
yr7 = [300 350 350 300];
fill(xr7, yr7, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

xr8 = [0 0 500 500];
yr8 = [450 500 500 450];
fill(xr8, yr8, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

% Plot customers in blue
plot(randCustomers(:,2), randCustomers(:,3), "mo")
% plot(10, 10, 'pentagram', 'Color', 'red') % Drawn depot as red star

hold off

end