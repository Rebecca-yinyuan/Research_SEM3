function plot_edit_title(j, beta0, rep, S0, I0)

    figure(j)
    subplot(1, 3, 1)
    xlabel('t (days)'); ylabel('Population (numbers)');
    legend('S(t)', 'I(t)', 'S = 0');
    %title(['S(t), I(t) versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0), ', \beta_0 = ', num2str(beta0),', and rep = ', num2str(rep)]);
    subplot(1, 3, 2)
    xlabel('t (days)'); ylabel('V_{ave}');
    legend('V_{ave}', 'S = 0');
    %title(['V_{ave} versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0),' , and rep = ', num2str(rep)]);
    subplot(1, 3, 3)
    xlabel('t (days)'); ylabel('T_{ave}');
    legend('T_{ave}', 'S = 0');
    %title(['T_{ave} versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0),' , and rep = ', num2str(rep)]);
    
    figure(j + 1)
    subplot(1, 3, 1)
    xlabel('t (days)'); ylabel('Population (numbers)');
    legend('S(t)', 'I(t)', 'S = 0');
    %title(['S(t), I(t) versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0), ', \beta_0 = ', num2str(beta0),', and rep = ', num2str(rep)]);
    subplot(1, 3, 2)
    xlabel('t (days)'); ylabel('V_{ave}');
    legend('V_{ave}', 'S = 0');
    %title(['V_{ave} versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0),' , and rep = ', num2str(rep)]);
    subplot(1, 3, 3)
    xlabel('t (days)'); ylabel('T_{ave}');
    legend('T_{ave}', 'S = 0');
    
    figure(j + 2)
    subplot(1, 3, 1)
    xlabel('t (days)'); ylabel('Population (numbers)');
    legend('S(t)', 'I(t)', 'S = 0');
    %title(['S(t), I(t) versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0), ', \beta_0 = ', num2str(beta0),', and rep = ', num2str(rep)]);
    subplot(1, 3, 2)
    xlabel('t (days)'); ylabel('V_{ave}');
    legend('V_{ave}', 'S = 0');
    %title(['V_{ave} versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0),' , and rep = ', num2str(rep)]);
    subplot(1, 3, 3)
    xlabel('t (days)'); ylabel('T_{ave}');
    legend('T_{ave}', 'S = 0');
    
    %figure(1) %%%%%%%%%%%%%%%%%%%%%%%%%%
    %xlabel('I(t)'); ylabel('$$\Theta(I) \propto \frac{\sum_{j \geq 1}^{I(t)} V_jT_j}{V_{ave}T_{ave}}$$', 'interpreter', 'latex'); 
    %title(['\Theta(I) VS I, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0), ', and rep = ', num2str(rep)]);
    figure(j + 3)
    subplot(1, 2, 1)
    xlabel('I(t)'); ylabel('$$\Theta(I)$$', 'interpreter', 'latex'); 
    title('Initial Transmission Period')
    subplot(1, 2, 2)
    xlabel('I(t)'); ylabel('$$\Theta(I)$$', 'interpreter', 'latex'); 
    title('Later Period')
    %title(['\Theta(I) VS I, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0), ', and rep = ', num2str(rep)]);
    
    figure(j * 2 + 3)
    subplot(1, 2, 1)
    xlabel('I(t)'); ylabel('$$\Theta(I)$$', 'interpreter', 'latex'); 
    title('Initial Transmission Period')
    subplot(1, 2, 2)
    xlabel('I(t)'); ylabel('$$\Theta(I)$$', 'interpreter', 'latex'); 
    title('Later Period')
    
    %figure(2) %%%%%%%%%%%%%%%%%%%%%%%%%%
    %subplot(2, 1, 1)
    %xlabel('t'); ylabel('I(t)');
    %title(['I(t) versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0), ', and rep = ', num2str(rep)]);
    %subplot(2, 1, 2)
    %xlabel('t'); ylabel('S(t)');
    %title(['S(t) versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0), ', and rep = ', num2str(rep)]);
    
   
end