function data_visualisation(Sfile, Ifile, tfile, Thetafile, ...
    Vfile_missinfo, TTfile_missinfo, Thetafile_missinfo, tfile_missinfo, ...
    Sfile_missinfo, Ifile_missinfo, j, color)

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
Sf_missinfo = fopen(Sfile_missinfo); S_m = textscan(Sf_missinfo, '%f'); 
fclose(Sf_missinfo); S_m = cell2mat(S_m);
If_missinfo = fopen(Ifile_missinfo); I_m = textscan(If_missinfo, '%f'); 
fclose(If_missinfo); I_m = cell2mat(I_m);

% When inter-event info is not included:
% We obtain 4 arrays: S, I, t, Theta
Sf = fopen(Sfile); S = textscan(Sf, '%f'); fclose(Sf); S = cell2mat(S);
If = fopen(Ifile); I = textscan(If, '%f'); fclose(If); I = cell2mat(I);
tf = fopen(tfile); t = textscan(tf, '%f'); fclose(tf); t = cell2mat(t);
Thetaf = fopen(Thetafile); Theta = textscan(Thetaf, '%f'); 
fclose(Thetaf); Theta = cell2mat(Theta);

%-----------------------------------------------------------------------
% Data visualisation: When inter-event info is included:

index = find(S_m == 0, 1 ); t_decade = t_m(index); 
% dynamics of the initial disease transmission period
figure(j)
subplot(1, 3, 1)
opt = append(color, '*--');
plot(t_m(1 : index + 1), S_m(1 : index + 1), strcat(color, 'o-')); hold on
plot(t_m(1 : index + 1), I_m(1 : index + 1), opt); hold on
xline(t_decade, '-.','LineWidth', 1.2); hold on
%xl = xline(t_decade, '-.', 'S = 0','LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
xlabel('t (days)'); ylabel('Population (numbers)');
legend('S(t)', 'I(t)', 'S = 0');

subplot(1, 3, 2)
plot(t_m(1 : index + 1), V_m(1 : index + 1), strcat(color, 'o-')); hold on
xline(t_decade, '-.','LineWidth', 1.2); hold on
%xl = xline(t_decade, '-.', 'S = 0', 'LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
xlabel('t (days)'); ylabel('V_{ave}'); legend('V_{ave}', 'S = 0');

subplot(1, 3, 3)
plot(t_m(1 : index + 1), T_m(1 : index + 1), strcat(color, 'o-')); hold on
xline(t_decade, '-.','LineWidth', 1.2); hold on
%xl = xline(t_decade, '-.', 'S = 0', 'LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
xlabel('t (days)'); ylabel('T_{ave}'); legend('T_{ave}', 'S = 0');


% dynamics of the transition period
figure(j + 1)
subplot(1, 3, 1)
opt = append(color,'*--');
plot(t_m(index - 15 : index + 10), S_m(index - 15 : index + 10), strcat(color, 'o-')); hold on
plot(t_m(index - 15 : index + 10), I_m(index - 15 : index + 10), opt); hold on
xline(t_decade, '-.','LineWidth', 1.2); hold on
xline(t_decade, '-.', 'LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
xlabel('t (days)'); ylabel('Population (numbers)');
legend('S(t)', 'I(t)', 'S = 0');

subplot(1, 3, 2)
plot(t_m(index - 15 : index + 10), V_m(index - 15 : index + 10), strcat(color, 'o-')); hold on
xline(t_decade, '-.', 'LineWidth', 1.2); hold on
%xl = xline(t_decade, '-.', 'S = 0', 'LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
xlabel('t (days)'); ylabel('V_{ave}'); legend('V_{ave}', 'S = 0');

subplot(1, 3, 3)
plot(t_m(index - 15 : index + 10), T_m(index - 15 : index + 10), strcat(color, 'o-')); hold on
xline(t_decade, '-.', 'LineWidth', 1.2); hold on
%xl = xline(t_decade, '-.', 'S = 0', 'LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
xlabel('t (days)'); ylabel('T_{ave}'); legend('T_{ave}', 'S = 0');


% overal dynamics:
figure(j + 2)
subplot(1, 3, 1)
opt = append(color,'--');
plot(t_m, S_m, color); hold on
plot(t_m, I_m, opt); hold on
xline(t_decade, '-.', 'LineWidth', 1.2); hold on
%xl = xline(t_decade, '-.', 'S = 0', 'LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
xlabel('t (days)'); ylabel('Population (numbers)'); 
legend('S(t)', 'I(t)', 'S = 0');

subplot(1, 3, 2)
plot(t_m, V_m, strcat(color, '-')); hold on
xline(t_decade, '-.', 'LineWidth', 1.2); hold on
%xl = xline(t_decade, '-.', 'S = 0', 'LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
xlabel('t (days)'); ylabel('V_{ave}'); legend('V_{ave}', 'S = 0');

subplot(1, 3, 3)
plot(t_m, T_m, strcat(color, '-')); hold on
xline(t_decade, '-.', 'LineWidth', 1.2); hold on
%xl = xline(t_decade, '-.', 'S = 0', 'LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
xlabel('t (days)'); ylabel('T_{ave}'); legend('T_{ave}', 'S = 0');


%-----------------------------------------------------------------------
% Data visualisation: When inter-event info is NOT included:

index = find(S == 0, 1 ); I_decade = I(index); 
c = linspace(1,length(I),length(I)); 

% theta of the initial disease transmission period
figure(j + 3)
subplot(1, 2, 1)
sc1 = 80; %100; 
sc2 = 80;
%xline(t_decade, '-.', 'LineWidth', 1.2); hold on
%xl = xline(I_decade, '-.', 'S = 0', 'LineWidth', 1.2); hold on
%xl.LabelHorizontalAlignment = 'left';
%xl.LabelVerticalAlignment = 'middle';
c1 = c(1 : index); 
scatter(I(1 : index), Theta(1 : index), sc1, c1, 'filled'); hold on
%scatter(I(index + 1 : end), Theta(index + 1 : end), sc2, c(index + 1 : end), 'filled'); hold on
scatter(I(index + 1 : end), Theta(index + 1 : end) + 8, sc2); hold on
xlabel('I(t)'); ylabel('$$\Theta(I)$$', 'interpreter', 'latex'); 
title('Initial Period');

% theta of the later period
subplot(1, 2, 2)
c2 = c(index + 1 : end);
scatter(I(1 : index), Theta(1 : index) - 8, sc1); hold on
scatter(I(index + 1 : end), Theta(index + 1 : end), sc2, c2, 'filled'); hold on
xlabel('I(t)'); ylabel('$$\Theta(I)$$', 'interpreter', 'latex'); 
title('Later Period')

end