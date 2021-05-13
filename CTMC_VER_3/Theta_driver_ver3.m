function Theta_driver_ver3()

clear

% Commands for plot formatting:
set(0,'defaultAxesFontSize',30); set(gca,'FontSize',30);
set(0, 'DefaultLineLineWidth', 1.2);
%propertyeditor('on');


S0 = 90; I0 = 10;

Lambda = 10 ^ (-4); mu = 10 ^ (-5);
%C0 = 10 ^ (-5);
C0 = 10 ^ (0);

t_end = 10 ^ 6; rep = 3;

eventlog = fopen('EventLog.txt', 'a+');
noiselog = fopen('NoiseLog.txt', 'a+');

for j = 6 : 6
    
    beta0 =  10 ^ (-j);
    
    fprintf(eventlog, 'beta0 = %e \n***********************************\n\n', beta0);
    fprintf(noiselog, 'beta0 = %e \n***********************************\n\n', beta0);
    
    for i = 1 : rep
        fprintf(eventlog, 'rep = %d\n', i); 
        fprintf(noiselog, 'rep = %d\n', i);
        fprintf(eventlog, 'Time     Event\n');
        fprintf(noiselog, 'Time of Noise Infect        I(t) after Noise Infect\n');
        
        Theta_ver3(S0, I0, Lambda, mu, C0, beta0, t_end, eventlog, noiselog);
        plot_result(j); 
        
        fprintf(eventlog, '------------------------------------------\n\n');
        fprintf(noiselog, '------------------------------------------\n\n');
    end
    
    fclose(eventlog);
    fclose(noiselog);
    
    plot_edit_title(j, beta0, rep, S0, I0);
end

end
