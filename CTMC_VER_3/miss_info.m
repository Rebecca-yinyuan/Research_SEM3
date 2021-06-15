function [V_ave_missinfo, T_ave_missinfo, Theta_missinfo, t_missinfo] = miss_info(t_start, t_end, I_num)

global V_poly T_poly infect_timelength V_ave_missinfo T_ave_missinfo
global Theta_missinfo t_missinfo



% generate the meshline: 
t_missinfo = (t_start : (t_end - t_start) / 500  : t_end);

% initialise the array
V_ave_missinfo = zeros(length(t_missinfo), 1); 
T_ave_missinfo = zeros(length(t_missinfo), 1);
Theta_missinfo = zeros(length(t_missinfo), 1);

for i = 1 : length(t_missinfo)
    
    tau = t_missinfo(i);
    LHS_sum = 0;
    V_sum = 0;
    T_sum = 0;
    
    for j = 1 : I_num
        V_j = ppval(V_poly, infect_timelength(j) + tau - t_start); 
        T_j = ppval(T_poly, infect_timelength(j) + tau - t_start);
    
        LHS_sum = LHS_sum + V_j * T_j;
        V_sum = V_sum + V_j;
        T_sum = T_sum + T_j;
    end
    
    
    V_ave_missinfo(i) = V_sum / I_num;
    T_ave_missinfo(i) = T_sum / I_num;

    Theta_missinfo(i) = LHS_sum / (V_ave_missinfo(i) * T_ave_missinfo(i));
    
end
    
%plot_missinfo(V_ave_missinfo, T_ave_missinfo, Theta_missinfo, t_missinfo, I_num);


end




function plot_missinfo(V_ave, T_ave, Theta, t, I_num)

figure(99)

subplot(3, 1, 1)
plot(t, V_ave); hold on
xlabel('time');
ylabel('V_{ave}');

subplot(3, 1, 2)
plot(t, T_ave); hold on
xlabel('time');
ylabel('T_{ave}');

subplot(3, 1, 3)
plot(I_num * ones(size(Theta)), Theta); hold on
xlabel('time');
ylabel('\Theta');

end