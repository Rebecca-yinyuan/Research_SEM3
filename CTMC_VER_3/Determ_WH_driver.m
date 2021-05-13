%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debugged!
function [t, T, Tstar, V] = Determ_WH_driver()

% The magnitute of parameters is drawn from  the research paper: 
% 'The Mechanisms for Within-Host Influenza Virus Control Affect 
% Model-Based Assessment and Prediction of Antiviral Treatment'

set(0,'defaultAxesFontSize',30); set(gca,'FontSize',30);
set(0, 'DefaultLineLineWidth', 1.5);

T0 = 10 ^ (8); 
Tstar0 = 1;
V0 = 10 ^ (6);

p = 10 ^ (1);
c = 10 ^ (0);
k = 10 ^ (-7);
mu_c = 10 ^ (-1);
delta_c = 10 ^ (1);
Lambda = 1.1 * (mu_c * (mu_c + delta_c) * c) / (k * p);

%R_0 = T0 * k * p / (c * (mu_c + delta_c)); % Basic reproductive number

t_end = 10 ^ 7; % One can see that the W-H subsystem timescale is 
                    % much shorter than that of B-H subsystem
[t, T, Tstar, V] = Determ_WH(k, c, p, mu_c, delta_c, Lambda, T0, Tstar0, V0, t_end); 

end