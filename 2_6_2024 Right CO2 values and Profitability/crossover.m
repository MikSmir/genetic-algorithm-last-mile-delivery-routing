%50 by 10 matric and 25 chromosomes

function YY = crossover(X,n)
% X = population matrix
% n = Number of chromosomes to be crossed
% x1 is the number of rows 50 (solutions)
% y1 is the number of columns 10 (customers/cities)
[x1 y1] = size(X);

%zeros matrix 25 by 10 (# of chromosomes by # of customers)
Y = zeros(n,y1);

% from 1 to 25, (for each chromosome)
for z = 1:n
    %take random row 1-50 (50 numbers), B is just a row from population
    % in other words, choose random solution out of 50
    B = X(randi(x1),:); % select parent chromosome
    %variable r1 = 1 + value from 1 - 9
    r1 = 1 + randi(y1-1); % for example 3
    %Row 1, Column 1 through 3, take a part of B and initialize C
    C = B(1,1:r1);
    %For B (the row from my matrix population), whole row, column 1 throgh 3 are empty
    B(:,1:r1) = [];  % cut
    %Size of B becomes x3 becomes 1 and y3 becomes 7
    [x3 y3] = size(B);
    %Row 1, column 8 through 10 becomes whatever you cut in the beginning
    B(1,y3+1:y1) = C;
    Y(z,:) = B; % Each row of Y is a different chromosome (different solution)
end
YY = Y;

%It will return a whole 1 by 25 matric whith cuts 


% This code takes in the population matrix (solutions by cities) and for
% each chromosome, chooses random solution (row) for all cities as vector B.
% Then takes a part of the columns of B randomly for the row and shuffles
% them at the end of untouched columns.
% These new rows are added into the population matrix.
% The resulting rows are considered the chromosomes of the offspring from
% the parents (the original rows).

% i.e. Randomly choose row B = "2 4 3 1 5"
% Randomly decide to empty indices 1-3 and store them in C
% B is left with row "1 5"
% Take the emptied entries in C and place them at the end of B
% You are left with "1 5 2 4 3"
% Repeat for all rows (chromosomes)