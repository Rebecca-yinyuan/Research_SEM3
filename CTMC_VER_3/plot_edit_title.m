function plot_edit_title(j, beta0, rep, S0, I0)

    figure(j)
    xlabel('t'); ylabel('Population');
    title(['S(t), I(t) versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0), ', \beta_0 = ', num2str(beta0),', and rep = ', num2str(rep)]);
    
    figure(1) %%%%%%%%%%%%%%%%%%%%%%%%%%
    xlabel('I(t)'); ylabel('$$\Theta(I) \propto \frac{\sum_{j \geq 1}^{I(t)} V_jT_j}{V_{ave}T_{ave}}$$', 'interpreter', 'latex'); 
    title(['\Theta(I) VS I, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0), ', and rep = ', num2str(rep)]);
    figure(3)
    xlabel('I(t)'); ylabel('$$\Theta(I) \propto \frac{\sum_{j \geq 1}^{I(t)} V_jT_j}{V_{ave}T_{ave}}$$', 'interpreter', 'latex'); 
    title(['\Theta(I) VS I, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0), ', and rep = ', num2str(rep)]);
    
    %figure(2) %%%%%%%%%%%%%%%%%%%%%%%%%%
    %subplot(2, 1, 1)
    %xlabel('t'); ylabel('I(t)');
    %title(['I(t) versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0), ', and rep = ', num2str(rep)]);
    %subplot(2, 1, 2)
    %xlabel('t'); ylabel('S(t)');
    %title(['S(t) versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0), ', and rep = ', num2str(rep)]);
    
    figure(99)
    xlabel('t'); ylabel('V_{ave}');
    title(['V_{ave} versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0),' , and rep = ', num2str(rep)]);
    
    figure(100)
    xlabel('t'); ylabel('T_{ave}');
    title(['T_{ave} versus t, with S_0 = ', num2str(S0), ', I_0 = ', num2str(I0),', \beta_0 = ', num2str(beta0),' , and rep = ', num2str(rep)]);
    
end