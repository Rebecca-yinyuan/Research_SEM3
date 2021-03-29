function Delta_t = TimeStepSize(lambda)

u1 = rand;
Delta_t = -log(u1) / lambda;

end