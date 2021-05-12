function E3(t_index, DeltaT, eventlog, remove_I_index)
% If some infectious person with index remove_I_index dies: 

global S I C Idie infect_timelength t_array Infect_timepoint

S(t_index + 1) = S(t_index); I(t_index + 1) = I(t_index) - 1; 
% The 'flag' value does not change, so we don't need to update it.
    
fprintf(eventlog,'%f One Infectious Dies\n', t_array(t_index) + DeltaT);
    
% Remove that infectious from the system: 
Idie = Delete_ele(remove_I_index, Idie); 
Infect_timepoint = Delete_ele(remove_I_index, Infect_timepoint);
infect_timelength = Delete_ele(remove_I_index, infect_timelength);
C = Delete_ele(remove_I_index, C);
infect_timelength = infect_timelength + DeltaT;


end