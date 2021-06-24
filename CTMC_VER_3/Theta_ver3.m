function [t_array, S, I, Theta, T_AVE, V_AVE] = Theta_ver3(S0, I0, Lambda, mu, C0, beta0, t_end, eventlog, noiselog, missingtlog, grid_add)

global Sdie Idie Infect_timepoint infect_timelength Q C S I T_poly V_poly t_array Theta T_SS V_SS flag flag_E1 V_AVE T_AVE flag_missinfo
global T_ave_missinfo Theta_missinfo t_missinfo V_ave_missinfo I_num
V_ave_missinfo = 0; T_ave_missinfo = 0;
Theta_missinfo = 0; t_missinfo = 0; 
Sdie = []; Idie = []; Infect_timepoint = []; infect_timelength = []; Theta = [];
V_AVE = []; T_AVE = []; I_num = 0;
Q = []; C =[]; S = []; S(1) = S0; I = []; I(1) = I0; t_array = []; t_array(1) = 0;
flag = 1; % we assume S(0) > 0
flag_E1 = 0; % initial E1 has not happened
flag_missinfo = 1; % we assume S(0) > 0, so we don't miss any info before
                   % the 1st non-disease transmission event happens

% Initialise all the arrays needed
t0 = 0; 

% Solve for the W-H system once: 
[t_WH, T, ~, V] = Determ_WH_driver();
[T_SS, ~, V_SS] = const_WH();
T_poly = interp1(t_WH,T, 'linear','pp'); V_poly = interp1(t_WH,V, 'linear','pp');
init_system(Lambda, mu, t0, C0); t_index = 1;

while (t_array(length(t_array)) < t_end) 
    if ~ isempty(Q)
        [DeltaT, t_index] = event(t_index, beta0, C0, eventlog, noiselog, mu, missingtlog, grid_add);
        % Update the time array:
        t_index  = t_index + 1;
        t_array(t_index) = t_array(t_index - 1) + DeltaT;
    else
        % Regenerate the queue Q: 
        regenerate_Q(Lambda, mu, C0);
    end
end


% Make sure that t < t_end
if t_array(length(t_array)) > t_end
    t_array = t_array(1 : length(t_array) - 1);
    S = S(1 : length(t_array));
    I = I(1 : length(t_array));
    Theta = Theta(1 : length(t_array));
    T_AVE = T_AVE(1 : length(t_array));
    V_AVE = V_AVE(1 : length(t_array));
end

end

