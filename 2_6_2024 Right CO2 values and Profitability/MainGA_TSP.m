function [Truck_Route_TSP, T] = MainGA_TSP(Data, depotCoordinates)
% Elis Cucka and Mikhail Smirnov

% Traveling Salesman Problem Genetic Algorithm
% This code inputs the Data matrix of customer locations for trucks only, 
% adds a depot, and executes the genetic algorithm to output the routes for
% trucks.

% Population size
p=50;
% Number of pairs of chromosomes required for crossover
c=25; 
% Number of chromosomes required for mutation
m=25; 
% Total number of generations
tg=1000;
    
 
% (This code does not need to separate e-trucks from e-tricycles with the
% speed limit since they are all the same vehicle)

% Adds depot to Data matrix
                 % Customer locations              % Depot coordinates                      % Speed limit
T = addDepot(      Data,                         depotCoordinates,                            30);

[x y] = size(T);
nc = x; % number of customers ( + 2 depots)

% Depot is last two rows
Fc  = nc-1;   % First customer = depot
Lc = nc;      % Last customer = depot


P=population(p,nc);
%Population = P;
for i=1:tg   
            P(p+1:p+c,:)=crossover(P,c);
            P(p+c+1:p+c+m,:)=mutation(P,m);
            P = repair(P, Fc, Lc);
            E=evaluation(P,T);
            [P S]=selection(P,E,p);
            Mean(i) = sum(S)/p;
            Best(i)=S(1,1);
end
 
Truck_Route_TSP = P(1,:);
%Truck_Distance_TSP = min(Best);


end