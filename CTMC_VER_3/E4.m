function E4(beta0, t_index, DeltaT, I_index, eventlog, noiselog, mu, C0)

% If an infectious person i = I_index interacts with a susceptible person

global S I C Sdie Idie infect_timelength flag t_array V_poly Infect_timepoint V_SS 

V_1 = ppval(V_poly, infect_timelength(I_index));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEST: CONST. WH SUBSYSTEM:
%V_1 = V_SS;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TV = beta0 * V_1; 
u5 = rand;

% An infection happens:
% (note that flag = 1: #S > 0, and vice versa)
if (u5 <= min(TV, 1)) && (flag == 1)
     % A susceptible becomes infectious
     fprintf(eventlog,'%f One Susceptible Becomes Infectious\n', t_array(t_index) + DeltaT);
     S(t_index + 1) = S(t_index) - 1; I(t_index + 1) = I(t_index) + 1; 
            
     if S(t_index + 1) == 0
        flag = 0;
     end
     
     % Record whether the new infection belongs to the category of disease
     % breakout, or the catergory of later-on noise:
     if t_index >= 2
         if S(t_index - 1) == 0 % later-on noise
             fprintf(noiselog,'%f       %d\n', t_array(t_index) + DeltaT, I(t_index + 1));
         end
     end
     
     
     % The susceptible is randomly selected and deleted from the group
     % of susceptible people: 
     Sj = randi(S(t_index));
     Sdie = Delete_ele(Sj, Sdie);
        
     % Add the new infectious individual to the system:
     new_death_time = -log(rand) / mu;
     Idie(length(Idie) + 1) = new_death_time;
     Infect_timepoint(I(t_index + 1)) = t_array(t_index) + DeltaT;
     infect_timelength = infect_timelength + DeltaT;
     infect_timelength(length(infect_timelength) + 1) = 0;
     C = Delete_ele(I_index, C); % this event has happened
     C = update_C(S, I, C, C0);

% An infection does not happen
else
    
    S(t_index + 1) = S(t_index); I(t_index + 1) = I(t_index);  
    infect_timelength = infect_timelength + DeltaT;
    C = Delete_ele(I_index, C); % this event has happened
    
    if S(t_index + 1) == 0
        flag = 0;
        fprintf(eventlog,'%f Nothing happens due to 0 susceptible \n', t_array(t_index) + DeltaT);
    else
        flag = 1;
        fprintf(eventlog,'%f Nothing happens due to low transmission rate \n', t_array(t_index) + DeltaT);
    end
    
end


end