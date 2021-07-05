function [t_array, S, I, Theta, T_AVE, V_AVE] = remove_interevent_data(t_array, S, I, Theta, T_AVE, V_AVE, grid_add, filename)

% initialise an array to record all the to-be-removed array elements indecies
each_remove = grid_add + 1;
file = fopen(filename);
data = textscan(file, '%d');
fclose(file);
data = cell2mat(data);
remove_index = zeros(length(data) * each_remove, 1);

j = 1;
% record each entry to be removed:
for i = 1 : length(data)
    remove_index(j : j + grid_add) = (data(i) + 1 : 1 : data(i) + grid_add + 1)';
    j = j + grid_add + 1;
end

% remove such indecies:
t_array(remove_index) = [];
S(remove_index) = [];
I(remove_index) = [];
Theta(remove_index) = [];
T_AVE(remove_index) = [];
V_AVE(remove_index) = [];

end