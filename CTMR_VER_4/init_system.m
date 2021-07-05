%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debugged!
function init_system(Lambda, mu, t0, C0)

global Sdie Idie Infect_timepoint infect_timelength Q C S I Theta V_poly T_poly V_AVE T_AVE V_SS T_SS


% The waiting time for 1 susceptible to enter the population: 
u1 = rand;
T1 = -log(u1) / Lambda;

% Create an array, 'Sdie', to store the waiting time for each susceptible
% to die:
for i = 1 : S(length(S))
    u2 = rand;
    Sdie(i) = -log(u2) / mu;
end

% Create an array, 'Idie', to store the waiting time for each infectious
% to die:
for i = 1 : I(length(I))
    u3 = rand;
    Idie(i) = -log(u3) / mu;
end

% Create an array, 'Infect_timepoint', to record the time stamp at which
% each infectious person gets infectious:
for i = 1 : I(length(I))
    Infect_timepoint(i) = t0;
end

% Create another array, 'infect_timelength', to record the time length for
% which each infectious person stays infectious:
for i = 1 : I(length(I))
    infect_timelength(i) = t0 - t0;
end

% Create an array, 'C', to record the waiting time for each infectious
% individual to interact with a susceptible person: 
for i = 1 : I(length(I))
    u4 = rand;
    C(i) = -log(u4) / (C0 * S(length(S)));
end

% Create the event queues, 'Q': 
Q = [C, Sdie, Idie, T1];

% Initialise Theta at t = 0:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V_sum = 0; T_sum = 0; VT_sum = 0; % initialisation
for i = 1 : I(length(I))
    V_sum = V_sum + ppval(V_poly, 0);
    T_sum = T_sum + ppval(T_poly, 0);
    VT_sum = VT_sum + ppval(V_poly, 0) * ppval(T_poly, 0);
end
for i = 1 : S(length(S))
    T_sum = T_sum + Lambda + Lambda / mu;
end

V_AVE(1) = V_sum / (S(length(S)) + I(length(I)));
T_AVE(1) = T_sum / (S(length(S)) + I(length(I)));
Theta(1) = VT_sum / (V_AVE(1) * T_AVE(1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST: CONST. WH SUBSYSTEM:
%V_AVE(1) = V_SS; T_AVE(1) = T_SS;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end