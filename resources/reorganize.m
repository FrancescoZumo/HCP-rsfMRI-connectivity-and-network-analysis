function reorganize(signals, reorganization, output)
    
    % load files
    S_old = load(signals);
    R = load(reorganization);
    
    % create new signal matrix
    S_new = S_old;
    S_new(:) = 0;

    %%cycle through each column and move to its new place
    for i = 1:84
        S_new(:, i) = S_old(:, R(i));
    end
    
    % save result
    dlmwrite(output, S_new, 'delimiter', '\t', 'precision', '%.6f');
end