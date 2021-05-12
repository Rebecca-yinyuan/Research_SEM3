%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debugged!
%
% Note that this function assumes that 'Sdie' = [], 'Idie' = [], 'C' = [], 
% and 'Q' = [].
function regenerate_Q(Lambda, mu, C0)

global Sdie Idie Q C S I flag T1 flag_E1

flag_E1 = 0;

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

% Create an array, 'C', to record the waiting time for each infectious
% individual to interact with a susceptible person: 
for i = 1 : I(length(I))
    u4 = rand;
    C(i) = -log(u4) / (C0 * S(length(S)));
end


% Create the event queues, 'Q': 
if flag == 1   % # susceptible != 0
    Q = [C, Sdie, Idie, T1];
else    % # susceptible = 0
    Q = [Idie, T1];
end

end