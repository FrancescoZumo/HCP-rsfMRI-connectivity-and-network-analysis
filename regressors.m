%load 3 files containing Movement Regressors, CSF and WM mean signal  
load('../Movement_Regressors_1180.txt');
load('../CSF_meansignal.txt');
load('../WM_meansignal.txt');

%create the merged matrix
M = zeros(1180,14);
