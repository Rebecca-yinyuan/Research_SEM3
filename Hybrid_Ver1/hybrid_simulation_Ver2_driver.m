function hybrid_simulation_Ver2_driver

clear

S0 = 90;
I0 = 10;
Lambda = 10 ^ (-5);
mu = 10 ^ (-5);
C0 = 10 ^ (0);
t_end = 20;
rep = 3; 

index_min = 10 ^ 8;
t_min = t_end;

for j = 7 : 7
    beta0 = 10 ^ (-j);
    figure(j)
    fileS = fopen('S.txt','a+'); 
    fileI = fopen('I.txt','a+');
    filet = fopen('t.txt','a+');
    
    for i = 1 : rep
        [t, S, I] = hybrid_simulation_Ver2(S0, I0, Lambda, mu, C0, beta0, t_end);
        
        export_file(fileS, S, fileI, I, filet, t);
        
        if length(t) <= index_min
            index_min = length(t);
        end
        if t(length(t)) <= t_min
            t_min = t(length(t));
        end

        %Multiscale_hybrid_1(beta0)
    end

    xlabel('time'); ylabel('population');
    title(['Non-const W-H CTMC (red & green) VS Const W-H CTMC (black & blue), with C_0 = ', num2str(C0), ' and \beta_0 = ', num2str(beta0)]);

    fclose(fileS); fclose(fileI); fclose(filet); 
    %[SS, II, tt] = read_data('S.txt', 'I.txt', 't.txt', rep, index_min);
    [SSS, III, ttt] = read_data_2('S.txt', 'I.txt', 't.txt', rep, t_min);

    delete 'S.txt' 'I.txt' 't.txt'
    
    % Interpolation:
    %[t_interp, SS_interp, II_interp] = interpolation(SS, II, tt, index_min, rep);
    plot_Confidence_band(ttt, SSS, III, rep)
    
    
end


end



function export_file(fileS, S, fileI, I, filet, t)


fprintf(fileS, '\n\n');
fprintf(fileS,'%f \n',S);

fprintf(fileI, '\n\n');
fprintf(fileI,'%f \n',I);

fprintf(filet, '\n\n');
fprintf(filet,'%f \n',t);


end

function [SS, II, tt] = read_data(fileS, fileI, filet, rep, index_min)

cont_S = fileread(fileS);
cont_S = strsplit(cont_S, '\n\n');
S_collec = cellfun(@(c) sscanf(c, '%f', [1 Inf])', cont_S(1:end), 'UniformOutput', false);

cont_I = fileread(fileI);
cont_I = strsplit(cont_I, '\n\n');
I_collec = cellfun(@(c) sscanf(c, '%f', [1 Inf])', cont_I(1:end), 'UniformOutput', false);

cont_t = fileread(filet);
cont_t = strsplit(cont_t, '\n\n');
t_collec = cellfun(@(c) sscanf(c, '%f', [1 Inf])', cont_t(1:end), 'UniformOutput', false);

SS = ones(index_min, rep); II = ones(index_min, rep); tt = ones(index_min, rep);


for i = 1 : rep
    SS(:, i) = S_collec{i + 1}(1 : index_min);
    II(:, i) = I_collec{i + 1}(1 : index_min);
    tt(:, i) = t_collec{i + 1}(1 : index_min);
end


end


function [t_interp, SS_interp, II_interp] = interpolation(SS, II, tt, index_min, rep)

t_end = min(tt(index_min, : ));
t_interp = (0 : (t_end / 10 ^ (4)) : t_end);

SS_interp = zeros(length(t_interp), rep);
II_interp = zeros(length(t_interp), rep);

for i = 1 : rep
    
    % Do the interpolation first: 
    S_poly = interp1(tt(:, i),SS(:, i), 'linear','pp'); 
    I_poly = interp1(tt(:, i),II(:, i), 'linear','pp');
    
    % Evaluate at 't_interp' and store the result:
    S_eva = ppval(S_poly, t_interp); I_eva = ppval(I_poly, t_interp);
    SS_interp(:, i) = S_eva; II_interp(:, i) = I_eva; 
    
end


end


function plot_Confidence_band(t_interp, SS_interp, II_interp, rep)

S_mean = sum(SS_interp, 2) / rep;
I_mean = sum(II_interp, 2) / rep;

figure()
plot(t_interp, S_mean, t_interp, I_mean); hold on

p_up = 0.975; p_down = 0.025;
S_up_band = zeros(length(t_interp), 1); I_up_band = zeros(length(t_interp), 1);
S_down_band = zeros(length(t_interp), 1); I_down_band = zeros(length(t_interp), 1);
for i = 1 : length(t_interp)
    S_up_band(i) = quantile(SS_interp(i, :), p_up);
    I_up_band(i) = quantile(II_interp(i, :), p_up);
    S_down_band(i) = quantile(SS_interp(i, :), p_down);
    I_down_band(i) = quantile(II_interp(i, :), p_down);
end

plot(t_interp, S_up_band, t_interp, I_up_band, t_interp, S_down_band, t_interp, I_down_band); 

end



function [SSS, III, ttt] = read_data_2(fileS, fileI, filet, rep, t_min)

cont_S = fileread(fileS);
cont_S = strsplit(cont_S, '\n\n');
S_collec = cellfun(@(c) sscanf(c, '%f', [1 Inf])', cont_S(1:end), 'UniformOutput', false);

cont_I = fileread(fileI);
cont_I = strsplit(cont_I, '\n\n');
I_collec = cellfun(@(c) sscanf(c, '%f', [1 Inf])', cont_I(1:end), 'UniformOutput', false);

cont_t = fileread(filet);
cont_t = strsplit(cont_t, '\n\n');
t_collec = cellfun(@(c) sscanf(c, '%f', [1 Inf])', cont_t(1:end), 'UniformOutput', false);


t_end = t_min;
ttt = (0 : (t_end / 10 ^ (4)) : t_end);
SSS = zeros(length(ttt), rep);
III = zeros(length(ttt), rep);


for i = 1 : rep
    
    % Do the interpolation first: 
    S_poly = interp1(t_collec{i + 1}, S_collec{i + 1}, 'linear','pp'); 
    I_poly = interp1(t_collec{i + 1}, I_collec{i + 1}, 'linear','pp');
    
    % Evaluate at 't_interp' and store the result:
    S_eva = ppval(S_poly, ttt); I_eva = ppval(I_poly, ttt);
    SSS(:, i) = S_eva; III(:, i) = I_eva; 
    
end


end
