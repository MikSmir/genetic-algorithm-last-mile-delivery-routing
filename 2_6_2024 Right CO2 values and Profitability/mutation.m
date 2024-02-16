function Y = mutation(X,n)
% X = population
% n = number of chromosomes to be mutated

% x1 is 50 y1 is 10
[x1 y1]=size(X);

%zeros matrix 25 by 10
Y=zeros(n,y1);
 

%from 1 to 25
for z=1:n
    
    %take random row 1-50 (50 numbers), B is just a row from population
    A=X(randi(x1),:); % select parent chromosome [1,2,3,4,5,6,7,8,9]
    
    %r1 = 1 +randi(10-1,1,2)
    %Generate two locations of a row so they can exchange places
    r1=1+randi(y1-1,1,2); %1 row 2 columns, 4,5
    while r1(1)==r1(2) %If the two columns are equal keep generating
            r1=1+randi(y1-1,1,2);
    end
    %Let's say you 4 and 5
    % Element of row A with coordinates 1, 4 B = 4
    B=A(1,r1(1)); 
    % In row A make 4th element be the fifth element so 123556789
    A(1,r1(1))=A(1,r1(2));
    % In row A make 5th element be 4 so 123546789
    A(1,r1(2))=B;
    % This is a new row in matrix Y
    Y(z,:)=A;
end
YY = Y;

% This code takes in the population matrix and for each chromosome, it
% selects a random row, chooses 2 different elements (columns) in that row 
% randomly, and swaps those elements.