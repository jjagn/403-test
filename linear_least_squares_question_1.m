%% LINEAR LEAST SQUARES
clear; clc; close all

%% LOAD DATA
data = load("LLS_data/LLS_Data_1.mat")
t = data.t
y = data.y

%% PLOT
plot(t, y, 'x')
hold on

%% COMPONENTS OF Y
num_theta = 2; % number of y components to identify

% Y = A*THETA where THETA = [theta_1; theta_2;... theta_n]

% predefine A matrix
A = zeros(length(y), num_theta)

% fill first row
A(:,1) = exp(t)

% fill second row
A(:,2) = ones(length(t),1)

%% SOLVE FOR THETA
theta = A\y
theta_1 = theta(1)
theta_2 = theta(2)
y_solved = theta_1*exp(t) + theta_2

plot(t, y_solved)
legend('Measured data', "Identified equation")

%% FIND AVERAGE ERROR
average_absolute_error = sum(abs(y-y_solved))/length(y_solved)