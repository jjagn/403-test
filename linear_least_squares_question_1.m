%% LINEAR LEAST SQUARES
clear; clc; close all

%% LOAD DATA
data = load("LLS_data/LLS_Data_1.mat")
t = data.t
y = data.y

%% PLOT
plot(t, y, 'x')
hold on
title("LLS Tutorial Question 1")
xlabel("Time [s]")
ylabel("Position [m]")

%% COMPONENTS OF Y
num_theta = 2; % number of y components to identify

% Y = A*THETA where THETA = [theta_1; theta_2;... theta_n]
% for this question, y = theta_1*exp(t) + theta_2
% size of A matrix = rows x columns = number of datapoints x number of
% parameters to be identified

% predefine A matrix
A = zeros(length(y), num_theta)

% fill first row
A(:,1) = exp(t)

% fill second row
A(:,2) = ones(length(t),1)

warning_array = size(A) == [length(t) num_theta]; 
assert(warning_array(1), "not enough rows in A matrix, check t loaded properly")
assert(warning_array(2), "not enough columns in A matrix, check theta definitions")
%% SOLVE FOR THETA
theta = A\y
theta_1 = theta(1)
theta_2 = theta(2)
y_solved = theta_1*exp(t) + theta_2

plot(t, y_solved)
legend('Measured data', "Identified equation")
% HOW DOES THE MODEL STACK UP TO THE MEASURED DATA?
% mention:
%   y-intercept
%   general behaviour
%   how the model matches areas where the data is changing rapidly

%% FIND AVERAGE ERROR
average_absolute_error = sum(abs(y-y_solved))/length(y_solved)