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

figure()

plot_WH(T, Tstar, V, t); % Note that Tstar(t) and V(t) almost overlap with each other. 
xlabel('t'); ylabel('cell population');
title('Numerical Simulation for Within-Host Subsystem');

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
