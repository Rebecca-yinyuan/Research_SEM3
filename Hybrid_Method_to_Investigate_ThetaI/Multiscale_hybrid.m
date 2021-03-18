function Multiscale_hybrid()

[t_WH, T, ~, V] = Determ_WH_driver();
[~, ~, T_realtime, infect_timepoint] = CTMC_BH_driver(); 
% Note that 'infect_timepoint' is an array recording the timestamp where a
% new infection happens. 

% Parameter of interest in terms of real time, t: 
THETA_I = zeros(size(T_realtime)) * nan; 

% Interpolation to obatain two piecewise polynomials: 
T_poly = spline(t_WH,T); V_poly = spline(t_WH,V); %%% linear interpolation %%%!!!!!

for i = 1 : length(T_realtime)
    
    % Record the infectious time length (note that only non-negative
    % numericla entries are corresponeded to the infectious groups: 
    infect_length = ones(length(T_realtime), 1) * T_realtime(i) - infect_timepoint';
    
    % Initialisation: 
    sum_LHS = 0;
    T_sum = 0;
    V_sum = 0;
    num_infectious = 0;
    
    for j = 1 : length(infect_length)
        if infect_length(j) >= 0 % Only those entries make sense
            num_infectious = num_infectious + 1;
            Vj = ppval(V_poly, infect_length(j));
            Tj = ppval(T_poly, infect_length(j));
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%
% treat W-H system as a CONST. e.g. V = C0
% beta \prop C0 * num Infectious pepople at that time point (from CTMC numerical) 