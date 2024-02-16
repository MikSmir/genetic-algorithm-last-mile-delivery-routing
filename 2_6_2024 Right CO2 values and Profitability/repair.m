%Creating a 100 by 100 matric where all rows have Fc in column 1 and Lc in
%last column

function Y=repair(X,Fc,Lc)

%100 by 100 matrix
[x y]=size(X);
%New zeros matrix A, 100 by 100 initialize to 0
A=zeros(x,y);

%from 1 to 100
for i=1:x
    %whole row 1 initialize to B
    B = X(i,:);
    %Find x, y coordinate of First City
    [x1 y1] = find(B == Fc);
    % First element in the array empty
    B(:,y1)=[];
    %Find x, y coordinate of Last City
    [x2 y2] = find(B == Lc);
    %Make that column empty
    B(:,y2)=[];
    
    % B does not have 2 elements
    %First element is the first city
    A(i,1)=Fc; % Where does that first element go which is being replaced by Fc
    
    % Initialize middle 8 elements to B which does not have Fc and Lc 
    A(i,2:y-1)=B;
    %Last city becomes Lc
    A(i,y)=Lc;
end
Y=A;

% This code takes in the population matrix, the first city and last city
% and finds the coordinates of both cities, and puts the first city
% as the first element in the row, and the last city as the last element in
% the row. This repeats for each row.