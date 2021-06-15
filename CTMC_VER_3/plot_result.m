function plot_result(j, color)

global t_array S I Theta T_AVE V_AVE
global V_ave_missinfo T_ave_missinfo Theta_missinfo t_missinfo I_num

    figure(j)
    subplot(1, 3, 1)
    opt = append(color,'--');
    plot(t_array, S, color); hold on
    plot(t_array, I, opt); hold on

%if length(V_ave_missinfo) > 1
    %index_start = find(t_array == t_missinfo(1), 1 );
    %index_end = find(t_array == t_missinfo(length(t_missinfo)), 1 );
    %t_array = Include_miss_info(t_array', t_missinfo', index_start, index_end);
    %T_AVE = Include_miss_info(T_AVE', T_ave_missinfo, index_start, index_end);
    %V_AVE = Include_miss_info(V_AVE', V_ave_missinfo, index_start, index_end);
    %Theta = Include_miss_info(Theta', Theta_missinfo, index_start, index_end);
    %I = Include_miss_info(I', I_num * ones(size(V_ave_missinfo)), index_start, index_end);
%end

    figure(j)
    subplot(1, 3, 2)
    plot(t_array, V_AVE, color); hold on
    subplot(1, 3, 3)
    plot(t_array, T_AVE, color); hold on
    %plot(I, Theta, 'b', 'LineWidth', 1.2); hold on

    
    figure(1) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    plot(I, Theta, color); hold on
    %grad_I = gradient(I); grad_The = gradient(Theta);
    %quiver(I, Theta, grad_I, grad_The, 5); hold on
    

    %figure(2) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %subplot(2, 1, 1)
    %plot(t_array, I); hold on
    %subplot(2, 1, 2)
    %plot(t_array, S); hold on

    
    figure(3)
    c = linspace(1,length(I),length(I)); 
    index = find(S == 0, 1 );
    if ~isempty(index)
        t_decade = t_array(index);
        I_decade = I(index);


        figure(1)
        xline(I_decade, '-.', 'LineWidth', 1.2); hold on
        
        
        figure(j)
        subplot(1, 3, 1)
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        subplot(1, 3, 2)
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on
        subplot(1, 3, 3)
        xline(t_decade, '-.', 'LineWidth', 1.2); hold on


        figure(3)
        sc1 = 100; sc2 = 30;
        xline(I_decade, '-.', 'LineWidth', 1.2); hold on
        scatter(I(1 : index), Theta(1 : index), sc1, c(1 : index), 'filled'); hold on
        scatter(I(index + 1 : end), Theta(index + 1 : end), sc2, c(index + 1 : end), 'filled'); hold on
        
    else
        sc = 100;
        figure(3)
        scatter(I, Theta, sc, c, 'filled'); hold on
    end
    
end



function info = Include_miss_info(orignal_array, miss_info, index_start, index_end)

info1 = orignal_array(1 : index_start - 1);
info2 = miss_info;
info3 = orignal_array(index_end + 1 : end);

info = cat(1, info1, info2, info3);

end