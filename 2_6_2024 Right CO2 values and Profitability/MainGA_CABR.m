function [E_Tricycle_Route_CABR, E_Truck_Route_CABR, Cluster1, Cluster2] = MainGA_CABR(Data, depotCoordinates)
% Elis Cucka and Mikhail Smirnov

% Cluster Area Based Routing Algorithm
% This code inputs the Data matrix of customer locations, separates the
% customers into Cluster1 and Cluster2, adds a depot to each, 
% and executes the genetic algorithm to output the routes for both 
% E-trucks and E-Tricycles.

% Cluster1 = e-tricycles, Cluster2 = e-trucks

% Population size
p=50;
% Number of pairs of chromosomes required for crossover
c=25; 
% Number of chromosomes required for mutation
m=25; 
% Total number of generations
tg=600;


DataCoordinates = [Data(:,2),Data(:,3)];

% k-means clustering
[idx, C] = kmeans(DataCoordinates,2);

size(DataCoordinates(idx == 1,1),1);

% Customer nodes
y = (1:size(DataCoordinates(idx == 1,1),1))';
z = (1:size(DataCoordinates(idx == 2,1),1))';

% Speed for Cluster1 and Cluster2
speedLimit1 = 15 * ones(length(y), 1); % Cluster 1 speed (e-tricycle)
speedLimit2 = 30 * ones(length(z), 1); % Cluster 2 speed (e-truck)

% Creates the full Cluster1 and Cluster2 matrices
Cluster1 = [y DataCoordinates(idx == 1,1) DataCoordinates(idx == 1,2) speedLimit1];
Cluster2 = [z DataCoordinates(idx == 2,1) DataCoordinates(idx == 2,2) speedLimit2];

% Note: There is no need to separate the e-tricycles and e-trucks
% like in SABR since they are already separated by the two clusters.


% Adds depot to Cluster1 matrix (e-tricycle)
                      % Customer locations           % Depot coordinates                         % Speed limit
Cluster1 = addDepot(      Cluster1,                    depotCoordinates,                               15);

% Adds depot to Cluster2 matrix (e-truck)
                      % Customer locations           % Depot coordinates                         % Speed limit
Cluster2 = addDepot(      Cluster2,                    depotCoordinates,                               30);

% Assigns first and last customers as depot for Cluster1
[x1, y1] = size(Cluster1);
nc1 = x1; % number of customers of Cluster1 ( + 2 depots)
Fc1  = nc1-1;   % First customer of Cluster1 = depot
Lc1 = nc1;      % Last customer of Cluster1 = depot
  
P=population(p,nc1); %Randomized solutions are returned after sending number of solutions needed and numbers of customes
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
            P = repair(P, Fc1, Lc1);
            
            %Evaluate the sums for all distances and return array of 100 numbers
            E=evaluation(P,Cluster1);
            
            % selection takes 100 by 100 matrix, 100 sum element row and 50
            % as population size 
            [P S]=selection(P,E,p);  
            Mean(i) = sum(S)/p;
            Best(i)=S(1,1);

end

E_Tricycle_Route_CABR=P(1,:);
%E_Tricycle_Distance_CABR=min(Best);

[xx1 yy1] = size(E_Tricycle_Route_CABR);


% Assigns first and last customers as depot for Cluster2
[x2 y2] = size(Cluster2);
nc2 = x2; % number of customers of Cluster2 ( + 2 depots)
Fc2  = nc2-1;   % First customer of Cluster2 = depot
Lc2 = nc2;      % Last customer of Cluster2 = depot


P=population(p,nc2);
%Population = P;
for i=1:tg   
            P(p+1:p+c,:)=crossover(P,c);
            P(p+c+1:p+c+m,:)=mutation(P,m);
            P = repair(P, Fc2, Lc2);
            E=evaluation(P,Cluster2);
            [P S]=selection(P,E,p);
            Mean(i) = sum(S)/p;
            Best(i)=S(1,1);
%             plot(Mean(:),'r.'); drawnow
%             hold on
%             plot(Best(:),'b.'); drawnow
end
 
E_Truck_Route_CABR = P(1,:);
%E_Truck_Distance_CABR = min(Best);

end