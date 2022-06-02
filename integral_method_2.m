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
interval = 3 % larger interval can lose information if rapid changes are present, i.e. occuring inside the interval
n = length(t)

%% PLOT
plot(t, [G U], 'x')
hold on

X = zeros(n,1);
Y = zeros(n,1);

%% MAIN LOOP
for i = 1:n-interval
    % sum the ends of the trapezium and then add everything in between
    % define trapeziums

    % original equation is:
    % G_dot = -p*G + U/V - SI*(G*Q)
    % rearrange for SI and GQ
    % SI(GQ) = -p*G + U/V - G_dot

    G_trapezium = (0.5*delta_t)*(G(i) + G(i+interval) + 2*sum(G(i+1:i+interval-1)));
    U_trapezium = (0.5*delta_t)*(U(i) + U(i+interval) + 2*sum(U(i+1:i+interval-1)));
    GQ_trapezium = (0.5*delta_t)*(GQ(i) + GQ(i+interval) + 2*sum(GQ(i+1:i+interval-1)));

    % difference between current value and next value (depending on
    % interval) gives derivative
    G_difference = G(i+interval) - G(i);

    % fill X and Y matrices, rearrange left side (X) for unknown qty, Y
    % with everything else
    X(i) = GQ_trapezium;
    Y(i) = -G_difference - p*G_trapezium + U_trapezium/V; % makes more sense this way
end

% this is pseudoinverse, should give same answer,
% backslash is more numerically stable and faster acc to matlab
SI = inv(X'*X)*X'*Y
SI = X\Y

%% PLOT FORWARD SIM
hold on
plot(t_sim, G_ID_Sim)
legend("Blood glucose concentration [mmol/L]", "Glucose inputs [mmol/min]", "Simulated blood glucose concentration [mmol/L]")