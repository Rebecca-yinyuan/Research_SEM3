function E2(t_index, C0, DeltaT, eventlog, remove_S_index)
% If some susceptible person with index remove_S_index dies: 

global S I C Sdie infect_timelength flag t_array

S(t_index + 1) = S(t_index) - 1; I(t_index + 1) = I(t_index); 
    
if S(t_index + 1) == 0
    flag = 0;
else
    flag = 1;
end
    
fprintf(eventlog,'%f One Susceptible Dies\n', t_array(t_index) + DeltaT);
    
% Remove that susceptible from the system and update 'C': 
Sdie = Delete_ele(remove_S_index, Sdie); % This event has happened
    
C = update_C(S, I, C, C0);   
infect_timelength = infect_timelength + DeltaT;

end