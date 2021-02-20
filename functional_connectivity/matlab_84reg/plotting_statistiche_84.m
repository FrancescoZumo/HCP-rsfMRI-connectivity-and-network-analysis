%% DATI GENERALI

% Numero soggetti, lista dei soggetti, numero regioni, volumi, TR
load('subjects.mat');
[vet_dist, vet_label, vet_color, vet_cum] = label(brain_sort_matrix, voxels);

%% COHERENCE

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg_', s_volumes, '/coherence_stat.mat');
load(percorso);

% Plottiamo ICC
plot_matrix(ICC_matrix_coh_84, strcat('ICC Coherence - ', s_volumes), [0.4 0.7], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Intra
plot_matrix(CV_intra_matrix_coh_84, strcat('CV Intra Coherence - ', s_volumes), [0 15], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Inter
plot_matrix(CV_inter_matrix_coh_84, strcat('CV Inter Coherence - ', s_volumes), [0 30], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon
plot_matrix(P_wilcoxon_matrix_coh_84, strcat('P-Wilcoxon Coherence - ', s_volumes), [0 0.05], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon - Bonferroni
plot_matrix(bonf_P_wilcoxon_matrix_coh_84, strcat('P-Wilcoxon Bonferroni Coherence - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% PEARSON

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg_', s_volumes, '/pearson_stat.mat');
load(percorso);

% Plottiamo ICC
plot_matrix(ICC_matrix_pearson_84, strcat('ICC Pearson - ', s_volumes), [0.4 0.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Intra
plot_matrix(CV_intra_matrix_pearson_84, strcat('CV Intra Pearson - ', s_volumes), [0 15], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Inter
plot_matrix(CV_inter_matrix_pearson_84, strcat('CV Inter Pearson - ', s_volumes), [0 30], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon
plot_matrix(P_wilcoxon_matrix_pearson_84, strcat('P-Wilcoxon Pearson - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon - Bonferroni
plot_matrix(bonf_P_wilcoxon_matrix_pearson_84, strcat('P-Wilcoxon Bonferroni Pearson - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% IM_COH

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg_', s_volumes, '/imcoh_stat.mat');
load(percorso);

% Plottiamo ICC
plot_matrix(ICC_matrix_imcoh_84, strcat('ICC ImCoh - ', s_volumes), [0.4 0.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Intra
plot_matrix(CV_intra_matrix_imcoh_84, strcat('CV Intra ImCoh - ', s_volumes), [0 15], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Inter
plot_matrix(CV_inter_matrix_imcoh_84, strcat('CV Inter ImCoh - ', s_volumes), [0 30], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon
plot_matrix(P_wilcoxon_matrix_imcoh_84, strcat('P-Wilcoxon ImCoh - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon - Bonferroni
plot_matrix(bonf_P_wilcoxon_matrix_imcoh_84, strcat('P-Wilcoxon Bonferroni ImCoh - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% PLV

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg_', s_volumes, '/plv_stat.mat');
load(percorso);

% Plottiamo ICC
plot_matrix(ICC_matrix_plv_84, strcat('ICC PLV - ', s_volumes), [0.4 0.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Intra
plot_matrix(CV_intra_matrix_plv_84, strcat('CV Intra PLV - ', s_volumes), [0 15], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Inter
plot_matrix(CV_inter_matrix_plv_84, strcat('CV Inter PLV - ', s_volumes), [0 30], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon
plot_matrix(P_wilcoxon_matrix_plv_84, strcat('P-Wilcoxon PLV - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon - Bonferroni
plot_matrix(bonf_P_wilcoxon_matrix_plv_84, strcat('P-Wilcoxon Bonferroni PLV - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% PLI

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg_', s_volumes, '/pli_stat.mat');
load(percorso);

% Plottiamo ICC
plot_matrix(ICC_matrix_pli_84, strcat('ICC PLI - ', s_volumes), [0.4 0.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Intra
plot_matrix(CV_intra_matrix_pli_84, strcat('CV Intra PLI - ', s_volumes), [0 15], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Inter
plot_matrix(CV_inter_matrix_pli_84, strcat('CV Inter PLI - ', s_volumes), [0 30], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon
plot_matrix(P_wilcoxon_matrix_pli_84, strcat('P-Wilcoxon PLI - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon - Bonferroni
plot_matrix(bonf_P_wilcoxon_matrix_pli_84, strcat('P-Wilcoxon Bonferroni PLI - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% WPLI

% Carichiamo la statistica
percorso = strcat('workspace_stat_84reg_', s_volumes, '/wpli_stat.mat');
load(percorso);

% Plottiamo ICC
plot_matrix(ICC_matrix_wpli_84, strcat('ICC WPLI - ', s_volumes), [0.4 0.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Intra
plot_matrix(CV_intra_matrix_wpli_84, strcat('CV Intra WPLI - ', s_volumes), [0 15], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo CV Inter
plot_matrix(CV_inter_matrix_wpli_84, strcat('CV Inter WPLI - ', s_volumes), [0 30], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon
plot_matrix(P_wilcoxon_matrix_wpli_84, strcat('P-Wilcoxon WPLI - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

% Plottiamo Wilcoxon - Bonferroni
plot_matrix(bonf_P_wilcoxon_matrix_wpli_84, strcat('P-Wilcoxon Bonferroni WPLI - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);