function custom_sort(filename, order_table, output_name)
    file = load(filename);
    order = load(order_table);
    order = 
    for i = 1:numel(file)
        for j = 1:numel(file)
           if file(j, 1) == order(i, 1)
        end
    end
end