%% INTEGRAL METHOD
clear; clc; close all

%% LOAD DATA
data = load("IM_data/IM_Data_2.mat")
t = data.t
U = data.U
G = data.G
Q = data.Q
t_sim = data.t_Sim
G_ID_Sim = data.G_ID_Sim

GQ = G.*Q;

p = 0.025;

delta_t = t(2)-t(1)
V = 4 % [L]

%% SET TRAPEZIUM INTERVAL
trapezium_interval = 3 % larger interval can lose information if rapid changes are present, i.e. occuring inside the interval
n = length(t)

%% PLOT
plot(t, [G U], 'x')
hold on

legend("Creatinine concentration", "Creatinine inputs")

X = zeros(n,1);
Y = zeros(n,1);

%% MAIN LOOP
for i = 1:n-trapezium_interval
    % sum the ends of the trapezium and then add everything in between

    G_trapezium = (0.5*delta_t)*(G(i) + G(i+trapezium_interval) + p*2*sum(G(i+1:i+trapezium_interval-1)));

    G_difference = G(i+trapezium_interval) - G(i);

    U_trapezium = (0.5*delta_t)*(U(i) + U(i+trapezium_interval) + 2*sum(U(i+1:i+trapezium_interval-1)))/V;

    GQ_trapezium = (0.5*delta_t)*(GQ(i) + GQ(i+trapezium_interval) + 2*sum(GQ(i+1:i+trapezium_interval-1)));


    X(i,1) = -GQ_trapezium;
    Y(i,1) = -G_trapezium + G_difference + U_trapezium;
end

% K = inv(X'*X)*X'*Y
SI = X\Y

%% PLOT FORWARD SIM
hold on
plot(t_sim, G_ID_Sim)