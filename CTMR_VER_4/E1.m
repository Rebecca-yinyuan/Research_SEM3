function E1(t_index, C0, DeltaT, eventlog, mu)
% If a new susceptible will enter the population:

global S I C Sdie infect_timelength flag t_array flag_E1

S(t_index + 1) = S(t_index) + 1; I(t_index + 1) = I(t_index); 
flag = 1; flag_E1 = 1;
fprintf(eventlog,'%f One Susceptible Enters the System\n', t_array(t_index) + DeltaT);
    
% Update 'Sdie' and 'C': 
Sdie(S(t_index + 1)) = -log(rand) / mu;
C = update_C(S, I, C, C0);
            
infect_timelength = infect_timelength + DeltaT;

end