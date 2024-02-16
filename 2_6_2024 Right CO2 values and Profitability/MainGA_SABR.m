function [E_Tricycle_Route_SABR, E_Truck_Route_SABR, A, B] = MainGA_SABR(Data, depotCoordinates)
% Elis Cucka and Mikhail Smirnov

% Speed Area Based Routing Algorithm
% This code inputs the Data matrix of customer locations, separates the
% customers based on speed limit into A and B, adds a depot to each, 
% and executes the genetic algorithm to output the routes for
% both E-trucks and E-Tricycles.

% Population size
p=50;
% Number of pairs of chromosomes required for crossover
c=25; 
% Number of chromosomes required for mutation
m=25; 
% Total number of generations
tg=600;
 
[a, ~] = size(Data);


% Separates based on speed limit
 A = zeros(a/2,4); % E-tricycle (C_e-tricycle)
 B = zeros(a/2,4); % E-truck    (C_e-truck)
 j = 1;
 k = 1;
 for i = 1:a
     if Data(i,4) == 15
        A(k,1) = k;
        A(k,2:4) = Data(i,2:4);
        k = k+1;
     else
        B(j,1) = j;
        B(j,2:4) = Data(i,2:4);
        j = j+1;
     end
 end
 

% Adds depot to A matrix (e-tricycle)
                 % Customer locations            % Depot coordinates                         % Speed limit
A = addDepot(           A,                         depotCoordinates,                                15);

% Adds depot to B matrix (e-truck)
                 % Customer locations            % Depot coordinates                         % Speed limit
B = addDepot(           B,                         depotCoordinates,                                30);

[x y] = size(A);


nc = x; % number of customers ( + 2 depots)
Fc  = nc-1;   % First customer = depot
Lc = nc;      % Last customer = depot


  
P=population(p,nc); % Randomized solutions are returned after sending number of solutions needed and numbers of customers
% This would return a matrix 50 by 10
%Population1 = P;

%100 generations
for i=1:tg   
            %P(51:75,:) = crossover(array of solutions by customers, 50 by
            %10 and number of chromosomes
            P(p+1:p+c,:)=crossover(P,c);
            %Time for mutation 
            %P(76:100) will be mutation(50 by 10, 25)
            P(p+c+1:p+c+m,:)=mutation(P,m);
            %Now you have a fully 100 by 100 matrix with population
            %crossover and mutation
            
            % Take the first city and last city 1 and 5
            %Put first city in first column and last city in last column
            P = repair(P, Fc, Lc);
            
            %Evaluate the sums for all distances and return array of 100 numbers
            E=evaluation(P,A);
            
            % selection takes 100 by 100 matrix, 100 sum element row and 50
            % as population size 
            [P S]=selection(P,E,p);
            
            
            
            Mean(i) = sum(S)/p;
            Best(i)=S(1,1);
end

E_Tricycle_Route_SABR=P(1,:);
E_Tricycle_Distance_SABR=min(Best);

[x1 y1] = size(E_Tricycle_Route_SABR);



[x y] = size(B);
nc = x; % number of customers ( + 2 depots)
Fc  = nc-1;   % First customer = depot
Lc = nc;      % Last customer = depot

  
P=population(p,nc);
%Population = P;
for i=1:tg   
            P(p+1:p+c,:)=crossover(P,c);
            P(p+c+1:p+c+m,:)=mutation(P,m);
            P = repair(P, Fc, Lc);
            E=evaluation(P,B);
            [P S]=selection(P,E,p);
            Mean(i) = sum(S)/p;
            Best(i)=S(1,1);
end
 
E_Truck_Route_SABR = P(1,:);
%E_Truck_Distance_SABR = min(Best);


end