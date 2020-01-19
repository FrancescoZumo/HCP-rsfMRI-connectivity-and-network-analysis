function regressors(path2res)
    %change path
    cd(path2res);
    % load 3 files containing Movement Regressors, CSF and WM mean signal  
    load('Movement_Regressors_1180.txt');
    load('CSF_meansignal.txt');
    load('WM_meansignal.txt');

    %% create the merged matrix
    M = zeros(1180,14);
    M(:, 1:12)= Movement_Regressors_1180;
    M(:, 13) = CSF_meansignal;
    M(:, 14) = WM_meansignal;

    %% remove mean from each column
    for i = 1:14
        m = mean(M(:, i));
        %disp(m);
        M(:, i) = M(:, i) - m;
        m = mean(M(:, i));
        %disp(m);
    end

    %% save matrix in file
    dlmwrite('Regressors.txt',M, 'delimiter', '\t','precision','%.6f');
end