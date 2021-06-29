function plot_result(j, color)

global t_array S I Theta T_AVE V_AVE
global V_ave_missinfo T_ave_missinfo Theta_missinfo t_missinfo I_num
    
    %size(Theta)
    %size(T_AVE)
    %size(V_AVE)
    
    %figure(j)
    %subplot(1, 3, 1)
    %opt = append(color,'--');
    %plot(t_array, S, color); hold on
    %plot(t_array, I, opt); hold on

%if length(V_ave_missinfo) > 1
    %index_start = find(t_array == t_missinfo(1), 1 );
    %index_end = find(t_array == t_missinfo(length(t_missinfo)), 1 );
    %t_array = Include_miss_info(t_array', t_missinfo', index_start, index_end);
    %T_AVE = Include_miss_info(T_AVE', T_ave_missinfo, index_start, index_end);
    %V_AVE = Include_miss_info(V_AVE', V_ave_missinfo, index_start, index_end);
    %Theta = Include_miss_info(Theta', Theta_missinfo, index_start, index_end);
    %I = Include_miss_info(I', I_num * ones(size(V_ave_missinfo)), index_start, index_end);
%end

    %figure(j)
    %subplot(1, 3, 2)
    %plot(t_array, V_AVE, color); hold on
    %subplot(1, 3, 3)
    %plot(t_array, T_AVE, color); hold on
    %plot(I, Theta, 'b', 'LineWidth', 1.2); hold on

    
    %figure(1) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot(I, Theta, color); hold on
    %grad_I = gradient(I); grad_The = gradient(Theta);
    %quiver(I, Theta, grad_I, grad_The, 5); hold on
    

    %figure(2) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %subplot(2, 1, 1)
    %plot(t_array, I); hold on
    %subplot(2, 1, 2)
    %plot(t_array, S); hold on

    
    index = find(S == 0, 1 );
    c = linspace(1,length(I),length(I)); 
    if ~isempty(index)
        t_decade = t_array(index);
        I_decade = I(index);

        %figure(1)
        %xline(I_decade, '-.', 'LineWidth', 1.2); hold on
        
        % dynamics of the initial disease transmission period
        figure(j)
        subplot(1, 3, 1)
        opt = append(color,'--');
        plot(t_array(1 : index + 1), S(1 : index + 1), color); hold on
        plot(t_array(1 : index + 1), I(1 : index + 1), opt); hold on
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        subplot(1, 3, 2)
        plot(t_array(1 : index + 1), V_AVE(1 : index + 1), color); hold on
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        subplot(1, 3, 3)
        plot(t_array(1 : index + 1), T_AVE(1 : index + 1), color); hold on
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        
        % dynamics of the transition period
        figure(j + 1)
        subplot(1, 3, 1)
        opt = append(color,'--');
        plot(t_array(index - 10 : index + 8), S(index - 10 : index + 8), color); hold on
        plot(t_array(index - 10 : index + 8), I(index - 10 : index + 8), opt); hold on
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        subplot(1, 3, 2)
        plot(t_array(index - 10 : index + 8), V_AVE(index - 10 : index + 8), color); hold on
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        subplot(1, 3, 3)
        plot(t_array(index - 10 : index + 8), T_AVE(index - 10 : index + 8), color); hold on
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        
        % overal dynamics:
        figure(j + 2)
        subplot(1, 3, 1)
        opt = append(color,'--');
        plot(t_array, S, color); hold on
        plot(t_array, I, opt); hold on
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        subplot(1, 3, 2)
        plot(t_array, V_AVE, color); hold on
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        subplot(1, 3, 3)
        plot(t_array, T_AVE, color); hold on
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        
        
        % theta of the initial disease transmission period
        figure(j + 3)
        subplot(1, 2, 1)
        sc1 = 80; %100; 
        sc2 = 80;
        xline(I_decade, '-.', 'LineWidth', 1.2); hold on
        c1 = c(1 : index); 
        scatter(I(1 : index), Theta(1 : index), sc1, c1, 'filled'); hold on
        %scatter(I(index + 1 : end), Theta(index + 1 : end), sc2, c(index + 1 : end), 'filled'); hold on
        scatter(I(index + 1 : end), Theta(index + 1 : end) + 8, sc2); hold on
        
        % theta of the later period
        subplot(1, 2, 2)
        c2 = c(index + 1 : end);
        scatter(I(1 : index), Theta(1 : index), sc1); hold on
        scatter(I(index + 1 : end), Theta(index + 1 : end) - 8, sc2, c2, 'filled'); hold on
        
    else
        fprintf('!!!!!!')
        sc = 100;
        figure(j + 3)
        scatter(I, Theta, sc, c, 'filled'); hold on
        
    end
    
end



function info = Include_miss_info(orignal_array, miss_info, index_start, index_end)

info1 = orignal_array(1 : index_start - 1);
info2 = miss_info;
info3 = orignal_array(index_end + 1 : end);

info = cat(1, info1, info2, info3);

end