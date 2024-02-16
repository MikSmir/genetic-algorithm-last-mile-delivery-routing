        function YY=evaluation(P,Data)
% P = population size
% Data = city locations whith coordinates
[x0 y0]=size(P);


%From 1 to 100
for i = 1:x0
    %Take each row
    A=P(i,:); % one chromosome [11,12,13,14,15,16,17,18,19,20]
    %Create row of zeros to contain all the distance between consecutive
    %elements
    B=zeros(size(A));
    
    % from 1 to 9
    for j1 = 1:y0-1
        %You go in your Data array, in first column find let's say location
        %2
        % x1 is the x value of the location, y1 is the y value of the
        % location
        % "find" is used here to return indices of the matching entries of Data
        % and A, where the coordinate indices are stored in x1/x2 and y1/y2.
        % in order to find the row index ("name" of city)
        [x1 y1]=find(Data(:,1)==A(1,j1));
        [x2 y2]=find(Data(:,1)==A(1,j1+1));
        %calculation distance between two consecutive elements of A
        %Recording that distance in B
        B(1,j1)=sqrt((Data(x1,2)-Data(x2,2))^2+(Data(x1,3)-Data(x2,3))^2);
    end
    % B has 9 elements, last value of j1 is 9
    %x and y values for first and last elements
    [x1 y1]=find(Data(:,1)==A(1,1)); 
    [x2 y2]=find(Data(:,1)==A(1,y0));
    % last element of B will be the distance between First and Last city
    B(1,j1+1)=sqrt((Data(x1,2)-Data(x2,2))^2+(Data(x1,3)-Data(x2,3))^2);
    % The higher the sum the lower the number for the element of Y and vice
    % verca. We want the highest number
    
    % The highest number here will tell us the least amount of distance
    % traveled and will store those sums for each solution.
    Y(1,i)=1/sum(B);
end
YY =Y;

% Returning 100 values where the highest value is what we want.

% This code takes the Population matrix and the Data matrix and by using the 
% Population matrix, the cities from Data are selected based on each
% chromosome (row) and calculates the distance between the cities.
% Output is vector Y, where
% each entry represents the total distance between the cities
% for each solution. The largest number is best since 1/sum.
% The outputted 1/sum results represent the fitness of each solution.