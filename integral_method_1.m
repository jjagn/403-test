%% INTEGRAL METHOD
clear; clc; close all

%% LOAD DATA
data = load("IM_data/IM_Data_1.mat")
t = data.t
U = data.U
C = data.C

delta_t = t(2)-t(1)
V = 4 % [L]

%% SET TRAPEZIUM INTERVAL
trapezium_interval = 2 % larger interval can lose information if rapid changes are present, i.e. occuring inside the interval
n = length(t)

%% PLOT
plot(t, [C U], 'x')
hold on

legend("Creatinine concentration", "Creatinine inputs")

X = zeros(n,1);
Y = zeros(n,1);

%% MAIN LOOP
for i = 1:n-trapezium_interval
    % sum the ends of the trapezium and then add everything in between
    C_trapezium = (0.5*delta_t*trapezium_interval)*(C(i) + C(i+trapezium_interval) + 2*sum(C(i+1:i+trapezium_interval-1)));

    C_difference = C(i+trapezium_interval) - C(i);

    U_trapezium = (0.5*delta_t*trapezium_interval)*(U(i) + U(i+trapezium_interval) + 2*sum(U(i+1:i+trapezium_interval-1)))/V;

    X(i,1) = -C_trapezium;
    Y(i,1) = C_difference - U_trapezium;
end

% K = inv(X'*X)*X'*Y
K = X\Y