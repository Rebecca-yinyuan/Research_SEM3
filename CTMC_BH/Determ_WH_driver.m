function [t, T, Tstar, V] = Determ_WH_driver()

% The magnitute of parameters is drawn from  the research paper: 
% 'The Mechanisms for Within-Host Influenza Virus Control Affect 
% Model-Based Assessment and Prediction of Antiviral Treatment'
T0 = 10 ^ (8);
Tstar0 = 1;
V0 = 10 ^ (4);
p = 10 ^ (1);
c = 10 ^ (0);
k = 10 ^ (-7);
Lambda = 10 ^ (-1);
mu_c = 10 ^ (-1);
delta_c = 10 ^ (1);

t_end = 10 ^ (0.6); % One can see that the W-H subsystem timescale is 
                    % much shorter than that of B-H subsystem
[t, T, Tstar, V] = Determ_WH(k, c, p, mu_c, delta_c, Lambda, T0, Tstar0, V0, t_end); 

end