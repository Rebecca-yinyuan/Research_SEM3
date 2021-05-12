function theta_calculator(t_index)

global I V_poly T_poly infect_timelength V_SS T_SS Theta V_AVE T_AVE

% Update theta value and thus the Theta array: 
LHS_sum = 0;
V_sum = 0;
T_sum = 0;

for j = 1 : I(length(I))
    V_j = ppval(V_poly, infect_timelength(j)); 
    T_j = ppval(T_poly, infect_timelength(j));
    %if V_j < V_SS
    %    V_j = V_SS;
    %end
    %if T_j < T_SS
    %    T_j = T_SS;
    %end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TEST: CONST. WH SUBSYSTEM:
    %V_j = V_SS; T_j = T_SS;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    LHS_sum = LHS_sum + V_j * T_j;
    V_sum = V_sum + V_j;
    T_sum = T_sum + T_j;
end

V_ave = V_sum / I(length(I)); V_AVE(t_index + 1) = V_ave;
T_ave = T_sum / I(length(I)); T_AVE(t_index + 1) = T_ave;

Theta(t_index + 1) = LHS_sum / (V_ave * T_ave);


end