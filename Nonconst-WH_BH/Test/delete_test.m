function array = delete_test(index, array)

% Remove that the 'index_th' entry in the array
if length(array) == 1
    array = [];
else
    if index > 1 && index < length(array)
        array = [array(1 : index - 1), array(index + 1 : length(array))];
    else
        if index == 1
            array = array(index + 1 : length(array));
        elseif index == length(array)
            array = array(1 : length(array) - 1);
        end
    end
end
    
end