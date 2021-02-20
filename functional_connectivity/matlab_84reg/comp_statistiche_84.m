%% Time-Series

load('subjects.mat');

%% Computazione


% Coherence
ICC_matrix_coh_84 = ICC_coh_84(voxels);
CV_intra_matrix_coh_84 = cv_intra_coh_84(voxels);
[CV_inter_matrix_1200_coh_84, CV_inter_matrix_retest_coh_84, CV_inter_matrix_coh_84] = CV_inter_coh_84(voxels);
[P_wilcoxon_matrix_coh_84, H_wilcoxon_matrix_coh_84] = wilcoxon_coh_84(voxels);
[bonf_P_wilcoxon_matrix_coh_84, bonf_H_wilcoxon_matrix_coh_84] = bonferroni_test(P_wilcoxon_matrix_coh_84, voxels);
[fdr_H_wilcoxon_matrix_coh_84, b, c, fdr_P_wilcoxon_matrix_coh_84] = fdr_bh(P_wilcoxon_matrix_coh_84, 0.05, 'dep', 'no');

path_save = strcat('workspace_stat_84reg_', s_volumes, '/coherence_stat.mat');
save(path_save, 'ICC_matrix_coh_84', 'CV_intra_matrix_coh_84', 'CV_inter_matrix_1200_coh_84',...
    'CV_inter_matrix_retest_coh_84', 'CV_inter_matrix_coh_84', 'P_wilcoxon_matrix_coh_84',...
    'H_wilcoxon_matrix_coh_84', 'bonf_P_wilcoxon_matrix_coh_84', 'bonf_H_wilcoxon_matrix_coh_84', ...
    'fdr_H_wilcoxon_matrix_coh_84', 'fdr_P_wilcoxon_matrix_coh_84');

% Pearson
ICC_matrix_pearson_84 = ICC_pearson_84(voxels);
CV_intra_matrix_pearson_84 = cv_intra_pearson_84(voxels);
[CV_inter_matrix_1200_pearson_84, CV_inter_matrix_retest_pearson_84, CV_inter_matrix_pearson_84] = CV_inter_pearson_84(voxels);
[P_wilcoxon_matrix_pearson_84, H_wilcoxon_matrix_pearson_84] = wilcoxon_pearson_84(voxels);
[bonf_P_wilcoxon_matrix_pearson_84, bonf_H_wilcoxon_matrix_pearson_84] = bonferroni_test(P_wilcoxon_matrix_pearson_84, voxels);
[fdr_H_wilcoxon_matrix_pearson_84, b, c, fdr_P_wilcoxon_matrix_pearson_84] = fdr_bh(P_wilcoxon_matrix_pearson_84, 0.05, 'dep', 'no');

path_save = strcat('workspace_stat_84reg_', s_volumes, '/pearson_stat.mat');
save(path_save, 'ICC_matrix_pearson_84', 'CV_intra_matrix_pearson_84', 'CV_inter_matrix_1200_pearson_84',...
    'CV_inter_matrix_retest_pearson_84', 'CV_inter_matrix_pearson_84', 'P_wilcoxon_matrix_pearson_84',...
    'H_wilcoxon_matrix_pearson_84', 'bonf_P_wilcoxon_matrix_pearson_84', 'bonf_H_wilcoxon_matrix_pearson_84', ...
    'fdr_H_wilcoxon_matrix_pearson_84', 'fdr_P_wilcoxon_matrix_pearson_84');


% Partial Correlation
ICC_matrix_pc_84 = ICC_pc_84(voxels);
CV_intra_matrix_pc_84 = cv_intra_pc_84(voxels);
[CV_inter_matrix_1200_pc_84, CV_inter_matrix_retest_pc_84, CV_inter_matrix_pc_84] = CV_inter_pc_84(voxels);
[P_wilcoxon_matrix_pc_84, H_wilcoxon_matrix_pc_84] = wilcoxon_pc_84(voxels);
[bonf_P_wilcoxon_matrix_pc_84, bonf_H_wilcoxon_matrix_pc_84] = bonferroni_test(P_wilcoxon_matrix_pc_84, voxels);
[fdr_H_wilcoxon_matrix_pc_84, b, c, fdr_P_wilcoxon_matrix_pc_84] = fdr_bh(P_wilcoxon_matrix_pc_84, 0.05, 'dep', 'no');


path_save = strcat('workspace_stat_84reg_', s_volumes, '/pc_stat.mat');
save(path_save, 'ICC_matrix_pc_84', 'CV_intra_matrix_pc_84', 'CV_inter_matrix_1200_pc_84',...
    'CV_inter_matrix_retest_pc_84', 'CV_inter_matrix_pc_84', 'P_wilcoxon_matrix_pc_84',...
    'H_wilcoxon_matrix_pc_84', 'bonf_P_wilcoxon_matrix_pc_84', 'bonf_H_wilcoxon_matrix_pc_84', ...
    'fdr_H_wilcoxon_matrix_pc_84', 'fdr_P_wilcoxon_matrix_pc_84');
    

% PLV
ICC_matrix_plv_84 = ICC_plv_84(voxels);
CV_intra_matrix_plv_84 = cv_intra_plv_84(voxels);
[CV_inter_matrix_1200_plv_84, CV_inter_matrix_retest_plv_84, CV_inter_matrix_plv_84] = CV_inter_plv_84(voxels);
[P_wilcoxon_matrix_plv_84, H_wilcoxon_matrix_plv_84] = wilcoxon_plv_84(voxels);
[bonf_P_wilcoxon_matrix_plv_84, bonf_H_wilcoxon_matrix_plv_84] = bonferroni_test(P_wilcoxon_matrix_plv_84, voxels);
[fdr_H_wilcoxon_matrix_plv_84, b, c, fdr_P_wilcoxon_matrix_plv_84] = fdr_bh(P_wilcoxon_matrix_plv_84, 0.05, 'dep', 'no');

path_save = strcat('workspace_stat_84reg_', s_volumes, '/plv_stat.mat');
save(path_save, 'ICC_matrix_plv_84', 'CV_intra_matrix_plv_84', 'CV_inter_matrix_1200_plv_84',...
    'CV_inter_matrix_retest_plv_84', 'CV_inter_matrix_plv_84', 'P_wilcoxon_matrix_plv_84',...
    'H_wilcoxon_matrix_plv_84', 'bonf_P_wilcoxon_matrix_plv_84', 'bonf_H_wilcoxon_matrix_plv_84', ...
    'fdr_H_wilcoxon_matrix_plv_84', 'fdr_P_wilcoxon_matrix_plv_84');

%{
% Imag Coherency
ICC_matrix_imcoh_84 = ICC_imcoh_84(voxels);
CV_intra_matrix_imcoh_84 = cv_intra_imcoh_84(voxels);
[CV_inter_matrix_1200_imcoh_84, CV_inter_matrix_retest_imcoh_84, CV_inter_matrix_imcoh_84] = CV_inter_imcoh_84(voxels);
[P_wilcoxon_matrix_imcoh_84, H_wilcoxon_matrix_imcoh_84] = wilcoxon_imcoh_84(voxels);
[bonf_P_wilcoxon_matrix_imcoh_84, bonf_H_wilcoxon_matrix_imcoh_84] = bonferroni_test(P_wilcoxon_matrix_imcoh_84, voxels);

path_save = strcat('workspace_stat_84reg_', s_volumes, '/imcoh_stat.mat');
save(path_save, 'ICC_matrix_imcoh_84', 'CV_intra_matrix_imcoh_84', 'CV_inter_matrix_1200_imcoh_84',...
    'CV_inter_matrix_retest_imcoh_84', 'CV_inter_matrix_imcoh_84', 'P_wilcoxon_matrix_imcoh_84',...
    'H_wilcoxon_matrix_imcoh_84', 'bonf_P_wilcoxon_matrix_imcoh_84', 'bonf_H_wilcoxon_matrix_imcoh_84');
%}
    
% PLI
ICC_matrix_pli_84 = ICC_pli_84(voxels);
CV_intra_matrix_pli_84 = cv_intra_pli_84(voxels);
[CV_inter_matrix_1200_pli_84, CV_inter_matrix_retest_pli_84, CV_inter_matrix_pli_84] = CV_inter_pli_84(voxels);
[P_wilcoxon_matrix_pli_84, H_wilcoxon_matrix_pli_84] = wilcoxon_pli_84(voxels);
[bonf_P_wilcoxon_matrix_pli_84, bonf_H_wilcoxon_matrix_pli_84] = bonferroni_test(P_wilcoxon_matrix_pli_84, voxels);
[fdr_H_wilcoxon_matrix_pli_84, b, c, fdr_P_wilcoxon_matrix_pli_84] = fdr_bh(P_wilcoxon_matrix_pli_84, 0.05, 'dep', 'no');

path_save = strcat('workspace_stat_84reg_', s_volumes, '/pli_stat.mat');
save(path_save, 'ICC_matrix_pli_84', 'CV_intra_matrix_pli_84', 'CV_inter_matrix_1200_pli_84',...
    'CV_inter_matrix_retest_pli_84', 'CV_inter_matrix_pli_84', 'P_wilcoxon_matrix_pli_84',...
    'H_wilcoxon_matrix_pli_84', 'bonf_P_wilcoxon_matrix_pli_84', 'bonf_H_wilcoxon_matrix_pli_84', ...
    'fdr_H_wilcoxon_matrix_pli_84', 'fdr_P_wilcoxon_matrix_pli_84');

% WPLI
ICC_matrix_wpli_84 = ICC_wpli_84(voxels);
CV_intra_matrix_wpli_84 = cv_intra_wpli_84(voxels);
[CV_inter_matrix_1200_wpli_84, CV_inter_matrix_retest_wpli_84, CV_inter_matrix_wpli_84] = CV_inter_wpli_84(voxels);
[P_wilcoxon_matrix_wpli_84, H_wilcoxon_matrix_wpli_84] = wilcoxon_wpli_84(voxels);
[bonf_P_wilcoxon_matrix_wpli_84, bonf_H_wilcoxon_matrix_wpli_84] = bonferroni_test(P_wilcoxon_matrix_wpli_84, voxels);
[fdr_H_wilcoxon_matrix_wpli_84, b, c, fdr_P_wilcoxon_matrix_wpli_84] = fdr_bh(P_wilcoxon_matrix_wpli_84, 0.05, 'dep', 'no');

path_save = strcat('workspace_stat_84reg_', s_volumes, '/wpli_stat.mat');
save(path_save, 'ICC_matrix_wpli_84', 'CV_intra_matrix_wpli_84', 'CV_inter_matrix_1200_wpli_84',...
    'CV_inter_matrix_retest_wpli_84', 'CV_inter_matrix_wpli_84', 'P_wilcoxon_matrix_wpli_84',...
    'H_wilcoxon_matrix_wpli_84', 'bonf_P_wilcoxon_matrix_wpli_84', 'bonf_H_wilcoxon_matrix_wpli_84', ...
    'fdr_H_wilcoxon_matrix_wpli_84', 'fdr_P_wilcoxon_matrix_wpli_84');

