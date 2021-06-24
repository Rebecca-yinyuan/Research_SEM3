%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FURTHER FOR LOGIC ERRORS!!!!!!!!!!!!!!!
function [DeltaT, t_index, grid_add] = event(t_index, beta0, C0, eventlog, noiselog, mu, missingtlog, grid_add)

global Q C Sdie Idie t_array T1 flag flag_E1 flag_missinfo V_ave_missinfo S I V_AVE T_AVE Theta
global T_ave_missinfo Theta_missinfo t_missinfo I_num


%[T_SS, ~, V_SS] = const_WH();

% Find the minimal value in the event queue Q:
[DeltaT, index] = min(Q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We will lose average within-host information if 'DeltaT' is too large.
% Therefore, we are going to include those data manually:
threshold = 10;
if DeltaT > threshold 
    t_start = t_array(t_index); fprintf(missingtlog, '%d\n', t_index); 
    t_end = t_start + DeltaT;
    I_num = length(Idie);
    [V_ave_missinfo, T_ave_missinfo, Theta_missinfo, t_missinfo] = miss_info(t_start, t_end, I_num, grid_add);
    
    % We need to insert those info into our corresponding matrices as well:
    S(t_index + 1 : t_index + length(t_missinfo)) = length(Sdie);
    I(t_index + 1 : t_index + length(t_missinfo)) = length(Idie);
    t_array(t_index + 1 : t_index + length(t_missinfo)) = t_missinfo;
    V_AVE(t_index + 1 : t_index + length(t_missinfo)) = V_ave_missinfo;
    T_AVE(t_index + 1 : t_index + length(t_missinfo)) = T_ave_missinfo;
    Theta(t_index + 1 : t_index + length(t_missinfo)) = Theta_missinfo;
    
    % Note that we would not update 'C', 'Sdie', 'Idie',
    % 'infect_timelength', nor 'Infect_timepoint', as the between-host
    % system does not change during this time, 'DeltaT'. 
    
    t_index = t_index + length(t_missinfo); % update the time index 
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if flag == 0
    % No susceptible left, we can only have E1 / E3 happen and 
    % our Q = [Idie, T1] or  Q = [Idie]
    
    % Plot the first piece of missing info:
    %if flag_missinfo == 1 && flag_E1 == 0
        %flag_missinfo = 0;
        %t_start = t_array(t_index);
        %t_end = t_start + DeltaT;
        %I_num = length(Idie);
        %[V_ave_missinfo, T_ave_missinfo, Theta_missinfo, t_missinfo] = miss_info(t_start, t_end, I_num);
    %end
    
    if index > length(Idie)    % E1 happens 
        E1(t_index, C0, DeltaT, eventlog, mu)
    else    % E3 happens and an infectious person with index index dies
        remove_I_index = index;
        E3(t_index, DeltaT, eventlog, remove_I_index);
    end
    
else
    
    % our Q = [C, Sdie, Idie, T1] or [C, Sdie, Idie];
    if index > 2 * length(Idie) + length(Sdie)    % E1 happens 
        E1(t_index, C0, DeltaT, eventlog, mu);
    elseif (length(Idie) + 1 <= index) && (index <= length(Idie) + length(Sdie))
        remove_S_index = index - length(Idie);
        E2(t_index, C0, DeltaT, eventlog, remove_S_index);
    elseif (length(Idie) + length(Sdie) + 1 <= index) && (index <= 2 * length(Idie) + length(Sdie))
        remove_I_index = index - length(Idie) - length(Sdie);
        E3(t_index, DeltaT, eventlog, remove_I_index);
    else
        I_index = index;
        E4(beta0, t_index, DeltaT, I_index, eventlog, noiselog, mu, C0);
    end
  
end

% Update Q:
if flag == 0   % No susceptible left
    if flag_E1 == 1    % E1 has happened
        Q = Idie;
    else
        Q = [Idie, T1];
    end
else
    if flag_E1 == 1    % E1 has happened
        Q = [C, Sdie, Idie];
    else
        Q = [C, Sdie, Idie, T1];
    end
end

% Update Theta
theta_calculator(t_index);

end