function test_WH()

clc


[t, T, ~, V] = Determ_WH_driver();
[T_SS, ~, V_SS] = const_WH();
%V_SS

% Test the interpolation gives non-negative answer: 
T_poly = interp1(t,T, 'linear','pp'); V_poly = interp1(t,V, 'linear','pp');
t_interp = (0 : 1 : 10 ^ 6);
V_1 = ppval(V_poly, t_interp); T_1 = ppval(T_poly, t_interp);
%sum(V_1 < 0)
%sum(T_1 < 0)

% Test that the interpolated value is close to the S.S. given t large
% enough:
t_end = 10 ^ 7;
V_end = ppval(V_poly, t_end); T_end = ppval(T_poly, t_end);
%V_end - V_SS
%T_end - T_SS


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debugged!
% Deterministic Within-Host Subsystem: 
function [t, T, Tstar, V] = Determ_WH(k, c, p, mu_c, delta_c, Lambda, T0, Tstar0, V0, t_end)

% I perform the log transformation to the W-H system: 
y0 = [log(T0); log(Tstar0); log(V0)];
tspan = [0, t_end];
opts = odeset('RelTol',1e-8,'AbsTol',1e-8);
[t, y] = ode15s(@(t,y) ode_sys(t, y, k, c, p, mu_c, delta_c, Lambda), tspan, y0, opts);
T_Log = y(: , 1); T = exp(T_Log);
Tstar_Log = y(: , 2); Tstar = exp(Tstar_Log);
V_Log = y(: , 3); V = exp(V_Log);


plot_WH(T, Tstar, V, t); % NOote that Tstar(t) and V(t) almost overlap with each other. 
xlabel('t'); ylabel('cell population');
title('Numerical Simulation (Deterministic) for Within-Host Subsystem');

end



function dydt = ode_sys(t, y, k, c, p, mu_c, delta_c, Lambda)

    dydt = [Lambda * exp(-y(1)) - k * exp(y(3)) - mu_c;
            k * exp(y(1) + y(3) - y(2)) - mu_c - delta_c;
            -c + p * exp(y(2) - y(3))];
end


function plot_WH(T, Tstar, V, t)
    plot(t, T, t, Tstar, t, V, 'LineWidth', 1.5); 
    legend('T(t)', 'T^{*}(t)', 'V(t)');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debugged!
function [t, T, Tstar, V] = Determ_WH_driver()

% The magnitute of parameters is drawn from  the research paper: 
% 'The Mechanisms for Within-Host Influenza Virus Control Affect 
% Model-Based Assessment and Prediction of Antiviral Treatment'
T0 = 10 ^ (8); %8
Tstar0 = 1;
V0 = 10 ^ (4);

p = 10 ^ (1);
c = 10 ^ (0);
k = 10 ^ (-7);
mu_c = 10 ^ (-1);
delta_c = 10 ^ (1);
Lambda = 1.1 * (mu_c * (mu_c + delta_c) * c) / (k * p);

%R_0 = T0 * k * p / (c * (mu_c + delta_c)) % Basic reproductive number

t_end = 10 ^ (8); % One can see that the W-H subsystem timescale is 
                    % much shorter than that of B-H subsystem
[t, T, Tstar, V] = Determ_WH(k, c, p, mu_c, delta_c, Lambda, T0, Tstar0, V0, t_end); 

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Debugged!
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
mu_c = 10 ^ (-1);
delta_c = 10 ^ (1);
Lambda = 1.1 * (mu_c * (mu_c + delta_c) * c) / (k * p);

% Compute the Steady States: 
T_SS = (mu_c + delta_c) * c / (p * k);
%Tstar_SS = ((Lambda * p * k) / (c * (mu_c + delta_c)) - mu_c) * c / (p * k);
%V_SS = ((Lambda * p * k) / (c * (mu_c + delta_c)) - mu_c) / k;
V_SS = (Lambda - mu_c * T_SS) / (k * T_SS);
Tstar_SS = c * V_SS / p;


end
