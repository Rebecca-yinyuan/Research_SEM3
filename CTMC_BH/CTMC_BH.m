function [S, I, t, infect_timepoint] = CTMC_BH(beta, mu, Sigma, t_end, population)

% CTMS_BH simulation

S = []; S(1) = population - 10;
I = []; I(1) = population - S(1);
t = []; t(1) = 0;
infect_timepoint = [];
index = 1;

while t(index) <= t_end
    lambda = beta * I(index) * S(index) + mu * S(index) + mu * I(index) + Sigma;
    Delta_t = TimeStepSize(lambda); 
    t(index + 1) = t(index) + Delta_t;
    
    [S, I, infectious_increase] = EventHappen(lambda, beta, mu, S, I, index);
    if infectious_increase == 1
        infect_timepoint(index) = t(index); % records the time stamp where a new infection happens
    else
        infect_timepoint(index) = nan;
    end

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


function Delta_t = TimeStepSize(lambda)

u1 = rand;
Delta_t = -log(u1) / lambda;

end


function [S, I, infectious_increase] = EventHappen(lambda, beta, mu, S, I, index)

u2 = rand;
p1 = beta * S(index) * I(index) /lambda; %%%%%% initially instead of '/lambda', I write '* Delta_t'
p2 = mu * S(index) / lambda; 
p3 = mu * I(index) / lambda ;

infectious_increase = 0;

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
else % One susceptible enters the population
    S(index + 1) = S(index) + 1;
    I(index + 1) = I(index);
end

end


function plot_SI(S, I, t)
    plot(t, S,'b', t, I, 'r', 'LineWidth', 1.5); hold on;
end