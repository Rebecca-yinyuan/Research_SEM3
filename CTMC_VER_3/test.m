N = 1000;
V = 4.3999e+06;
beta_0 = 10 ^(-8) ;
num = 1000;
sum = 0;

for j = 1 : num
    count = 0;
    for i = 1 : 1000
        if rand <= min(V * beta_0, 1)
            count = count + 1;
        end
    end
    sum = sum + count;
end

sum = sum / 1000