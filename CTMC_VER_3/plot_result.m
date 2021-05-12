function plot_result(j)

global t_array S I Theta T_AVE V_AVE

    figure(j)
    plot(t_array, S, 'g', t_array, I, 'r'); hold on
    %plot(I, Theta, 'b', 'LineWidth', 1.2); hold on

    figure(1) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    plot(I, Theta); hold on
    %grad_I = gradient(I); grad_The = gradient(Theta);
    %quiver(I, Theta, grad_I, grad_The, 5); hold on
    
    figure(3)
    c = linspace(1,length(I),length(I)); sc = 50;
    %length(c)
    scatter(I, Theta, sc, c, 'filled'); hold on
    %grad_I = gradient(I); grad_The = gradient(Theta);
    %quiver(I, Theta, grad_I, grad_The, 3); hold on
    

    %figure(2) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %subplot(2, 1, 1)
    %plot(t_array, I); hold on
    %subplot(2, 1, 2)
    %plot(t_array, S); hold on

    figure(99) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    plot(t_array, V_AVE); hold on
    figure(100)
    plot(t_array, T_AVE); hold on
    
    
    index = find(S == 0, 1 );

    if ~isempty(index)
        t_decade = t_array(index);
        I_decade = I(index);


        figure(1)
        xline(I_decade, '-.', 'LineWidth', 1.2); hold on

        figure(3)
        xline(I_decade, '-.', 'LineWidth', 1.2); hold on

    end
    
end

