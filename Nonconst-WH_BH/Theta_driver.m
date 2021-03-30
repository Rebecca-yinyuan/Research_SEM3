function Theta_driver

S0 = 90;
I0 = 10;
Lambda = 10 ^ (-5);
mu = 10 ^ (-5);
C0 = 10 ^ (-2);
t_end = 500;

rep = 20; 
for j = 13 : 13
    figure(j)
    beta0 = 10 ^ (-j);
    for i = 1 : rep
        Theta(S0, I0, Lambda, mu, C0, beta0, t_end)
    end
    xlabel('I(t)'); ylabel('\Theta(I)');
    title('$$\Theta(I) \propto \frac{\sum_{j \geq 1}^{I(t)} V_jT_j}{V_{ave}T_{ave}}$$', 'interpreter', 'latex');
end


end
