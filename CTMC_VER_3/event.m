%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FURTHER FOR LOGIC ERRORS!!!!!!!!!!!!!!!
function DeltaT = event(t_index, beta0, C0, eventlog, noiselog, mu)

global Q C Sdie Idie t_array T1 flag flag_E1
%[T_SS, ~, V_SS] = const_WH();

% Find the minimal value in the event queue Q:
[DeltaT, index] = min(Q);

if flag == 0
    % No susceptible left, we can only have E1 / E3 happen and 
    % our Q = [Idie, T1] or  Q = [Idie]
    
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