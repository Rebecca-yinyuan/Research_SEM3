%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constant Within-Host Subsystem: 
function [T_SS, Tstar_SS, V_SS] = const_WH()

% This function returns the non-virus-free steady state, 
% '(T_SS, Tstar_SS, V_SS)', of the within-host subsytem.
% 
% One can run 'Determ_WH_driver.m' to check that under these values, our
% Within-Host subsystem arrives at a non-virus free equilibrium. 

% Parameter Initialisation:
p = 10 ^ (1);
c = 10 ^ (0);
k = 10 ^ (-7);
Lambda = 10 ^ (10);
mu_c = 10 ^ (-1);
delta_c = 10 ^ (1);

% Compute the Steady States: 
T_SS = (mu_c + delta_c) * c / (p * k);
Tstar_SS = ((Lambda * p * k) / (c * (mu_c + delta_c)) - mu_c) * c / (p * k);
V_SS = ((Lambda * p * k) / (c * (mu_c + delta_c)) - mu_c) / k;

end