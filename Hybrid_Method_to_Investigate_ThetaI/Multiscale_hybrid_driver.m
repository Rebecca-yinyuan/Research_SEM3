function Multiscale_hybrid_driver()


figure(1)
rep = 100; 
for i = 1 : rep
    Multiscale_hybrid();
end

ylabel('\Theta(t)'); xlabel('t');
title('$$\Theta(I) \propto \sum_{j \geq 1}^{I(t)} V_jT_j$$', 'interpreter', 'latex')

end