function Multiscale_hybrid_1()

% For 'Multiscale_hybrid_1', we assume that the within-host subsystem has
% reached its steady states, i.e. we have constant W-H subsystem. 

clc
clear

[~, ~, T_realtime, infect_timepoint] = CTMC_BH_driver(); 
% Note that 'infect_timepoint' is an array recording the timestamp where a
% new infection happens. 

% Parameter of interest in terms of real time, t: 
THETA_I = zeros(size(T_realtime)) * nan; 

% We firstly assume that our Within-Host subsystem is constant:
[T_SS, ~, V_SS] = const_WH();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Interpolation to obatain two piecewise polynomials: 
%[t_WH, T, ~, V] = Determ_WH_driver();
%T_poly = spline(t_WH,T); V_poly = spline(t_WH,V); %%% Try linear interpolation as well %%%!!!!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i = 1 : length(T_realtime)
    
    % Record the infectious time length (note that only non-negative
    % numericla entries are corresponeded to the infectious groups: 
    infect_length = ones(length(infect_timepoint), 1) * T_realtime(i) - infect_timepoint';
    
    % Initialisation: 
    sum_LHS = 0;
    T_sum = 0;
    V_sum = 0;
    num_infectious = 0;
    
    for j = 1 : length(infect_length)
        if infect_length(j) >= 0 % Only those entries make sense
            num_infectious = num_infectious + 1;
            Vj = V_SS; 
            Tj = T_SS;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Vj = ppval(V_poly, infect_length(j));
            %Tj = ppval(T_poly, infect_length(j));
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            sum_LHS = sum_LHS + Vj * Tj;
            
            T_sum = T_sum + Tj;
            V_sum = V_sum + Vj;
        end
    end
    
    T_ave = T_sum / num_infectious;
    V_ave = V_sum / num_infectious;
    
    
    THETA_I(i) = sum_LHS / (T_ave * V_ave);
end

plot(T_realtime, THETA_I, 'LineWidth', 1.2); hold on

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constant Within-Host Subsystem: 
function [T_SS, Tstar_SS, V_SS] = const_WH()

% One can run 'Determ_WH_driver.m' to check that under these values, our
% Within-Host subsystem arrives at a non-virus free equilibrium. 
p = 10 ^ (1);
c = 10 ^ (0);
k = 10 ^ (-7);
Lambda = 10 ^ (10);
mu_c = 10 ^ (-1);
delta_c = 10 ^ (1);

T_SS = (mu_c + delta_c) * c / (p * k);
Tstar_SS = ((Lambda * p * k) / (c * (mu_c + delta_c)) - mu_c) * c / (p * k);
V_SS = ((Lambda * p * k) / (c * (mu_c + delta_c)) - mu_c) / k;


end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Between-Host Subsystem (Note that transmission coefficient is proportinoal 
% to viral load times a contant, beta0):
function [S, I, t, infect_timepoint] = CTMC_BH(mu, Lambda, t_end, population, V_SS)

% CTMS_BH simulation

S = []; S(1) = population - 10;
I = []; I(1) = population - S(1);
t = []; t(1) = 0;
infect_timepoint = [];
for i = 1 : I(1)
    infect_timepoint(i) = 0;
end
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
        infect_timepoint(I(1) + index) = t(index); 
    else
        infect_timepoint(I(1) + index) = nan;
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Delta_t = TimeStepSize(lambda)

u1 = rand;
Delta_t = -log(u1) / lambda;

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [S, I, infectious_increase, infectious_dies] = EventHappen(lambda, beta, mu, S, I, index)

u2 = rand;
p1 = beta * S(index) * I(index) /lambda;
p2 = mu * S(index) / lambda; 
p3 = mu * I(index) / lambda ;

infectious_increase = 0;
infectious_dies = 0;

if u2 >= 0 && u2 < p1 % One person gets infectious
    S(index + 1) = S(index) - 1;
    I(index + 1) = I(index) + 1;
    infectious_increase = 1;
elseif u2 >= p1 && u2 < p1 + p2 % One susceptible dies
    S(index + 1) = S(index) - 1;
    I(index + 1) = I(index);
elseif u2 >= p1 + p2 && u2 < p1 + p2 + p3 % One infectious dies
    S(index + 1) = S(index);
    I(index + 1) = I(index) - 1;
    infectious_dies = 1; 
else % One susceptible enters the population
    S(index + 1) = S(index) + 1;
    I(index + 1) = I(index);
end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_SI(S, I, t)
    plot(t, S,'b', t, I, 'r', 'LineWidth', 1.5); hold on;
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [S, I, t, infect_timepoint] = CTMC_BH_driver()

% Initialise the parameters for the Between-Host system:
mu = 10 ^ (-5);
Lambda = 10 ^ (-5);
%t_end = 300; population = 10 ^ (5);
population = 10 ^ (3); t_end = 20;
[~, ~, V_SS] = const_WH();

[S, I, t, infect_timepoint] = CTMC_BH(mu, Lambda, t_end, population, V_SS);

end