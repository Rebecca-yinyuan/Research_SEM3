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