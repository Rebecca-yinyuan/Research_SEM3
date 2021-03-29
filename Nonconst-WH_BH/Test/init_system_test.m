function init_system_test(Lambda, mu, t0, C0)

global Sdie Idie Infect_timepoint infect_timelength Q C S I T_poly V_poly t_array
Sdie = []; Idie = []; Infect_timepoint = []; infect_timelength = []; 
Q = []; C =[]; S = []; S(1) = 90; I = []; I(1) = 10; t_array(1) = 0;

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

% Create the event queues, 'Q' and sort it: 
Q = [C, Sdie, Idie, T1];

C
Sdie
Idie
T1
end