%% load 3 files containing Movement Regressors, CSF and WM mean signal  
load('Movement_Regressors_1180.txt');
load('CSF_meansignal.txt');
load('WM_meansignal.txt');

%% create the merged matrix
M = zeros(400,14);
M(:, 1:12)= Movement_Regressors_1180(1:400, :);
M(:, 13) = CSF_meansignal(1:400, :);
M(:, 14) = WM_meansignal(1:400, :);

%% remove mean from each column
for i = 1:14
	m = mean(M(:, i));
    M(:, i) = M(:, i) - m;
end

%% save matrix in file
dlmwrite('Regressors_part0.txt', M, 'delimiter', '\t', 'precision', '%.6f');