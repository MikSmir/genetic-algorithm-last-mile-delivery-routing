

figure(1)
hold on
plot(CO2_SABR_Array)
plot(CO2_CABR_Array)
plot(Truck_CO2_TSP)
title('SABR, CABR, and Diesel Truck TSP CO2 Emissions')
xlabel('Iteration', 'Interpreter','latex')
ylabel('CO2 Emissions $[kgCO_2e]$', 'Interpreter','latex')
legend('SABR (E-Truck + E-Tricycle)', 'CABR (E-Truck + E-Tricycle)', 'Diesel Truck TSP', 'Interpreter','latex');
ylim([0 350])
hold off

figure(2)
hold on
plot(Total_Penalty_SABR)
plot(Total_Penalty_CABR)
plot(Total_Penalty_CO2_TSP)
title('Penalty of CO2 Emissions in Euros for SABR, CABR, and Diesel Truck TSP')
xlabel('Iteration', 'Interpreter','latex')
ylabel('CO2 Penalty (Euros)', 'Interpreter','latex')
legend('SABR (E-Truck + E-Tricycle)', 'CABR (E-Truck + E-Tricycle)', 'Diesel Truck TSP', 'Interpreter','latex');
ylim([0 35])
hold off

figure(3)
hold on
plot(Profitability_SABR)
plot(Profitability_CABR)
title('Profitability of CO2 Emission in Euros for SABR, CABR, and Diesel Truck TSP')
xlabel('Iteration', 'Interpreter','latex')
ylabel('Profitability (Euros)', 'Interpreter','latex')
legend('SABR (Diesel Truck Penalty - SABR Penalty)', 'CABR (Diesel Truck Penalty - CABR Penalty)', 'Interpreter','latex');
ylim([0 50])
hold off

