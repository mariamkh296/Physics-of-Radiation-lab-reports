clear; clc; close all;

%% Load the Excel file
data = readtable("D:\Space\Space 3rd term\Radiation lab\lab2.xlsx");

%% Extract variables from table
Vin = data{:,1};
Tmv = data{:,2};
Veff = data{:,3};
Tdeg = data{:,4};
countrate = data{:,5};

%% Separate the two Vin conditions
v1 = abs(Vin - 41.65) < 0.01;  % Using tolerance for floating point comparison
v2 = abs(Vin - 42.00) < 0.01;

%% Group 1 (Vin = 41.65 V)
T1 = Tdeg(v1);
Tmv1 = Tmv(v1);
CR1 = countrate(v1);
Veff1 = Veff(v1);

%% Group 2 (Vin = 42.00 V)
T2 = Tdeg(v2);
Tmv2 = Tmv(v2);
CR2 = countrate(v2);
Veff2 = Veff(v2);

%% Plot 1: Count Rate vs Temperature (°C)
figure('Position', [100, 100, 800, 600]);
plot(T1, CR1, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'Vin = 41.65 V'); 
hold on;
plot(T2, CR2, '-s', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'Vin = 42.00 V');

% Fit linear trends
if length(T1) > 1
    p1 = polyfit(T1, CR1, 1);
    T1_fit = linspace(min(T1), max(T1), 100);
    CR1_fit = polyval(p1, T1_fit);
    plot(T1_fit, CR1_fit, '--', 'LineWidth', 1.5, 'Color', [0.8 0.8 0.8], ...
         'DisplayName', sprintf('Slope: %.2f counts/°C', p1(1)));
end

if length(T2) > 1
    p2 = polyfit(T2, CR2, 1);
    T2_fit = linspace(min(T2), max(T2), 100);
    CR2_fit = polyval(p2, T2_fit);
    plot(T2_fit, CR2_fit, '--', 'LineWidth', 1.5, 'Color', [0.6 0.6 0.6], ...
         'DisplayName', sprintf('Slope: %.2f counts/°C', p2(1)));
end

xlabel('Temperature (°C)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Count Rate (counts/s)', 'FontSize', 12, 'FontWeight', 'bold');
title('Count Rate vs Temperature at Two Input Voltages', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 10);
grid on;
set(gca, 'FontSize', 11);

%% Plot 2: Count Rate vs T (mV/°C)
figure('Position', [150, 150, 800, 600]);
plot(Tmv1, CR1, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'Vin = 41.65 V'); 
hold on;
plot(Tmv2, CR2, '-s', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'Vin = 42.00 V');

xlabel('Compensation Temperature (mV/°C)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Count Rate (counts/s)', 'FontSize', 12, 'FontWeight', 'bold');
title('Count Rate vs Compensation Temperature', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 10);
grid on;
set(gca, 'FontSize', 11);

