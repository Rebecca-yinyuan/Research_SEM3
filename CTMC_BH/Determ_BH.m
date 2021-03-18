function Determ_BH(beta, mu, Lambda, t_end, population)

% I perform the log transformation to the B-H system: 
y0 = [log(population - 10); log(10)];
tspan = [0, t_end];
% Some extra condition to make sure that the ode solver produces
% smooth-enough solution: 
opts = odeset('RelTol',1e-8,'AbsTol',1e-8);
[t, y] = ode15s(@(t,y) ode_sys(t, y, Lambda, mu, beta), tspan, y0, opts);
S_Log = y(: , 1); S = exp(S_Log);
I_Log = y(: , 2); I = exp(I_Log);

plot_SI(S, I, t, Lambda, mu, beta);

end


function dydt = ode_sys(t, y, Lambda, mu, beta)

    dydt = [Lambda * exp(-y(1)) - beta * exp(y(2)) - mu;
            beta * exp(y(1)) - mu];
                   
end


function plot_SI(S, I, t, Lambda, mu, beta)
    plot(t, S,'k', t, I, 'k', 'LineWidth', 1.5); hold on
    
    % Theoretical S.S.:
    %S_theory = ones(size(S)) * mu / beta;
    %I_theory = (Lambda / mu - mu / beta) * ones(size(I))
    %plot(t, S_theory, '-*', 'LineWidth', 1.5); hold on
    %plot(t, I_theory, '-*', 'LineWidth', 1.5);
end