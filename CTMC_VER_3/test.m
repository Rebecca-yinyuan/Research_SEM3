%%

clc


N = 10^8;
summ = 0;

for i = 1 : N
    summ = summ - log(rand) / 50;
end

summ / N

%%
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

%%

clc

[t_WH, T, ~, V] = Determ_WH_driver();
T_poly = interp1(t_WH,T, 'linear','pp'); V_poly = interp1(t_WH,V, 'linear','pp');
[T_SS, ~, V_SS] = const_WH();

N = 100;
LHS_sum = V_SS * T_SS * N;
V_sum = V_SS * N;
T_sum = T_SS * N;


t = (0 : 0.1 : 15);
V_ave = zeros(size(t));
T_ave = zeros(size(t));
Theta = zeros(size(t));

for i  = 1 : length(t)
    
    V_j = ppval(V_poly, t(i)); 
    T_j = ppval(T_poly, t(i)); 
    
    V_sum = V_sum + V_j; V_ave(i) = V_sum / (N + 1);
    T_sum = T_sum + T_j; T_ave(i) = T_sum / (N + 1);
    LHS_sum = LHS_sum + V_j * T_j;
    Theta(i) = LHS_sum / (V_ave(i) * T_ave(i));
    
    LHS_sum = V_SS * T_SS * N;
    V_sum = V_SS * N;
    T_sum = T_SS * N;
    
end

figure(1000)

subplot(3, 1, 1)
plot(t, V_ave); hold on
xlabel('time');
ylabel('V_{ave}');

subplot(3, 1, 2)
plot(t, T_ave); hold on
xlabel('time');
ylabel('T_{ave}');

subplot(3, 1, 3)
scatter((N + 1) * ones(size(Theta)), Theta); hold on
xlabel('time');
ylabel('\Theta');

%Theta
