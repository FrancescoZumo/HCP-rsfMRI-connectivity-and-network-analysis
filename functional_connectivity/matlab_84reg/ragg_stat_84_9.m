%% DATI GENERALI

% Numero soggetti, lista dei soggetti, numero regioni, volumi, TR
load('subjects.mat');
[vet_dist, vet_label, vet_color, vet_cum] = label(brain_sort_matrix, voxels);

%% Raggruppiamo le statistiche da 84x84 a 9x9

% COHERENCE

% Carichiamo misure di statistica
percorso = strcat('workspace_stat_84reg_', s_volumes,'/coherence_stat.mat');
load(percorso);
ICC_matrix_coh_9 = ragg_84_9(ICC_matrix_coh_84, voxels, vet_cum);
CV_intra_matrix_coh_9 = ragg_84_9(CV_intra_matrix_coh_84, voxels, vet_cum);
CV_inter_matrix_coh_9 = ragg_84_9(CV_inter_matrix_coh_84, voxels, vet_cum);
P_wilcoxon_matrix_coh_9 = ragg_84_9(P_wilcoxon_matrix_coh_84, voxels, vet_cum);
fdr_P_wilcoxon_matrix_coh_9 = ragg_84_9(fdr_P_wilcoxon_matrix_coh_84, voxels, vet_cum);
% Salviamo
path_save = strcat('workspace_stat_9reg_', s_volumes, '/coherence_stat.mat');
save(path_save, 'ICC_matrix_coh_9', 'CV_intra_matrix_coh_9', ...
    'CV_inter_matrix_coh_9', 'P_wilcoxon_matrix_coh_9', 'fdr_P_wilcoxon_matrix_coh_9');

% PEARSON

% Carichiamo misure di statistica
percorso = strcat('workspace_stat_84reg_', s_volumes,'/pearson_stat.mat');
load(percorso);
% Raggruppiamo
ICC_matrix_pearson_9 = ragg_84_9(ICC_matrix_pearson_84, voxels, vet_cum);
CV_intra_matrix_pearson_9 = ragg_84_9(CV_intra_matrix_pearson_84, voxels, vet_cum);
CV_inter_matrix_pearson_9 = ragg_84_9(CV_inter_matrix_pearson_84, voxels, vet_cum);
P_wilcoxon_matrix_pearson_9 = ragg_84_9(P_wilcoxon_matrix_pearson_84, voxels, vet_cum);
fdr_P_wilcoxon_matrix_pearson_9 = ragg_84_9(fdr_P_wilcoxon_matrix_pearson_84, voxels, vet_cum);
% Salviamo
path_save = strcat('workspace_stat_9reg_', s_volumes, '/pearson_stat.mat');
save(path_save, 'ICC_matrix_pearson_9', 'CV_intra_matrix_pearson_9', ...
    'CV_inter_matrix_pearson_9', 'P_wilcoxon_matrix_pearson_9', 'fdr_P_wilcoxon_matrix_pearson_9');

% PARTIAL CORRELATION

% Carichiamo misure di statistica
percorso = strcat('workspace_stat_84reg_', s_volumes,'/pc_stat.mat');
load(percorso);
% Raggruppiamo
ICC_matrix_pc_9 = ragg_84_9(ICC_matrix_pc_84, voxels, vet_cum);
CV_intra_matrix_pc_9 = ragg_84_9(CV_intra_matrix_pc_84, voxels, vet_cum);
CV_inter_matrix_pc_9 = ragg_84_9(CV_inter_matrix_pc_84, voxels, vet_cum);
P_wilcoxon_matrix_pc_9 = ragg_84_9(P_wilcoxon_matrix_pc_84, voxels, vet_cum);
fdr_P_wilcoxon_matrix_pc_9 = ragg_84_9(fdr_P_wilcoxon_matrix_pc_84, voxels, vet_cum);
% Salviamo
path_save = strcat('workspace_stat_9reg_', s_volumes, '/pc_stat.mat');
save(path_save, 'ICC_matrix_pc_9', 'CV_intra_matrix_pc_9', ...
    'CV_inter_matrix_pc_9', 'P_wilcoxon_matrix_pc_9', 'fdr_P_wilcoxon_matrix_pc_9');


% PLV

% Carichiamo misure di statistica
percorso = strcat('workspace_stat_84reg_', s_volumes,'/plv_stat.mat');
load(percorso);
% Raggruppiamo
ICC_matrix_plv_9 = ragg_84_9(ICC_matrix_plv_84, voxels, vet_cum);
CV_intra_matrix_plv_9 = ragg_84_9(CV_intra_matrix_plv_84, voxels, vet_cum);
CV_inter_matrix_plv_9 = ragg_84_9(CV_inter_matrix_plv_84, voxels, vet_cum);
P_wilcoxon_matrix_plv_9 = ragg_84_9(P_wilcoxon_matrix_plv_84, voxels, vet_cum);
fdr_P_wilcoxon_matrix_plv_9 = ragg_84_9(fdr_P_wilcoxon_matrix_plv_84, voxels, vet_cum);
% Salviamo
path_save = strcat('workspace_stat_9reg_', s_volumes, '/plv_stat.mat');
save(path_save, 'ICC_matrix_plv_9', 'CV_intra_matrix_plv_9', ...
    'CV_inter_matrix_plv_9', 'P_wilcoxon_matrix_plv_9', 'fdr_P_wilcoxon_matrix_plv_9');

% PLI

% Carichiamo misure di statistica
percorso = strcat('workspace_stat_84reg_', s_volumes,'/pli_stat.mat');
load(percorso);
% Raggruppiamo
ICC_matrix_pli_9 = ragg_84_9(ICC_matrix_pli_84, voxels, vet_cum);
CV_intra_matrix_pli_9 = ragg_84_9(CV_intra_matrix_pli_84, voxels, vet_cum);
CV_inter_matrix_pli_9 = ragg_84_9(CV_inter_matrix_pli_84, voxels, vet_cum);
P_wilcoxon_matrix_pli_9 = ragg_84_9(P_wilcoxon_matrix_pli_84, voxels, vet_cum);
fdr_P_wilcoxon_matrix_pli_9 = ragg_84_9(fdr_P_wilcoxon_matrix_pli_84, voxels, vet_cum);
% Salviamo
path_save = strcat('workspace_stat_9reg_', s_volumes, '/pli_stat.mat');
save(path_save, 'ICC_matrix_pli_9', 'CV_intra_matrix_pli_9', ...
    'CV_inter_matrix_pli_9', 'P_wilcoxon_matrix_pli_9', 'fdr_P_wilcoxon_matrix_pli_9');

% W-PLI

% Carichiamo misure di statistica
percorso = strcat('workspace_stat_84reg_', s_volumes,'/wpli_stat.mat');
load(percorso);
% Raggruppiamo
ICC_matrix_wpli_9 = ragg_84_9(ICC_matrix_wpli_84, voxels, vet_cum);
CV_intra_matrix_wpli_9 = ragg_84_9(CV_intra_matrix_wpli_84, voxels, vet_cum);
CV_inter_matrix_wpli_9 = ragg_84_9(CV_inter_matrix_wpli_84, voxels, vet_cum);
P_wilcoxon_matrix_wpli_9 = ragg_84_9(P_wilcoxon_matrix_wpli_84, voxels, vet_cum);
fdr_P_wilcoxon_matrix_wpli_9 = ragg_84_9(fdr_P_wilcoxon_matrix_wpli_84, voxels, vet_cum);
% Salviamo
path_save = strcat('workspace_stat_9reg_', s_volumes, '/wpli_stat.mat');
save(path_save, 'ICC_matrix_wpli_9', 'CV_intra_matrix_wpli_9', ...
    'CV_inter_matrix_wpli_9', 'P_wilcoxon_matrix_wpli_9', 'fdr_P_wilcoxon_matrix_wpli_9');
