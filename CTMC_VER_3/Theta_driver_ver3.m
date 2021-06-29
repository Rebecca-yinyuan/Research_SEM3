function Theta_driver_ver3()

clear
delete *.txt

global t_array S I Theta T_AVE V_AVE

% Commands for plot formatting:
set(0,'defaultAxesFontSize',30); set(gca,'FontSize',30);
set(0, 'DefaultLineLineWidth', 1.2); 
set(findall(gcf,'-property','FontSize'),'FontSize',30)
%propertyeditor('on');


S0 = 90; I0 = 10;
Lambda = 10 ^ (-3); mu = 10 ^ (-5); C0 = 10 ^ (0);
t_end = 10 ^ 6; rep = 1;
grid_add = 80; % harverst the inter-event time data

eventlog = fopen('EventLog.txt', 'a+');
%noiselog = fopen('NoiseLog.txt', 'a+');

color = ['b', 'r', 'k'];

for j = 6 : 6
    
    beta0 =  10 ^ (-j);
    
    fprintf(eventlog, 'beta0 = %e \n***********************************\n\n', beta0);
    %fprintf(noiselog, 'beta0 = %e \n***********************************\n\n', beta0);
    
    for i = 1 : rep
        fprintf(eventlog, 'rep = %d\n', i); 
        %fprintf(noiselog, 'rep = %d\n', i);
        fprintf(eventlog, 'Time     Event\n');
        %fprintf(noiselog, 'Time of Noise Infect        I(t) after Noise Infect\n');
        
        Slog = fopen('S.txt', 'wt');
        Ilog = fopen('I.txt', 'wt');
        tlog = fopen('t.txt', 'wt');
        Thetalog = fopen('Theta.txt', 'wt');
        Vlog = fopen('VV.txt', 'wt');
        Tlog = fopen('TT.txt', 'wt');

        tlog_missinfo = fopen('t_missinfo.txt', 'wt');
        Vlog_missinfo = fopen('V_missinfo.txt', 'wt');
        Tlog_missinfo = fopen('TT_missinfo.txt', 'wt');
        Thetalog_missinfo = fopen('Theta_missinfo.txt', 'wt');
        Slog_missinfo = fopen('S_missinfo.txt', 'wt');
        Ilog_missinfo = fopen('I_missinfo.txt', 'wt');
        missingtlog = fopen('miss_start_index.txt', 'a+');
        
        [t_array, S, I, Theta, T_AVE, V_AVE] = Theta_ver3(S0, I0, Lambda, mu, C0, beta0, t_end, eventlog, missingtlog, grid_add);
        fprintf(tlog_missinfo,'%f\n', t_array'); fclose(tlog_missinfo);
        fprintf(Vlog_missinfo,'%f\n', V_AVE'); fclose(Vlog_missinfo);
        fprintf(Tlog_missinfo,'%f\n', T_AVE'); fclose(Tlog_missinfo);
        fprintf(Thetalog_missinfo,'%f\n', Theta'); fclose(Thetalog_missinfo);
        fprintf(Slog_missinfo,'%f\n', S'); fclose(Slog_missinfo);
        fprintf(Ilog_missinfo,'%f\n', I'); fclose(Ilog_missinfo);
        %plot_result(j, color(i)); 
        
        % remove the inter-event data point: 
        fclose(missingtlog);
        [t_array, S, I, Theta, T_AVE, V_AVE] = remove_interevent_data(t_array, S, I, Theta, T_AVE, V_AVE, grid_add, 'miss_start_index.txt');
        %plot_result(j * 2, color(i)); 
        fprintf(Slog,'%f\n', S'); fclose(Slog);
        fprintf(Ilog,'%f\n', I'); fclose(Ilog);
        fprintf(tlog,'%f\n', t_array'); fclose(tlog);
        fprintf(Thetalog,'%f\n', Theta'); fclose(Thetalog);
        fprintf(Vlog,'%f\n', V_AVE'); fclose(Vlog);
        fprintf(Tlog,'%f\n', T_AVE'); fclose(Tlog);
        
        fprintf(eventlog, '------------------------------------------\n\n');
        %fprintf(noiselog, '------------------------------------------\n\n');
        
        data_visualisation('S.txt', 'I.txt', 't.txt', 'Theta.txt', ...
        'V_missinfo.txt', 'TT_missinfo.txt', 'Theta_missinfo.txt', ...
        't_missinfo.txt', 'S_missinfo.txt', 'I_missinfo.txt', j, color(i));
        
        delete 'S.txt' 'I.txt' 't.txt' 'Theta.txt' ...
        'V_missinfo.txt' 'TT_missinfo.txt' 'Theta_missinfo.txt' ...
        'S_missinfo.txt' 'I_missinfo.txt' 't_missinfo.txt'...
        'miss_start_index.txt' 'VV.txt' 'TT.txt'

    end
    
    fclose(eventlog);
    delete *.txt
    %fclose(noiselog);
    
    %plot_edit_title(j, beta0, rep, S0, I0);
end

end
