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

N = 80;
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

%%

clc

set(0,'defaultAxesFontSize',30); set(gca,'FontSize',30);
set(0, 'DefaultLineLineWidth', 2); 
set(findall(gcf,'-property','FontSize'),'FontSize',30)

[t_WH, T, ~, V] = Determ_WH_driver();
T_poly = interp1(t_WH,T, 'linear','pp'); V_poly = interp1(t_WH,V, 'linear','pp');

t = (6 : 1 : 10^6);
V_num = ppval(V_poly, t); T_num = ppval(T_poly, t); V_num(length(V_num))
figure(1)
subplot(1, 2, 1)
plot(t, V_num); hold on
xlabel('t(days)'); ylabel('V')
%a2 = axes();
%a2.Position = [0.15 0.6000 0.2 0.2];
%xlabel('t(days)'); ylabel('V'); 
%plot(a2, t(1 : 3 * 10^3), V_num(1 : 3 * 10^3)); axis tight
%annotation('arrow',[.18 .28],[.3 .56])
%annotation('ellipse',[.13 .2 .1 .1])

subplot(1, 2, 2)
plot(t, T_num); xlabel('t(days)'); ylabel('T')


%%
r1 = [1:100]'.*rand(100,1);
figure;
a1 = axes();
plot(a1,r1);
a2 = axes();
a2.Position = [0.3200 0.6600 0.2 0.2]; % xlocation, ylocation, xsize, ysize
plot(a2,r1(50:70)); axis tight
annotation('ellipse',[.2 .3 .2 .2])
annotation('arrow',[.1 .32],[.1 .66])
legend(a1,'u')

%%

driver()

function driver()
    test_2('V_missinfo.txt', 'TT_missinfo.txt', 'Theta_missinfo.txt', ...
        't_missinfo.txt', 'I_missinfo.txt', 'b')
end

function test_2(Vfile_missinfo, TTfile_missinfo, Thetafile_missinfo, tfile_missinfo, Ifile_missinfo, color)

% When inter-event info is included:
% We obtain 6 arrays: V_m, T_m, Theta_m, t_m, S_m, I_m
Vf_missinfo = fopen(Vfile_missinfo); V_m = textscan(Vf_missinfo, '%f'); 
fclose(Vf_missinfo); V_m = cell2mat(V_m);
TTf_missinfo = fopen(TTfile_missinfo); T_m = textscan(TTf_missinfo, '%f'); 
fclose(TTf_missinfo); T_m = cell2mat(T_m);
Thetaf_missinfo = fopen(Thetafile_missinfo); Theta_m = textscan(Thetaf_missinfo, '%f'); 
fclose(Thetaf_missinfo); Theta_m = cell2mat(Theta_m);
tf_missinfo = fopen(tfile_missinfo); t_m = textscan(tf_missinfo, '%f'); 
fclose(tf_missinfo); t_m = cell2mat(t_m);
If_missinfo = fopen(Ifile_missinfo); I_m = textscan(If_missinfo, '%f'); 
fclose(If_missinfo); I_m = cell2mat(I_m);

V_ave = zeros(10002, 1); T_ave = zeros(10002, 1); tt = zeros(10002, 1);
TTheta = zeros(10002, 1); II = zeros(10002, 1);

V_ave = V_m(91 : 10092); T_ave = T_m(91 : 10092); tt = t_m(91 : 10092);
TTheta = Theta_m(91 : 10092); II = I_m(91 : 10092);

%-----------------------------------------------------------------------
% Data visualisation: When inter-event info is included:

% dynamics of the initial disease transmission period
figure(1)
subplot(1, 3, 1)
plot(tt, V_ave, strcat(color, 'o-')); hold on
xlabel('t (days)'); ylabel('V_{ave}');

subplot(1, 3, 2)
plot(tt, T_ave, strcat(color, 'o-')); hold on
xlabel('t (days)'); ylabel('T_{ave}');

subplot(1, 3, 3)
c = linspace(1,length(II),length(II)); 
sc1 = 80;
%for i = 1 : length(II)
%    II(i) = II(i) + (i - 1) * 0.1;
%end
scatter(II, TTheta, sc1, c, 'filled'); hold on
xlabel('I(t)'); ylabel('$$\Theta(I)$$', 'interpreter', 'latex'); 

end





