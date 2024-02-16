%Generates a number of customers by number of solutions
function Y=population(n,nc)
% n = number of solutions
% nc = number of customers
B=zeros(n,nc); %Return zeros matrix 50 by 10
for j=1:n      %from one to 50
    A=1:1:nc;   %A = 1:1:10 creates a regularly-spaced vector x using 1 (the middle integer) as the increment between elements
    %It is basically [1,2,3,4,5,6,7,8,9,10]
    [x y]=size(A); %x = 1, y = 10 - how many rows and columns
    %creates a whole randomized row for matrix A
    for i = 1:nc %from 1 to 10
        r = randi(y); %returns a pseudorandom scalar integer between 1 and 10, let's say 3; let's say 3
        B(j,i)=A(r); % B(1,1) = A(3) = 3; B(1,2) = 4.....
        A(:,r) = []; %whole row number 3 is empty / 3rd row of matrix A
        [x y]=size(A); % x = 1, y = 9 [1,2,4,5,6,7,8,9,10]; x = 1, y = 8 [1,2,5,6,7,8,9,10]
    end
end
Y=B;


% This code generates a matrix of size n by nc (# of solutions by # of
% customers). It uses vector A to randomize each entry of matrix B based on
% a number chosen within the range of customers. It also removes that
% chosen element of A so that the same entry is not randomly chosen again,
% to avoid duplicate customers (numbers) in each row of B, eventually 
% emptying out A. The decreasing size of A gets updated each iteration
% after an entry of B is randomized.