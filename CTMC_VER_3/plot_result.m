function plot_result(j, color)

global t_array S I Theta T_AVE V_AVE

    figure(j)
    subplot(1, 3, 1)
    opt = append(color,'--');
    plot(t_array, S, opt); hold on
    plot(t_array, I, opt); hold on
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

