
Truck_TSP_Matrix = [2 2; 2 24; 32 14]
for i = 1:2
    [x, y] = AStar(Truck_TSP_Matrix(i, 1), Truck_TSP_Matrix(i, 2), Truck_TSP_Matrix(i+1, 1), Truck_TSP_Matrix(i+1, 2), i, 30, 10, 2);
end