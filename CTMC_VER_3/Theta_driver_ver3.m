function Theta_driver_ver3()

clear

global t_array S I Theta T_AVE V_AVE

% Commands for plot formatting:
set(0,'defaultAxesFontSize',30); set(gca,'FontSize',30);
set(0, 'DefaultLineLineWidth', 1.2);
%propertyeditor('on');


S0 = 90; I0 = 10;

Lambda = 10 ^ (-3); mu = 10 ^ (-5);
%C0 = 10 ^ (-5);
C0 = 10 ^ (0);

t_end = 10 ^ 6; rep = 1;

eventlog = fopen('EventLog.txt', 'a+');
noiselog = fopen('NoiseLog.txt', 'a+');
missingtlog = fopen('miss_start_index', 'a+');
grid_add = 80; % harverst the inter-event time data

Slog = fopen('S.txt', 'wt');
Ilog = fopen('I.txt', 'wt');
tlog = fopen('t.txt', 'wt');
Thetalog = fopen('Theta.txt', 'wt');
Vlog = fopen('VV.txt', 'wt');
Tlog = fopen('TT.txt', 'wt');


color = ['b', 'r', 'k'];

for j = 6 : 6
    
    beta0 =  10 ^ (-j);
    
    fprintf(eventlog, 'beta0 = %e \n***********************************\n\n', beta0);
    fprintf(noiselog, 'beta0 = %e \n***********************************\n\n', beta0);
    
    for i = 1 : rep
        fprintf(eventlog, 'rep = %d\n', i); 
        fprintf(noiselog, 'rep = %d\n', i);
        fprintf(eventlog, 'Time     Event\n');
        fprintf(noiselog, 'Time of Noise Infect        I(t) after Noise Infect\n');
        
        [t_array, S, I, Theta, T_AVE, V_AVE] = Theta_ver3(S0, I0, Lambda, mu, C0, beta0, t_end, eventlog, noiselog, missingtlog, grid_add);
        plot_result(j, color(i)); 
        
        % remove the inter-event data point: 
        [t_array, S, I, Theta, T_AVE, V_AVE] = remove_interevent_data(t_array, S, I, Theta, T_AVE, V_AVE, grid_add, 'miss_start_index');
        plot_result(j * 2, color(i)); 
     
        fprintf(Slog,'%d\n', S'); fclose(Slog);
        fprintf(Ilog,'%d\n', I'); fclose(Ilog);
        fprintf(tlog,'%f\n', t_array'); fclose(tlog);
        fprintf(Thetalog,'%f\n', Theta'); fclose(Thetalog);
        fprintf(Vlog,'%f\n', V_AVE'); fclose(Vlog);
        fprintf(Tlog,'%f\n', T_AVE'); fclose(Tlog);
        
        fprintf(eventlog, '------------------------------------------\n\n');
        fprintf(noiselog, '------------------------------------------\n\n');
    end
    
    fclose(eventlog);
    fclose(noiselog);
    
    plot_edit_title(j, beta0, rep, S0, I0);
end

end
