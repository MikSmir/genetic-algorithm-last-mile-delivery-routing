function [randCustomers] = generateCustomers(nc)

% Generates an (nc x 4) matrix of random customer locations
% *nc must be even

% Customer node labels
customerIndex = (1:nc)';

% Random customer coordinates from 0 to 100
randCoordinates = randi(100, nc, 2) + rand(nc, 2);

% Sets E-tricycle speed limit
speed1 = 15;
speedLimit = speed1 * ones(nc,1);
% Sets E-truck speed limit
speed2 = 30;
speedLimit((nc/2 + 1):nc) = speed2;

% Piece together the output matrix
randCustomers = [customerIndex randCoordinates speedLimit];

% Test plot of customers                        
figure(1)                                       % Depot
plot(randCustomers(:,2), randCustomers(:,3), "o", 20, 20, "ro")

end