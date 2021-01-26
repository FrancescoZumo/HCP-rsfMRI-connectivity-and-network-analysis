% Author: Francesco Zumerle, Universty of Verona

function choose_reorganization(input_name, networks_name, reorganization_name)
   
%% CHOOSE REORGANIZATION

    % load input file
    input = load(input_name);
    
    % create output matrix
    R = zeros(84, 1);
    
    % for each row, choose most frequent number (mode)
    for i = 1:numel(input(:, 1))
        % for cortical regions, the same network has to be chosen for both
        % hemispheres
        if i <= 35
            T = [input(i, :), input(i + 49, :)];
            R(i) = mode(T);
        elseif i <= 49
            R(i) = mode(input(i, :));
        else
            T = [input(i, :), input(i - 49, :)];
            R(i) = mode(T);
        end
    end
    
    % save output in file with output_name
    dlmwrite(networks_name, R, 'delimiter', '\t');
    
%% CREATE REORGANIZATION MATRIX
    
    left = 1;
    right = 43;    

    % regions are reoragnized in networks, keeping left & right divided
    T = zeros(84, 1);
    for net = 1:7
        for i = 1:84
            if R(i) == net
                if i <= 42
                    T(left) = i;
                    left = left + 1;
                else
                    T(right) = i;
                    right = right + 1;
                end
            end
        end
    end

    % Finally, adding ignored regions (value == 0)
    for i = 1:84
        if R(i) == 0 && i <= 42
            T(left) = i;
            left = left + 1;
        elseif R(i) == 0 && i > 42
            T(right) = i;
            right = right + 1;
        end
    end
    
    dlmwrite(reorganization_name, T, 'delimiter', '\t');
end