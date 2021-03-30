function hybrid_simulation_Ver2_driver

S0 = 90;
I0 = 10;
Lambda = 10 ^ (-5);
mu = 10 ^ (-5);
C0 = 10 ^ (-4);
t_end = 800;

rep = 20; 
for j = 10 : 10
    figure(j)
    beta0 = 10 ^ (-j);
    for i = 1 : rep
        hybrid_simulation_Ver2(S0, I0, Lambda, mu, C0, beta0, t_end);
        Multiscale_hybrid_1()
    end
    xlabel('time'); ylabel('population');
    title(['Non-const W-H CTMC (red & green) VS Const W-H CTMC (black & blue), with C_0 = ', num2str(C0), ' and \beta_0 = ', num2str(beta0), ' (rep = ', num2str(rep), ' )']);
end

%Multiscale_hybrid_1()


end
