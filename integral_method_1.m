%% INTEGRAL METHOD
clear; clc; close all

%% LOAD DATA
data = load("IM_data/IM_Data_1.mat")
t = data.t
U = data.U
C = data.C
C_ID_Sim = data.C_ID_Sim
t_Sim = data.t_Sim

delta_t = t(2)-t(1)
V = 4 % [L]

%% SET TRAPEZIUM INTERVAL
interval = 2 % larger interval can lose information if rapid changes are present, i.e. occuring inside the interval
n = length(t)

%% PLOT
plot(t, [C U], 'x')
hold on
xlabel("Time [m]")

X = zeros(n,1);
Y = zeros(n,1);

%% MAIN LOOP
for i = 1:n-interval
    % trapezium expansion -> integral(a,b,X) = delta_t/2*(Xa + Xb + 2*(Xa+1
    % Xa+2... Xb-2
    % sum the ends of the trapezium and then add everything in between
    C_trapezium = (0.5*delta_t)*(C(i) + C(i+interval) + 2*sum(C(i+1:i+interval-1)));

    C_difference = C(i+interval) - C(i);

    U_trapezium = (0.5*delta_t)*(U(i) + U(i+interval) + 2*sum(U(i+1:i+interval-1)));

    X(i,1) = -C_trapezium;
    Y(i,1) = C_difference - U_trapezium/V;
end

% K = inv(X'*X)*X'*Y
K = X\Y

%% PLOT FORWARD SIM MODEL
plot(t_Sim, C_ID_Sim)
legend("Creatinine concentration [mmol/L]", "Creatinine inputs [mmol/min]", "Simulated creatinine concentration [mmol/L]")