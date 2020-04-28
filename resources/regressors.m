function regressors(volumes)
    %% load 3 files containing Movement Regressors, CSF and WM mean signal  
    Movement_Regressors_1180 = load('Movement_Regressors_1180.txt');
    CSF_meansignal = load('CSF_meansignal.txt');
    WM_meansignal = load('WM_meansignal.txt');

    %% create the merged matrix
    R = zeros(volumes,14);
    R(:, 1:12)= Movement_Regressors_1180(1:volumes, :);
    R(:, 13) = CSF_meansignal(1:volumes, :);
    R(:, 14) = WM_meansignal(1:volumes, :);

    %% remove mean from each column
    for i = 1:14
        m = mean(R(:, i));
        R(:, i) = R(:, i) - m;
    end

    %% save matrix in file
    dlmwrite('Regressors.txt', R, 'delimiter', '\t', 'precision', '%.6f');
end