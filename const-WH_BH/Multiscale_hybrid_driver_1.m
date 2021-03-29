function Multiscale_hybrid_driver_1()

clc

figure(1)
rep = 100; 
for i = 1 : rep
    Multiscale_hybrid_1();
end

[S, I, t, ~] = CTMC_BH_driver();
plot_SI(S, I, t);

ylabel('\Theta(t)'); xlabel('t');
title('$$\Theta(I) \propto \frac{\sum_{j \geq 1}^{I(t)} V_jT_j}{V_{ave}T_{ave}}$$', 'interpreter', 'latex')

end
