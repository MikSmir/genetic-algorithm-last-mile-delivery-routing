function [YY1 YY2]=selection(P1,B,p)
% P1 = population
% B = fitness values [1 x n]
% p = population size
%return location of max of B r1, c1 that can be 1,50
[r1 c1]=find(B==max(B));
% Whole row of Y1 will be whole row of 
Y1(1,:)=P1(max(c1),:); % Keep the best first, This is the smallest distance row in P1
Fn(1,1)=1/B(1,max(c1)); % best fitness value, best distance value stored in Fn 
% Determine total fitness for the population
C=sum(B); % Sum of all distance (which are all 1/distance)
% Determine selection probability
D=B/C; %all the summs divided by the sum of sums, 100 values
% Determine cumulative probability 
E= cumsum(D);
% Generate a vector constaining normalised random numbers
N=rand(1);
d1=1;
d2=1;
while d2 <= p-1
    if N <= E(d1)
       Y1(d2+1,:)=P1(d1,:); 
       Fn(1,d2+1)=1/B(1,d1);
       N=rand(1);
       d2 = d2 +1; 
       d1=1;
     else
        d1 = d1 + 1;
    end
end
YY1=Y1; 
YY2=Fn; % returning smallest distance value