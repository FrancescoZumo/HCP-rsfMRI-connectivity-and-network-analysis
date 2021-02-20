%% DATI GENERALI

% Numero soggetti, lista dei soggetti, numero regioni, volumi, TR
load('subjects.mat');
[vet_dist, vet_label, vet_color, vet_cum] = label(brain_sort_matrix, voxels);

%% COHERENCE

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg/coherence_stat.mat');
load(percorso);

% Raggruppiamo nei 18 network - ICC
matrix_statistica = calc_statistica_18(ICC_matrix_coh_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'ICC', [0.4 0.5], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_intra
matrix_statistica = calc_statistica_18(CV_intra_matrix_coh_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Intra', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_inter_medio
matrix_statistica = calc_statistica_18(CV_inter_matrix_coh_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Inter', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - Wilcoxon SignRank
matrix_statistica = calc_statistica_18(P_wilcoxon_matrix_coh_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'Wilcoxon SignRank', [0.1 1], length(matrix_statistica(1,:)), vet_label);

%% PEARSON

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg/pearson_stat.mat');
load(percorso);

% Raggruppiamo nei 18 network - ICC
matrix_statistica = calc_statistica_18(ICC_matrix_pearson_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'ICC', [0.4 0.5], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_intra
matrix_statistica = calc_statistica_18(CV_intra_matrix_pearson_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Intra', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_inter_medio
matrix_statistica = calc_statistica_18(CV_inter_matrix_pearson_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Inter', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - Wilcoxon SignRank
matrix_statistica = calc_statistica_18(P_wilcoxon_matrix_pearson_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'Wilcoxon SignRank', [0.1 1], length(matrix_statistica(1,:)), vet_label);

%% IM_COH

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg/imcoh_stat.mat');
load(percorso);

% Raggruppiamo nei 18 network - ICC
matrix_statistica = calc_statistica_18(ICC_matrix_imcoh_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'ICC', [0.3 0.4], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_intra
matrix_statistica = calc_statistica_18(CV_intra_matrix_imcoh_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Intra', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_inter_medio
matrix_statistica = calc_statistica_18(CV_inter_matrix_imcoh_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Inter', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - Wilcoxon SignRank
matrix_statistica = calc_statistica_18(P_wilcoxon_matrix_imcoh_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'Wilcoxon SignRank', [0.1 1], length(matrix_statistica(1,:)), vet_label);

%% PLV

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg/plv_stat.mat');
load(percorso);

% Raggruppiamo nei 18 network - ICC
matrix_statistica = calc_statistica_18(ICC_matrix_plv_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'ICC', [0.4 0.5], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_intra
matrix_statistica = calc_statistica_18(CV_intra_matrix_plv_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Intra', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_inter_medio
matrix_statistica = calc_statistica_18(CV_inter_matrix_plv_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Inter', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - Wilcoxon SignRank
matrix_statistica = calc_statistica_18(P_wilcoxon_matrix_plv_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'Wilcoxon SignRank', [0.1 1], length(matrix_statistica(1,:)), vet_label);

%% PLI

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg/pli_stat.mat');
load(percorso);

% Raggruppiamo nei 18 network - ICCp
plot_statistics(matrix_statistica, 'ICC', [0.4 0.5], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_intra
matrix_statistica = calc_statistica_18(CV_intra_matrix_pli_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Intra', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_inter_medio
matrix_statistica = calc_statistica_18(CV_inter_matrix_pli_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Inter', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - Wilcoxon SignRank
matrix_statistica = calc_statistica_18(P_wilcoxon_matrix_pli_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'Wilcoxon SignRank', [0.1 1], length(matrix_statistica(1,:)), vet_label);

%% WPLI

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg/wpli_stat.mat');
load(percorso);

% Raggruppiamo nei 18 network - ICCp
plot_statistics(matrix_statistica, 'ICC', [0.4 0.5], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_intra
matrix_statistica = calc_statistica_18(CV_intra_matrix_wpli_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Intra', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - CV_inter_medio
matrix_statistica = calc_statistica_18(CV_inter_matrix_wpli_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'CV Inter', [0 20], length(matrix_statistica(1,:)), vet_label);

% Raggruppiamo nei 18 network - Wilcoxon SignRank
matrix_statistica = calc_statistica_18(P_wilcoxon_matrix_wpli_84, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'Wilcoxon SignRank', [0.1 1], length(matrix_statistica(1,:)), vet_label);
