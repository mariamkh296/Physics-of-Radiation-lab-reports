% Simple CSV plotting example
clear; close all; clc;

% Read CSV file
data = readtable("D:\Space\Space 3rd term\Radiation lab\physics of radiation lab 1.xlsx");

x= data{:,1}
y= data{:,2}

% Basic line plot of all numeric columns
figure;
plot(x,y)
title('Time versus Counting rate graph');
xlabel('Time Theshold');
ylabel('Counting rate');
grid on;



