function [randCustomers] = generateCustomers_intGrid_adjustable(nc, blockLength, blockWidth, streetWidth, replacementEnabled, plotEnabled)
% Mikhail Smirnov, 8/20/2023

% INTEGER-ONLY VERSION WITH ADJUSTABLE GRID SIZE AND BLOCK/STREET SIZE

% Generates an (nc x 4) matrix where:
% 1st column is customer index
% 2nd/3rd columns are x & y random customer coordinates respectively
% 4th column is speed limit

% The customers are randomly generated along the perimeters (sides) of the
% 9 blocks and plotted.

% ***
% -nc must be an even integer
% -Depot is not a location in the output matrix.
% -To avoid possibility of duplicate customers, replacement in Line 31 must
%  be set to false.
% ***

% Measurements for Manhattan block (900x300), scaled down by 30
% blockLength = 30; % Horizontal length for each block
% blockWidth = 10;% Vertical width for each block
% streetWidth = 2;
% replacementEnabled = true;
% plotEnabled = true;

% Customer location generation --------------------------------------------
% Randomly generates customers between coordinates
% in both x and y.


%:: Possible idea, instead of generating custRange and shifting the range up
% randomly to fit into the other blocks,
% instead generate within the whole range 2:96, 
% but do an if statement that checks if the coordinates get generated 
% at the streets.
% i.e. if generated at 33, 65, etc, delete those coordinates and replace
% them. 

% Randomly chooses customer locations
custRangeHorizontal = streetWidth:streetWidth+blockLength; % List of customer locations to choose from (horizontal) %::
custRangeVertical = streetWidth:streetWidth+blockWidth; % (vertical)
% Replacement
customersX = randsample(custRangeHorizontal, nc, replacementEnabled); % Randomly choose nc customer locations without replacement
customersY = randsample(custRangeVertical, nc, replacementEnabled); % Randomly choose nc customer locations without replacement



% Sets the permutation of customer locations to be only between the range
% of the block locations.
% Horizontal customer locations
for i=1:nc
    randNumSide1 = randi(3);
    if randNumSide1 == 1
        customersX(i) = customersX(i) + 0; % Sets element to between [2 32] Left blocks
    elseif randNumSide1 == 2
        customersX(i) = customersX(i) + (blockLength + streetWidth); % Sets element to between [34 64] Center blocks
    else
        customersX(i) = customersX(i) + 2*(blockLength + streetWidth); % Sets element to between [66 96] Right blocks
    end
end

% Vertical customer locations
for i=1:nc
    randNumSide2 = randi(3);
    if randNumSide2 == 1
        customersY(i) = customersY(i) + 0; % Sets element to between [2 32] Left blocks
    elseif randNumSide2 == 2
        customersY(i) = customersY(i) + (blockWidth + streetWidth); % Sets element to between [34 64] Center blocks
    else
        customersY(i) = customersY(i) + 2*(blockWidth + streetWidth); % Sets element to between [66 96] Right blocks
    end
end


% Randomly chooses a side for each customer
% sideCoords = [2 32 34 64 66 96]; % Choice of sides %::
sideCoordsX = [streetWidth (blockLength+streetWidth) (blockLength+streetWidth*2) (blockLength*2+streetWidth*2) (blockLength*2+streetWidth*3) (blockLength*3+streetWidth*3)]; % Choice of sides %::
sideCoordsY = [streetWidth (blockWidth+streetWidth) (blockWidth+streetWidth*2) (blockWidth*2+streetWidth*2) (blockWidth*2+streetWidth*3) (blockWidth*3+streetWidth*3)]; % Choice of sides %::
xy_coords = zeros(nc, 2); % (x,y) coordinates

% Either the x or y coordinate has to be randomly set to a constant in
% order to have the other coordinate lie on a side of a block.
for i=1:nc
    % Randomly chooses whether to restrict either x or y coordinate
    randNum = randi(2);

    if randNum == 1
        % Restrict y-coordinate to a side
        xy_coords(i,1) = customersX(i); % x-coordinate
        xy_coords(i,2) = randsample(sideCoordsY, 1); % y-coordinate (picks random side)

    else
        % Restrict x-coordinate to a side
        xy_coords(i,1) = randsample(sideCoordsX, 1); % x-coordinate (picks random side)
        xy_coords(i,2) = customersY(i); % y-coordinate
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

if plotEnabled == true

    figure(1)
    hold on
    xlim([0 blockLength*3+streetWidth*4])%::
    ylim([0 blockWidth*3+streetWidth*4])%::

    % Drawing blocks:
    % Block 1
    x1 = [streetWidth streetWidth blockLength+streetWidth blockLength+streetWidth];
    y1 = [streetWidth blockWidth+streetWidth blockWidth+streetWidth streetWidth];
    fill(x1, y1, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
    % Block 2
    x2 = [blockLength+streetWidth*2 blockLength+streetWidth*2 blockLength*2+streetWidth*2 blockLength*2+streetWidth*2];
    y2 = [streetWidth blockWidth+streetWidth blockWidth+streetWidth streetWidth];
    fill(x2, y2, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
    % Block 3
    x3 = [blockLength*2+streetWidth*3 blockLength*2+streetWidth*3 blockLength*3+streetWidth*3 blockLength*3+streetWidth*3];
    y3 = [streetWidth blockWidth+streetWidth blockWidth+streetWidth streetWidth];
    fill(x3, y3, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
    % Block 4
    x4 = [streetWidth streetWidth blockLength+streetWidth blockLength+streetWidth];
    y4 = [blockWidth+streetWidth*2 blockWidth*2+streetWidth*2 blockWidth*2+streetWidth*2 blockWidth+streetWidth*2];
    fill(x4, y4, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
    % Block 5
    x5 = [blockLength+streetWidth*2 blockLength+streetWidth*2 blockLength*2+streetWidth*2 blockLength*2+streetWidth*2];
    y5 = [blockWidth+streetWidth*2 blockWidth*2+streetWidth*2 blockWidth*2+streetWidth*2 blockWidth+streetWidth*2];
    fill(x5, y5, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
    % Block 6
    x6 = [blockLength*2+streetWidth*3 blockLength*2+streetWidth*3 blockLength*3+streetWidth*3 blockLength*3+streetWidth*3];
    y6 = [blockWidth+streetWidth*2 blockWidth*2+streetWidth*2 blockWidth*2+streetWidth*2 blockWidth+streetWidth*2];
    fill(x6, y6, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
    % Block 7
    x7 = [streetWidth streetWidth blockLength+streetWidth blockLength+streetWidth];
    y7 = [blockWidth*2+streetWidth*3 blockWidth*3+streetWidth*3 blockWidth*3+streetWidth*3 blockWidth*2+streetWidth*3];
    fill(x7, y7, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
    % Block 8
    x8 = [blockLength+streetWidth*2 blockLength+streetWidth*2 blockLength*2+streetWidth*2 blockLength*2+streetWidth*2];
    y8 = [blockWidth*2+streetWidth*3 blockWidth*3+streetWidth*3 blockWidth*3+streetWidth*3 blockWidth*2+streetWidth*3];
    fill(x8, y8, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)
    % Block 9
    x9 = [blockLength*2+streetWidth*3 blockLength*2+streetWidth*3 blockLength*3+streetWidth*3 blockLength*3+streetWidth*3];
    y9 = [blockWidth*2+streetWidth*3 blockWidth*3+streetWidth*3 blockWidth*3+streetWidth*3 blockWidth*2+streetWidth*3];
    fill(x9, y9, 'yellow', 'EdgeColor', 'none', 'FaceAlpha', 0.2)


    % Streets
    xr1 = [0 0 streetWidth streetWidth];
    yr1 = [0 blockWidth*3+streetWidth*4 blockWidth*3+streetWidth*4 0];
    fill(xr1, yr1, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

    xr2 = [blockLength+streetWidth blockLength+streetWidth blockLength+streetWidth*2 blockLength+streetWidth*2];
    yr2 = [0 blockWidth*3+streetWidth*4 blockWidth*3+streetWidth*4 0];
    fill(xr2, yr2, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

    xr3 = [blockLength*2+streetWidth*2 blockLength*2+streetWidth*2 blockLength*2+streetWidth*3 blockLength*2+streetWidth*3];
    yr3 = [0 blockWidth*3+streetWidth*4 blockWidth*3+streetWidth*4 0];
    fill(xr3, yr3, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

    xr4 = [blockLength*3+streetWidth*3 blockLength*3+streetWidth*3 blockLength*3+streetWidth*4 blockLength*3+streetWidth*4];
    yr4 = [0 blockWidth*3+streetWidth*4 blockWidth*3+streetWidth*4 0];
    fill(xr4, yr4, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

    xr5 = [0 0 blockLength*3+streetWidth*4 blockLength*3+streetWidth*4];
    yr5 = [0 streetWidth streetWidth 0];
    fill(xr5, yr5, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

    xr6 = [0 0 blockLength*3+streetWidth*4 blockLength*3+streetWidth*4];
    yr6 = [blockWidth+streetWidth blockWidth+streetWidth*2 blockWidth+streetWidth*2 blockWidth+streetWidth];
    fill(xr6, yr6, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

    xr7 = [0 0 blockLength*3+streetWidth*4 blockLength*3+streetWidth*4];
    yr7 = [blockWidth*2+streetWidth*2 blockWidth*2+streetWidth*3 blockWidth*2+streetWidth*3 blockWidth*2+streetWidth*2];
    fill(xr7, yr7, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

    xr8 = [0 0 blockLength*3+streetWidth*4 blockLength*3+streetWidth*4];
    yr8 = [blockWidth*3+streetWidth*3 blockWidth*3+streetWidth*4 blockWidth*3+streetWidth*4 blockWidth*3+streetWidth*3];
    fill(xr8, yr8, 'g', 'FaceColor', '#E5E7E9', 'EdgeColor', 'none')

    % Plot customers in blue
    plot(randCustomers(:,2), randCustomers(:,3), "mo")
    % plot(10, 10, 'pentagram', 'Color', 'red') % Drawn depot as red star
    hold off
end

end