%% LINEAR LEAST SQUARES
clear; clc; close all

%% LOAD DATA
data = load("LLS_data/LLS_Data_2.mat")
t = data.t
y = data.y

%% PLOT
plot(t, y, 'x')
hold on

%% COMPONENTS OF Y
num_theta = 3; % number of y components to identify

% Y = A*THETA where THETA = [theta_1; theta_2;... theta_n]

% fill first row
A(:,1) = sin(2*pi*(4/pi).*t) 

% fill second row
A(:,2) = t

% fill third row
A(:, 3) = ones(length(t),1)

warning_array = size(A) == [length(t) num_theta]; 
assert(warning_array(1), "not enough rows in A matrix, check t loaded properly")
assert(warning_array(2), 'not enough columns in A matrix, check theta definitions')

%% SOLVE FOR THETA
theta = A\y
theta_1 = theta(1)
theta_2 = theta(2)
theta_3 = theta(3)
y_solved = theta_1*sin(2*pi*(4/pi).*t) + theta_2*t + theta_3

plot(t, y_solved)
legend('Measured data', "Identified equation")

%% FIND AVERAGE ERROR
average_absolute_error = sum(abs(y-y_solved))/length(y_solved)