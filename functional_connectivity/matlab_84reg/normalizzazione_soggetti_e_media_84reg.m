%% DATI GENERALI

% Numero soggetti, lista dei soggetti, numero regioni, volumi, TR, ...
load('subjects.mat');

%% NORMALIZZAZIONE 45 SOGGETTI

% Normalizzazione 1200
for i = 1:n_soggetti
    
    percorso = strcat('workspace_84reg_', s_volumes, '/1200/ws_', lista_soggetti(i,:), '.mat');
    load (percorso);
    
    coherence_matrix_s1200_norm = coherence_matrix_s1200./mean(mean(coherence_matrix_s1200, 'omitnan'));
    corr_pearson_s1200_norm = corr_pearson_s1200./mean(mean(corr_pearson_s1200, 'omitnan'));
    corr_pearson_s1200_valzero_norm = corr_pearson_s1200_valzero./mean(mean(corr_pearson_s1200_valzero, 'omitnan'));
    img_coherency_matrix_s1200_norm = img_coherency_matrix_s1200./mean(mean(img_coherency_matrix_s1200, 'omitnan'));
    img_coherency_matrix_s1200_val_abs_zero_norm = img_coherency_matrix_s1200_val_abs_zero./mean(mean(img_coherency_matrix_s1200_val_abs_zero, 'omitnan'));
    plv_matrix_s1200_norm = plv_matrix_s1200./mean(mean(plv_matrix_s1200, 'omitnan'));
    pli_matrix_s1200_norm = pli_matrix_s1200./mean(mean(pli_matrix_s1200, 'omitnan'));
    wpli_matrix_s1200_norm = wpli_matrix_s1200./mean(mean(wpli_matrix_s1200, 'omitnan'));
    pc_matrix_s1200_norm = pc_matrix_s1200./mean(mean(pc_matrix_s1200, 'omitnan'));
    pc_matrix_s1200_valzero_norm = pc_matrix_s1200_valzero./mean(mean(pc_matrix_s1200_valzero, 'omitnan'));
    pc_t2_matrix_s1200_norm = pc_t2_matrix_s1200./mean(mean(pc_t2_matrix_s1200, 'omitnan'));
    pc_t2_matrix_s1200_valzero_norm = pc_t2_matrix_s1200_valzero./mean(mean(pc_t2_matrix_s1200_valzero, 'omitnan'));
    
    
    path_save = strcat('workspace_84reg_', s_volumes, '_norm/1200/ws_',lista_soggetti(i,:),'_norm.mat');
    save(path_save, 'coherence_matrix_s1200_norm', 'corr_pearson_s1200_norm',...
        'img_coherency_matrix_s1200_norm', 'plv_matrix_s1200_norm', 'pli_matrix_s1200_norm',...
        'wpli_matrix_s1200_norm', 'corr_pearson_s1200_valzero_norm', 'img_coherency_matrix_s1200_val_abs_zero_norm', ...
        'pc_matrix_s1200_norm', 'pc_matrix_s1200_valzero_norm', ...
        'pc_t2_matrix_s1200_norm', 'pc_t2_matrix_s1200_valzero_norm');
end

% Normalizzazione RETEST
for i = 1:n_soggetti
    
    percorso = strcat('workspace_84reg_', s_volumes, '/retest/ws_',lista_soggetti(i,:),'.mat');
    load (percorso);
    
    coherence_matrix_sretest_norm = coherence_matrix_sretest./mean(mean(coherence_matrix_sretest, 'omitnan'));
    corr_pearson_sretest_norm = corr_pearson_sretest./mean(mean(corr_pearson_sretest, 'omitnan'));
    corr_pearson_sretest_valzero_norm = corr_pearson_sretest_valzero./mean(mean(corr_pearson_sretest_valzero, 'omitnan'));
    img_coherency_matrix_sretest_norm = img_coherency_matrix_sretest./mean(mean(img_coherency_matrix_sretest, 'omitnan'));
    img_coherency_matrix_sretest_val_abs_zero_norm = img_coherency_matrix_sretest_val_abs_zero./mean(mean(img_coherency_matrix_sretest_val_abs_zero, 'omitnan'));
    plv_matrix_sretest_norm = plv_matrix_sretest./mean(mean(plv_matrix_sretest, 'omitnan'));
    pli_matrix_sretest_norm = pli_matrix_sretest./mean(mean(pli_matrix_sretest, 'omitnan'));
    wpli_matrix_sretest_norm = wpli_matrix_sretest./mean(mean(wpli_matrix_sretest, 'omitnan'));
    pc_matrix_sretest_norm = pc_matrix_sretest./mean(mean(pc_matrix_sretest, 'omitnan'));
    pc_matrix_sretest_valzero_norm = pc_matrix_sretest_valzero./mean(mean(pc_matrix_sretest_valzero, 'omitnan'));
    pc_t2_matrix_sretest_norm = pc_t2_matrix_sretest./mean(mean(pc_t2_matrix_sretest, 'omitnan'));
    pc_t2_matrix_sretest_valzero_norm = pc_t2_matrix_sretest_valzero./mean(mean(pc_t2_matrix_sretest_valzero, 'omitnan'));
    
    path_save = strcat('workspace_84reg_', s_volumes, '_norm/retest/ws_',lista_soggetti(i,:),'_norm.mat');
    save(path_save, 'coherence_matrix_sretest_norm', 'corr_pearson_sretest_norm',...
        'img_coherency_matrix_sretest_norm', 'plv_matrix_sretest_norm',...
        'pli_matrix_sretest_norm', 'wpli_matrix_sretest_norm',...
        'corr_pearson_sretest_valzero_norm', 'img_coherency_matrix_sretest_val_abs_zero_norm', ...
        'pc_matrix_sretest_norm', 'pc_matrix_sretest_valzero_norm', ...
        'pc_t2_matrix_sretest_norm', 'pc_t2_matrix_sretest_valzero_norm');
end

%% CALCOLO MEDIA NORMALIZZATA

% Media tutti 1200

% Creiamo le matrici di connettività tutte a zero
coherence_matrix1_norm = zeros(voxels, voxels);
corr_pearson1_norm = zeros(voxels, voxels);
corr_pearson1_valzero_norm = zeros(voxels, voxels);
img_coherency_matrix1_norm = zeros(voxels, voxels);
img_coherency_matrix1_val_abs_zero_norm = zeros(voxels, voxels);
plv_matrix1_norm = zeros(voxels, voxels);
pli_matrix1_norm = zeros(voxels, voxels);
wpli_matrix1_norm = zeros(voxels, voxels);
pc_matrix1_norm = zeros(voxels, voxels);
pc_matrix1_valzero_norm = zeros(voxels, voxels);
pc_t2_matrix1_norm = zeros(voxels, voxels);
pc_t2_matrix1_valzero_norm = zeros(voxels, voxels);

% Calcoliamo le varie misure
for i = 1:n_soggetti
    
    percorso = strcat('workspace_84reg_', s_volumes, '_norm/1200/ws_',lista_soggetti(i,:),'_norm.mat');
    load(percorso);
    
    % Calcoliamo la MS-Coherence
    coherence_matrix1_norm = coherence_matrix1_norm + coherence_matrix_s1200_norm;
    % Calcoliamo il Coefficiente di Pearson
    corr_pearson1_norm = corr_pearson1_norm + corr_pearson_s1200_norm;
    % Calcoliamo il Coefficiente di Pearson 2
    corr_pearson1_valzero_norm = corr_pearson1_valzero_norm + corr_pearson_s1200_valzero_norm;
    % Calcoliamo il valore immaginario della Coherency
    img_coherency_matrix1_norm = img_coherency_matrix1_norm + img_coherency_matrix_s1200_norm;
    % Calcoliamo il valore immaginario della Coherency 2
    img_coherency_matrix1_val_abs_zero_norm = img_coherency_matrix1_val_abs_zero_norm + img_coherency_matrix_s1200_val_abs_zero_norm;
    % Calcoliamo la PLV
    plv_matrix1_norm = plv_matrix1_norm + plv_matrix_s1200_norm;
    % Calcoliamo il PLI
    pli_matrix1_norm = pli_matrix1_norm + pli_matrix_s1200_norm;
    % Calcoliamo la W-PLI
    wpli_matrix1_norm = wpli_matrix1_norm + wpli_matrix_s1200_norm;
    % Calcoliamo la Partial Correlation
    pc_matrix1_norm = pc_matrix1_norm + pc_matrix_s1200_norm;
    % Calcoliamo la Partial Correlation con valori negativi a zero
    pc_matrix1_valzero_norm = pc_matrix1_valzero_norm + pc_matrix_s1200_valzero_norm;
    % Calcoliamo la Partial Correlation T2 r=0.5
    pc_t2_matrix1_norm = pc_t2_matrix1_norm + pc_t2_matrix_s1200_norm;
    % Calcoliamo la Partial Correlation T2 r=0.5 con valori negativi a zero
    pc_t2_matrix1_valzero_norm = pc_t2_matrix1_valzero_norm + pc_t2_matrix_s1200_valzero_norm;
    
end

% MS-Coherence
coherence_matrix1_norm = coherence_matrix1_norm/n_soggetti;
% Pearson
corr_pearson1_norm = corr_pearson1_norm/n_soggetti;
% Pearson 2
corr_pearson1_valzero_norm = corr_pearson1_valzero_norm/n_soggetti;
% Imaginery Coherency
img_coherency_matrix1_norm = img_coherency_matrix1_norm/n_soggetti;
% Imaginery Coherency 2
img_coherency_matrix1_val_abs_zero_norm = img_coherency_matrix1_val_abs_zero_norm/n_soggetti;
% PLV
plv_matrix1_norm = plv_matrix1_norm/n_soggetti;
% PLI
pli_matrix1_norm = pli_matrix1_norm/n_soggetti;
% W-PLI
wpli_matrix1_norm = wpli_matrix1_norm/n_soggetti;
% Partial Correlation
pc_matrix1_norm = pc_matrix1_norm/n_soggetti;
% Partial Correlation con valori negativi a zero
pc_matrix1_valzero_norm = pc_matrix1_valzero_norm/n_soggetti;
% Partial Correlation T2 r=0.5
pc_t2_matrix1_norm = pc_t2_matrix1_norm/n_soggetti;
% Partial Correlation T2 r=0.5 con valori negativi a zero
pc_t2_matrix1_valzero_norm = pc_t2_matrix1_valzero_norm/n_soggetti;


path_save = strcat('workspace_84reg_', s_volumes, '_norm/1200/ws_1200_medio_norm.mat');
save(path_save, 'coherence_matrix1_norm', 'corr_pearson1_norm',...
    'img_coherency_matrix1_norm', 'plv_matrix1_norm', 'pli_matrix1_norm',...
    'wpli_matrix1_norm', 'corr_pearson1_valzero_norm', 'img_coherency_matrix1_val_abs_zero_norm', ...
    'pc_matrix1_norm', 'pc_matrix1_valzero_norm', ...
    'pc_t2_matrix1_norm', 'pc_t2_matrix1_valzero_norm');

% Media tutti RETEST

% Creiamo le matrici di connettività tutte a zero
coherence_matrix2_norm = zeros(voxels, voxels);
corr_pearson2_norm = zeros(voxels, voxels);
corr_pearson2_valzero_norm = zeros(voxels, voxels);
img_coherency_matrix2_norm = zeros(voxels, voxels);
img_coherency_matrix2_val_abs_zero_norm = zeros(voxels, voxels);
plv_matrix2_norm = zeros(voxels, voxels);
pli_matrix2_norm = zeros(voxels, voxels);
wpli_matrix2_norm = zeros(voxels, voxels);
pc_matrix2_norm = zeros(voxels, voxels);
pc_matrix2_valzero_norm = zeros(voxels, voxels);
pc_t2_matrix2_norm = zeros(voxels, voxels);
pc_t2_matrix2_valzero_norm = zeros(voxels, voxels);

% Calcoliamo le varie misure
for i = 1:n_soggetti
    
    percorso = strcat('workspace_84reg_', s_volumes, '_norm/retest/ws_',lista_soggetti(i,:),'_norm.mat');
    load(percorso);
    
    % Calcoliamo la MS-Coherence
    coherence_matrix2_norm = coherence_matrix2_norm + coherence_matrix_sretest_norm;
    % Calcoliamo il Coefficiente di Pearson
    corr_pearson2_norm = corr_pearson2_norm + corr_pearson_sretest_norm;
    % Calcoliamo il Coefficiente di Pearson 2
    corr_pearson2_valzero_norm = corr_pearson2_valzero_norm + corr_pearson_sretest_valzero_norm;
    % Calcoliamo il valore immaginario della Coherency
    img_coherency_matrix2_norm = img_coherency_matrix2_norm + img_coherency_matrix_sretest_norm;
    % Calcoliamo il valore immaginario della Coherency 2
    img_coherency_matrix2_val_abs_zero_norm = img_coherency_matrix2_val_abs_zero_norm + img_coherency_matrix_sretest_val_abs_zero_norm;
    % Calcoliamo la PLV
    plv_matrix2_norm = plv_matrix2_norm + plv_matrix_sretest_norm;
    % Calcoliamo il PLI
    pli_matrix2_norm = pli_matrix2_norm + pli_matrix_sretest_norm;
    % Calcoliamo la W-PLI
    wpli_matrix2_norm = wpli_matrix2_norm + wpli_matrix_sretest_norm;
    % Calcoliamo la Partial Correlation
    pc_matrix2_norm = pc_matrix2_norm + pc_matrix_sretest_norm;
    % Calcoliamo la Partial Correlation con valori negativi a zero
    pc_matrix2_valzero_norm = pc_matrix2_valzero_norm + pc_matrix_sretest_valzero_norm;
    % Calcoliamo la Partial Correlation T2 r=0.5
    pc_t2_matrix2_norm = pc_t2_matrix2_norm + pc_t2_matrix_sretest_norm;
    % Calcoliamo la Partial Correlation T2 r=0.5 con valori negativi a zero
    pc_t2_matrix2_valzero_norm = pc_t2_matrix2_valzero_norm + pc_t2_matrix_sretest_valzero_norm;
    
end

% MS-Coherence
coherence_matrix2_norm = coherence_matrix2_norm/n_soggetti;
% Pearson
corr_pearson2_norm = corr_pearson2_norm/n_soggetti;
% Pearson 2
corr_pearson2_valzero_norm = corr_pearson2_valzero_norm/n_soggetti;
% Imaginery Coherency
img_coherency_matrix2_norm = img_coherency_matrix2_norm/n_soggetti;
% Imaginery Coherency 2
img_coherency_matrix2_val_abs_zero_norm = img_coherency_matrix2_val_abs_zero_norm/n_soggetti;
% PLV
plv_matrix2_norm = plv_matrix2_norm/n_soggetti;
% PLI
pli_matrix2_norm = pli_matrix2_norm/n_soggetti;
% W-PLI
wpli_matrix2_norm = wpli_matrix2_norm/n_soggetti;
% Partial Correlation
pc_matrix2_norm = pc_matrix2_norm/n_soggetti;
% Partial Correlation con valori negativi a zero
pc_matrix2_valzero_norm = pc_matrix2_valzero_norm/n_soggetti;
% Partial Correlation T2 r=0.5
pc_t2_matrix2_norm = pc_t2_matrix2_norm/n_soggetti;
% Partial Correlation T2 r=0.5 con valori negativi a zero
pc_t2_matrix2_valzero_norm = pc_t2_matrix2_valzero_norm/n_soggetti;

path_save = strcat('workspace_84reg_', s_volumes, '_norm/retest/ws_retest_medio_norm.mat');
save(path_save, 'coherence_matrix2_norm', 'corr_pearson2_norm',...
    'img_coherency_matrix2_norm', 'plv_matrix2_norm', 'pli_matrix2_norm',...
    'wpli_matrix2_norm', 'corr_pearson2_valzero_norm', 'img_coherency_matrix2_val_abs_zero_norm', ...
    'pc_matrix2_norm', 'pc_matrix2_valzero_norm', ...
    'pc_t2_matrix2_norm', 'pc_t2_matrix2_valzero_norm');
    
%% MEGAMIX

percorso = strcat('workspace_84reg_', s_volumes, '_norm/1200/ws_1200_medio_norm.mat');
load(percorso);
percorso = strcat('workspace_84reg_', s_volumes, '_norm/retest/ws_retest_medio_norm.mat');
load(percorso);   

% MS-Coherence
coherence_matrix3_norm = (coherence_matrix1_norm + coherence_matrix2_norm)/2;
% Pearson
corr_pearson3_norm = (corr_pearson1_norm + corr_pearson2_norm)/2;
% Pearson 2
corr_pearson3_valzero_norm = (corr_pearson1_valzero_norm + corr_pearson2_valzero_norm)/2;
% Imaginery Coherency
img_coherency_matrix3_norm = (img_coherency_matrix1_norm + img_coherency_matrix2_norm)/2;
% Imaginery Coherency 2
img_coherency_matrix3_val_abs_zero_norm = (img_coherency_matrix1_val_abs_zero_norm + img_coherency_matrix2_val_abs_zero_norm)/2;
% PLV
plv_matrix3_norm = (plv_matrix1_norm + plv_matrix2_norm)/2;
% PLI
pli_matrix3_norm = (pli_matrix1_norm + pli_matrix2_norm)/2;
% W-PLI
wpli_matrix3_norm = (wpli_matrix1_norm + wpli_matrix2_norm)/2;
% Partial Correlation
pc_matrix3_norm = (pc_matrix1_norm + pc_matrix2_norm)/2;
% Partial Correlation con valori negativi a zero
pc_matrix3_valzero_norm = (pc_matrix1_valzero_norm + pc_matrix2_valzero_norm)/2;
% Partial Correlation T2 r=0.5
pc_t2_matrix3_norm = (pc_t2_matrix1_norm + pc_t2_matrix2_norm)/2;
% Partial Correlation T2 r=0.5 con valori negativi a zero
pc_t2_matrix3_valzero_norm = (pc_t2_matrix1_valzero_norm + pc_t2_matrix2_valzero_norm)/2;

path_save = strcat('workspace_84reg_', s_volumes, '_norm/ws_all_medio_norm.mat');
save(path_save, 'coherence_matrix3_norm', 'corr_pearson3_norm',...
    'img_coherency_matrix3_norm', 'plv_matrix3_norm', 'pli_matrix3_norm',...
    'wpli_matrix3_norm', 'corr_pearson3_valzero_norm', 'img_coherency_matrix3_val_abs_zero_norm', ...
    'pc_matrix3_norm', 'pc_matrix3_valzero_norm', ...
    'pc_t2_matrix3_norm', 'pc_t2_matrix3_valzero_norm');
    