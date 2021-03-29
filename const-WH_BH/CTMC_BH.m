%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Between-Host Subsystem (Note that transmission coefficient is proportinoal 
% to viral load times a contant, beta0):
function [S, I, t, infect_timepoint] = CTMC_BH(mu, Lambda, t_end, population, V_SS)

% CTMS_BH simulation

S = []; S(1) = population - 10;
I = []; I(1) = population - S(1);
t = []; t(1) = 0;
infect_timepoint = [];
index = 1;

% We assume that beta = beta0 * V_SS as presented in the research paper
beta0 = 1 / (10 ^ 13);
beta = beta0 * V_SS; % Link the Between Host subsystem to the Within Host subsystem

while t(index) <= t_end
    lambda = beta * I(index) * S(index) + mu * S(index) + mu * I(index) + Lambda;
    Delta_t = TimeStepSize(lambda);
    t(index + 1) = t(index) + Delta_t;
    
    [S, I, infectious_increase, infectious_dies] = EventHappen(lambda, beta, mu, S, I, index);
    
    % records the time stamp where a new infection happens
    if infectious_increase == 1
        infect_timepoint(index) = t(index); 
    else
        infect_timepoint(index) = nan;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The variable, 'infectious_dies', records the time stamp where an infectius individual decays(/dies)
    % However, how shall we decide which infectious person to be
    % removed from the system????????????????????????????????????????????
    % The below codes randomly select one infectious individual and remote
    % it from the system.
    if infectious_dies == 1
        infectious_people = find(infect_timepoint >= 0); % Indecies of infectious people
        rand_die = randi([1, length(infectious_people)], 1, 1);
        infect_timepoint(infectious_people(rand_die)) = nan;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    index = index + 1;
 
end

if t(length(t)) > t_end
    t = t(1 : length(t) - 1);
    S = S(1 : length(S) - 1);
    I = I(1 : length(I) - 1);
end

%plot_SI(S, I, t);
%legend('S_{CTMC}', 'I_{CTMC}');


end
