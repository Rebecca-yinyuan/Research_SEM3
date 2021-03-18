function [S, I, t, infect_timepoint] = CTMC_BH_driver()

%clc
%clear

% Initialise the parameters for the Between-Host system:
mu = 10 ^ (-5);
Lambda = 10 ^ (-5);
beta = 10 ^ (-5);
% t_end = 30; population = 10 ^ (5);
population = 10 ^ (3); t_end = 300;


% CODES FOR CHECKING THE VALIDITY OF CTMC ALGORITHM
%----------------------------------------------------------------
%figure(1);
% CTMC B-H system simulation:
%repetition = 50;
%for i = 1 : repetition
%    [S, I, t] = CTMC_BH(beta, mu, Lambda, t_end, population);
%end

% Deterministic B-H system simulation:
%Determ_BH(beta, mu, Lambda, t_end, population);

%xlabel('t'); ylabel('population');
%title('CTMC Simulation for Between-Host Subsystem');
%----------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CODES FOR 'Multiscale_hybrid.m' 
[S, I, t, infect_timepoint] = CTMC_BH(beta, mu, Lambda, t_end, population);


end