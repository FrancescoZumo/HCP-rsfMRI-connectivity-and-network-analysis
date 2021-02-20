%% DATI GENERALI

% Numero soggetti, lista dei soggetti, numero regioni, volumi, TR
load('subjects.mat');
[vet_dist, vet_label, vet_color, vet_cum] = label(brain_sort_matrix, voxels);


%% PLOTTING MEDIA 1200

percorso = strcat('workspace_84reg_', s_volumes,'/1200/ws_1200_medio.mat');
load(percorso);

% Plottiamo MS-Coherence
plot_matrix(coherence_matrix1, strcat('MS-Coherence 1200 - ', s_volumes), [0.1 0.8], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson
plot_matrix(corr_pearson1, strcat('Correlazione di Pearson 1200 - ', s_volumes), [-0.4 0.9], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson 2
plot_matrix(corr_pearson1_valzero, strcat('Correlazione di Pearson 2 1200 - ', s_volumes), [0 0.9], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency
plot_matrix(img_coherency_matrix1, strcat('Imaginery Coherency 1200 - ', s_volumes), [-0.2 0.2], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency 2
plot_matrix(img_coherency_matrix1_val_abs_zero, strcat('Imaginery Coherency 2 1200 - ', s_volumes), [0 0.2], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLV
plot_matrix(plv_matrix1, strcat('PLV 1200 - ', s_volumes), [0.15 0.8], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(pli_matrix1, strcat('PLI 1200 - ', s_volumes), [0.05 0.19], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo WPLI
plot_matrix(wpli_matrix1, strcat('W-PLI 1200 - ', s_volumes), [0.04 0.13], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation
plot_matrix(pc_matrix1, strcat('Partial Correlation 1200 - ', s_volumes), [-0.2 0.4], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation 2
plot_matrix(pc_matrix1_valzero, strcat('Partial Correlation 2 1200 - ', s_volumes), [0 0.4], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5
plot_matrix(pc_t2_matrix1, strcat('Partial Correlation T2 r=0.5 1200 - ', s_volumes), [-0.1 0.2], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5 2
plot_matrix(pc_t2_matrix1_valzero, strcat('Partial Correlation T2 r=0.5 2 1200 - ', s_volumes), [0 0.23], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% PLOTTING MEDIA RETEST

percorso = strcat('workspace_84reg_', s_volumes,'/retest/ws_retest_medio.mat');
load(percorso);

% Plottiamo MS-Coherence
plot_matrix(coherence_matrix2, strcat('MS-Coherence retest - ', s_volumes), [0.1 0.8], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson
plot_matrix(corr_pearson2, strcat('Correlazione di Pearson retest - ', s_volumes), [0.4 0.9], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson 2
plot_matrix(corr_pearson2_valzero, strcat('Correlazione di Pearson 2 retest - ', s_volumes), [0 0.9], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency
plot_matrix(img_coherency_matrix2, strcat('Imaginery Coherency retest - ', s_volumes), [-0.35 0.35], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency 2
plot_matrix(img_coherency_matrix2_val_abs_zero, strcat('Imaginery Coherency 2 retest - ', s_volumes), [0 0.35], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLV
plot_matrix(plv_matrix2, strcat('PLV retest - ', s_volumes), [0.15 0.8], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(pli_matrix2, strcat('PLI retest - ', s_volumes), [0.05 0.19], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo WPLI
plot_matrix(wpli_matrix2, strcat('W-PLI retest - ', s_volumes), [0.04 0.13], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation
plot_matrix(pc_matrix2, strcat('Partial Correlation retest - ', s_volumes), [-0.2 0.4], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation 2
plot_matrix(pc_matrix2_valzero, strcat('Partial Correlation 2 retest - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5
plot_matrix(pc_t2_matrix2, strcat('Partial Correlation T2 r=0.5 retest - ', s_volumes), [-0.1 0.2], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5 2
plot_matrix(pc_t2_matrix2_valzero, strcat('Partial Correlation T2 r=0.5 2 retest - ', s_volumes), [0 0.23], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% PLOTTING MEGAMIX

percorso = strcat('workspace_84reg_', s_volumes,'/ws_all_medio.mat');
load(percorso);

% Plottiamo MS-Coherence
plot_matrix(coherence_matrix3, strcat('MS-Coherence megamix - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson
plot_matrix(corr_pearson3, strcat('Correlazione di Pearson megamix - ', s_volumes), [-1 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson 2
plot_matrix(corr_pearson3_valzero, strcat('Correlazione di Pearson 2 megamix - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency
plot_matrix(img_coherency_matrix3, strcat('Imaginery Coherency megamix - ', s_volumes), [-0.35 0.35], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency 2
plot_matrix(img_coherency_matrix3_val_abs_zero, strcat('Imaginery Coherency 2 megamix - ', s_volumes), [0 0.35], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLV
plot_matrix(plv_matrix3, strcat('PLV megamix - ', s_volumes), [0 0.8], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(pli_matrix3, strcat('PLI megamix - ', s_volumes), [0 0.25], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo WPLI
plot_matrix(wpli_matrix3, strcat('W-PLI megamix - ', s_volumes), [0 0.2], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation
plot_matrix(pc_matrix3, strcat('Partial Correlation megamix - ', s_volumes), [-1 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation 2
plot_matrix(pc_matrix3_valzero, strcat('Partial Correlation 2 megamix - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5
plot_matrix(pc_t2_matrix3, strcat('Partial Correlation T2 r=0.5 megamix - ', s_volumes), [-0.1 0.2], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5 2
plot_matrix(pc_t2_matrix3_valzero, strcat('Partial Correlation T2 r=0.5 2 megamix - ', s_volumes), [0 0.2], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% PLOTTING MEDIA 1200 NORMALIZZATA

percorso = strcat('workspace_84reg_', s_volumes,'_norm/1200/ws_1200_medio_norm.mat');
load(percorso);

% Plottiamo MS-Coherence
plot_matrix(coherence_matrix1_norm, strcat('MS-Coherence 1200 _norm - ', s_volumes), [0 3.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson
plot_matrix(corr_pearson1_norm, strcat('Correlazione di Pearson 1200 _norm - ', s_volumes), [-5 10], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson 2
plot_matrix(corr_pearson1_valzero_norm, strcat('Correlazione di Pearson 2 1200 _norm - ', s_volumes), [0 5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency
plot_matrix(img_coherency_matrix1_norm, strcat('Imaginery Coherency 1200 _norm - ', s_volumes), [-100 100], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency 2
plot_matrix(img_coherency_matrix1_val_abs_zero_norm, strcat('Imaginery Coherency 2 1200 _norm - ', s_volumes), [0 100], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLV
plot_matrix(plv_matrix1_norm, strcat('PLV 1200 _norm - ', s_volumes), [0 2.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(pli_matrix1_norm, strcat('PLI 1200 _norm - ', s_volumes), [0.8 1.7], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo WPLI
plot_matrix(wpli_matrix1_norm, strcat('W-PLI 1200 _norm - ', s_volumes), [0.8 1.8], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation
plot_matrix(pc_matrix1_norm, strcat('Partial Correlation 1200 _norm - ', s_volumes), [-10 10], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation 2
plot_matrix(pc_matrix1_valzero_norm, strcat('Partial Correlation 2 1200 _norm - ', s_volumes), [0 4], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5
plot_matrix(pc_t2_matrix1_norm, strcat('Partial Correlation T2 r=0.5 1200 _norm - ', s_volumes), [-5 10], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5 2
plot_matrix(pc_t2_matrix1_valzero_norm, strcat('Partial Correlation T2 r=0.5 2 1200 _norm - ', s_volumes), [0 5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% PLOTTING MEDIA RETEST NORMALIZZATA

percorso = strcat('workspace_84reg_', s_volumes,'_norm/retest/ws_retest_medio_norm.mat');
load(percorso);

% Plottiamo MS-Coherence
plot_matrix(coherence_matrix2_norm, strcat('MS-Coherence retest _norm - ', s_volumes), [0 3.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson
plot_matrix(corr_pearson2_norm, strcat('Correlazione di Pearson retest _norm - ', s_volumes), [-5 10], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson 2
plot_matrix(corr_pearson2_valzero_norm, strcat('Correlazione di Pearson 2 retest _norm - ', s_volumes), [0 5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency
plot_matrix(img_coherency_matrix2_norm, strcat('Imaginery Coherency retest _norm - ', s_volumes), [-100 100], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency 2
plot_matrix(img_coherency_matrix2_val_abs_zero_norm, strcat('Imaginery Coherency 2 retest _norm - ', s_volumes), [0 100], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLV
plot_matrix(plv_matrix2_norm, strcat('PLV retest _norm - ', s_volumes), [0 2.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(pli_matrix2_norm, strcat('PLI retest _norm - ', s_volumes), [0.8 1.7], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo WPLI
plot_matrix(wpli_matrix2_norm, strcat('W-PLI retest _norm - ', s_volumes), [0.8 1.8], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation
plot_matrix(pc_matrix2_norm, strcat('Partial Correlation retest _norm - ', s_volumes), [-10 10], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation 2
plot_matrix(pc_matrix2_valzero_norm, strcat('Partial Correlation 2 retest _norm - ', s_volumes), [0 5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5
plot_matrix(pc_t2_matrix2_norm, strcat('Partial Correlation T2 r=0.5 retest _norm - ', s_volumes), [-5 10], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5 2
plot_matrix(pc_t2_matrix2_valzero_norm, strcat('Partial Correlation T2 r=0.5 2 retest _norm - ', s_volumes), [0 5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% PLOTTING MEGAMIX NORMALIZZATO

percorso = strcat('workspace_84reg_', s_volumes,'_norm/ws_all_medio_norm.mat');
load(percorso);

% Plottiamo MS-Coherence
plot_matrix(coherence_matrix3_norm, strcat('MS-Coherence megamix _norm - ', s_volumes), [0 3.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson
plot_matrix(corr_pearson3_norm, strcat('Correlazione di Pearson megamix _norm - ', s_volumes), [-10 10], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson 2
plot_matrix(corr_pearson3_valzero_norm, strcat('Correlazione di Pearson 2 megamix _norm - ', s_volumes), [0 4], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency
plot_matrix(img_coherency_matrix3_norm, strcat('Imaginery Coherency megamix _norm - ', s_volumes), [-20 20], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency 2
plot_matrix(img_coherency_matrix3_val_abs_zero_norm, strcat('Imaginery Coherency 2 megamix _norm - ', s_volumes), [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLV
plot_matrix(plv_matrix3_norm, strcat('PLV megamix _norm - ', s_volumes), [0 2.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(pli_matrix3_norm, strcat('PLI megamix _norm - ', s_volumes), [0 1.7], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo WPLI
plot_matrix(wpli_matrix3_norm, strcat('W-PLI megamix _norm - ', s_volumes), [0 1.8], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation
plot_matrix(pc_matrix3_norm, strcat('Partial Correlation megamix _norm - ', s_volumes), [-10 10], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation 2
plot_matrix(pc_matrix3_valzero_norm, strcat('Partial Correlation 2 megamix _norm - ', s_volumes), [0 5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5
plot_matrix(pc_t2_matrix3_norm, strcat('Partial Correlation T2 r=0.5 megamix _norm - ', s_volumes), [-5 10], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Partial Correlation T2 r=0.5 2
plot_matrix(pc_t2_matrix3_valzero_norm, strcat('Partial Correlation T2 r=0.5 2 megamix _norm - ', s_volumes), [0 5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
