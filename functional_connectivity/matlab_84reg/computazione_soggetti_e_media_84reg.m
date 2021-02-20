%% DATI GENERALI

% Numero soggetti, lista dei soggetti, numero regioni, volumi, TR, ...
load('subjects.mat');

%% PROCESSO SOGGETTO

% 1200

for i = 1:n_soggetti
    
    % Carichiamo la matrice delle time-series dell'i-esimo soggetto
    fMRI_matrix = subjects_1200_filt{i};
    % Verifichiamo che l'utlima colonna non sia NaN
    if isnan(fMRI_matrix(1,end))
        fMRI_matrix(:,end) = []; 
    end

    % Normalizzazione dei dati per renderli confrontabili
    fMRI_norm_matrix = normalize(fMRI_matrix);
    % Hilbert
    hilbert_matrix = hilbert(fMRI_norm_matrix);
    
    % Calcoliamo la MS-Coherence
    coherence_matrix_s1200 = nan_diagonal(calc_mscoherence_424(fMRI_norm_matrix, vec_voxels), voxels);
    % Calcoliamo il Coefficiente di Pearson
    corr_pearson_s1200 = nan_diagonal(corrcoef(fMRI_norm_matrix), voxels);
    % Calcoliamo il Coefficiente di Pearson con valori negativi a zero
    corr_pearson_s1200_valzero = nan_diagonal(zero_pearson(corr_pearson_s1200, voxels), voxels);
    % Calcoliamo il valore immaginario della Coherency
    img_coherency_matrix_s1200 = nan_diagonal(imaCohe(hilbert_matrix, vec_voxels), voxels);
    % Calcoliamo il valore immaginario della Coherency con valori negativi
    % positivi
    img_coherency_matrix_s1200_val_abs_zero = nan_diagonal(abs_zero_imcoh(img_coherency_matrix_s1200, voxels), voxels);
    % Calcoliamo la PLV
    plv_matrix_s1200 = nan_diagonal(plv(hilbert_matrix, vec_voxels), voxels);
    % Calcoliamo il PLI
    pli_matrix_s1200 = nan_diagonal(pli(hilbert_matrix, vec_voxels), voxels);
    % Calcoliamo la W-PLI
    wpli_matrix_s1200 = nan_diagonal(wpli(hilbert_matrix, vec_voxels), voxels);
    % Calcoliamo la Partial Correlation
    pc_matrix_s1200 = nan_diagonal(partialcorr(fMRI_norm_matrix), voxels);
    % Calcoliamo la Partial Correlation con valori negativi a zero
    pc_matrix_s1200_valzero = nan_diagonal(zero_pearson(pc_matrix_s1200, voxels), voxels);
    % Calcoliamo la Partial Correlation T2 r=0.5
    pc_t2_matrix_s1200 = nan_diagonal(nets_netmats(fMRI_norm_matrix,0,'ridgep',0.5), voxels);
    % Calcoliamo la Partial Correlation T2 r=0.5 con valori negativi a zero
    pc_t2_matrix_s1200_valzero = nan_diagonal(zero_pearson(pc_t2_matrix_s1200, voxels), voxels);
    
    
    % Salviamo
    path_save = strcat('workspace_84reg_', s_volumes, '/1200/ws_', lista_soggetti(i,:), '.mat');
    save(path_save, 'coherence_matrix_s1200', 'corr_pearson_s1200', 'wpli_matrix_s1200',...
        'img_coherency_matrix_s1200', 'plv_matrix_s1200', 'pli_matrix_s1200', 'pc_matrix_s1200', ...
        'img_coherency_matrix_s1200_val_abs_zero', 'corr_pearson_s1200_valzero',...
        'pc_matrix_s1200_valzero', 'pc_t2_matrix_s1200', 'pc_t2_matrix_s1200_valzero');
    
end

% Retest

for i = 1:n_soggetti
    
    % Carichiamo la matrice delle time-series dell'i-esimo soggetto
    fMRI_matrix = subjects_retest_filt{i};
    % Verifichiamo che l'utlima colonna non sia NaN
    if isnan(fMRI_matrix(1,end))
        fMRI_matrix(:,end) = []; 
    end

    % Normalizzazione dei dati per renderli confrontabili
    fMRI_norm_matrix = normalize(fMRI_matrix);
    % Hilbert
    hilbert_matrix = hilbert(fMRI_norm_matrix);

    % Calcoliamo la MS-Coherence
    coherence_matrix_sretest = nan_diagonal(calc_mscoherence_424(fMRI_norm_matrix, vec_voxels), voxels);
    % Calcoliamo il Coefficiente di Pearson
    corr_pearson_sretest = nan_diagonal(corrcoef(fMRI_norm_matrix), voxels);
    % Calcoliamo il Coefficiente di Pearson con valori negativi a zero
    corr_pearson_sretest_valzero = nan_diagonal(zero_pearson(corr_pearson_sretest, voxels), voxels);
    % Calcoliamo il valore immaginario della Coherency
    img_coherency_matrix_sretest = nan_diagonal(imaCohe(hilbert_matrix, vec_voxels), voxels);
    % Calcoliamo il valore immaginario della Coherency con valori negativi
    % positivi
    img_coherency_matrix_sretest_val_abs_zero = nan_diagonal(abs_zero_imcoh(img_coherency_matrix_sretest, voxels), voxels);
    % Calcoliamo la PLV
    plv_matrix_sretest = nan_diagonal(plv(hilbert_matrix, vec_voxels), voxels);
    % Calcoliamo il PLI
    pli_matrix_sretest = nan_diagonal(pli(hilbert_matrix, vec_voxels), voxels);
    % Calcoliamo la W-PLI
    wpli_matrix_sretest = nan_diagonal(wpli(hilbert_matrix, vec_voxels), voxels);
    % Calcoliamo la Partial Correlation
    pc_matrix_sretest = nan_diagonal(partialcorr(fMRI_norm_matrix), voxels);
    % Calcoliamo la Partial Correlation con valori negativi a zero
    pc_matrix_sretest_valzero = nan_diagonal(zero_pearson(pc_matrix_sretest, voxels), voxels);
    % Calcoliamo la Partial Correlation T2 r=0.5
    pc_t2_matrix_sretest = nan_diagonal(nets_netmats(fMRI_norm_matrix,0,'ridgep',0.5), voxels);
    % Calcoliamo la Partial Correlation T2 r=0.5 con valori negativi a zero
    pc_t2_matrix_sretest_valzero = nan_diagonal(zero_pearson(pc_t2_matrix_sretest, voxels), voxels);
    
    % Salviamo
    path_save = strcat('workspace_84reg_', s_volumes, '/retest/ws_', lista_soggetti(i,:), '.mat');
    save(path_save, 'coherence_matrix_sretest', 'corr_pearson_sretest', 'wpli_matrix_sretest',...
        'img_coherency_matrix_sretest', 'plv_matrix_sretest', 'pli_matrix_sretest', 'pc_matrix_sretest', ...
        'img_coherency_matrix_sretest_val_abs_zero', 'corr_pearson_sretest_valzero',...
        'pc_matrix_sretest_valzero', 'pc_t2_matrix_sretest', 'pc_t2_matrix_sretest_valzero');
    
end

%% PROCESSIAMO LE MEDIE

% 1200

% Creiamo le matrici di connettività tutte a zero
coherence_matrix1 = zeros(voxels, voxels);
corr_pearson1 = zeros(voxels, voxels);
corr_pearson1_valzero = zeros(voxels, voxels);
img_coherency_matrix1 = zeros(voxels, voxels);
img_coherency_matrix1_val_abs_zero = zeros(voxels, voxels);
plv_matrix1 = zeros(voxels, voxels);
pli_matrix1 = zeros(voxels, voxels);
wpli_matrix1 = zeros(voxels, voxels);
pc_matrix1 = zeros(voxels, voxels);
pc_matrix1_valzero = zeros(voxels, voxels);
pc_t2_matrix1 = zeros(voxels, voxels);
pc_t2_matrix1_valzero = zeros(voxels, voxels);

% Calcoliamo le varie misure
for i = 1:n_soggetti
    
    percorso = strcat('workspace_84reg_', s_volumes, '/1200/ws_', lista_soggetti(i,:), '.mat');
    load(percorso);
    
    % Calcoliamo la MS-Coherence
    coherence_matrix1 = coherence_matrix1 + coherence_matrix_s1200;
    % Calcoliamo il Coefficiente di Pearson
    corr_pearson1 = corr_pearson1 + corr_pearson_s1200;
    % Calcoliamo il Coefficiente di Pearson 2
    corr_pearson1_valzero = corr_pearson1_valzero + corr_pearson_s1200_valzero;
    % Calcoliamo il valore immaginario della Coherency
    img_coherency_matrix1 = img_coherency_matrix1 + img_coherency_matrix_s1200;
    % Calcoliamo il valore immaginario della Coherency 2
    img_coherency_matrix1_val_abs_zero = img_coherency_matrix1_val_abs_zero + img_coherency_matrix_s1200_val_abs_zero;
    % Calcoliamo la PLV
    plv_matrix1 = plv_matrix1 + plv_matrix_s1200;
    % Calcoliamo il PLI
    pli_matrix1 = pli_matrix1 + pli_matrix_s1200;
    % Calcoliamo la W-PLI
    wpli_matrix1 = wpli_matrix1 + wpli_matrix_s1200;
    % Calcoliamo la Partial Correlation
    pc_matrix1 = pc_matrix1 + pc_matrix_s1200;
    % Calcoliamo la Partial Correlation con i valori negativi a zero
    pc_matrix1_valzero = pc_matrix1_valzero + pc_matrix_s1200_valzero;
    % Calcoliamo la Partial Correlation T2 r=0.5
    pc_t2_matrix1 = pc_t2_matrix1 + pc_t2_matrix_s1200;
    % Calcoliamo la Partial Correlation T2 r=0.5 con valori negativi a zero
    pc_t2_matrix1_valzero = pc_t2_matrix1_valzero + pc_t2_matrix_s1200_valzero;
    
    
end

% MS-Coherence
coherence_matrix1 = coherence_matrix1/n_soggetti;
% Pearson
corr_pearson1 = corr_pearson1/n_soggetti;
% Pearson 2
corr_pearson1_valzero = corr_pearson1_valzero/n_soggetti;
% Imaginery Coherency
img_coherency_matrix1 = img_coherency_matrix1/n_soggetti;
% Imaginery Coherency 2
img_coherency_matrix1_val_abs_zero = img_coherency_matrix1_val_abs_zero/n_soggetti;
% PLV
plv_matrix1 = plv_matrix1/n_soggetti;
% PLI
pli_matrix1 = pli_matrix1/n_soggetti;
% WPLI
wpli_matrix1 = wpli_matrix1/n_soggetti;
% Partial Correlation
pc_matrix1 = pc_matrix1/n_soggetti;
% Partial Correlation con valori negativi a zero
pc_matrix1_valzero = pc_matrix1_valzero/n_soggetti;
% Partial Correlation T2 r=0.5
pc_t2_matrix1 = pc_t2_matrix1/n_soggetti;
% Partial Correlation T2 r=0.5 con valori negativi a zero
pc_t2_matrix1_valzero = pc_t2_matrix1_valzero/n_soggetti;

path_save = strcat('workspace_84reg_', s_volumes, '/1200/ws_1200_medio.mat');
save(path_save, 'coherence_matrix1', 'corr_pearson1', 'img_coherency_matrix1',...
    'plv_matrix1', 'pli_matrix1', 'wpli_matrix1', 'pc_matrix1', 'pc_matrix1_valzero', ...
    'corr_pearson1_valzero', 'img_coherency_matrix1_val_abs_zero', ...
    'pc_t2_matrix1', 'pc_t2_matrix1_valzero');

% RETEST

% Creiamo le matrici di connettività tutte a zero
coherence_matrix2 = zeros(voxels, voxels);
corr_pearson2 = zeros(voxels, voxels);
corr_pearson2_valzero = zeros(voxels, voxels);
img_coherency_matrix2 = zeros(voxels, voxels);
img_coherency_matrix2_val_abs_zero = zeros(voxels, voxels);
plv_matrix2 = zeros(voxels, voxels);
pli_matrix2 = zeros(voxels, voxels);
wpli_matrix2 = zeros(voxels, voxels);
pc_matrix2 = zeros(voxels, voxels);
pc_matrix2_valzero = zeros(voxels, voxels);
pc_t2_matrix2 = zeros(voxels, voxels);
pc_t2_matrix2_valzero = zeros(voxels, voxels);



% Calcoliamo le varie misure
for i = 1:n_soggetti
    
    percorso = strcat('workspace_84reg_', s_volumes, '/retest/ws_', lista_soggetti(i,:), '.mat');
    load (percorso);
    
    % Calcoliamo la MS-Coherence
    coherence_matrix2 = coherence_matrix2 + coherence_matrix_sretest;
    % Calcoliamo il Coefficiente di Pearson
    corr_pearson2 = corr_pearson2 + corr_pearson_sretest;
    % Calcoliamo il Coefficiente di Pearson 2
    corr_pearson2_valzero = corr_pearson2_valzero + corr_pearson_sretest_valzero;
    % Calcoliamo il valore immaginario della Coherency
    img_coherency_matrix2 = img_coherency_matrix2 + img_coherency_matrix_sretest;
    % Calcoliamo il valore immaginario della Coherency 2
    img_coherency_matrix2_val_abs_zero = img_coherency_matrix2_val_abs_zero + img_coherency_matrix_sretest_val_abs_zero;
    % Calcoliamo la PLV
    plv_matrix2 = plv_matrix2 + plv_matrix_sretest;
    % Calcoliamo il PLI
    pli_matrix2 = pli_matrix2 + pli_matrix_sretest;
    % Calcoliamo la W-PLI
    wpli_matrix2 = wpli_matrix2 + wpli_matrix_sretest;
    % Calcoliamo la Partial Correlation
    pc_matrix2 = pc_matrix2 + pc_matrix_sretest;
    % Calcoliamo la Partial Correlation con i valori negativi a zero
    pc_matrix2_valzero = pc_matrix2_valzero + pc_matrix_sretest_valzero;
    % Calcoliamo la Partial Correlation T2 r=0.5
    pc_t2_matrix2 = pc_t2_matrix2 + pc_t2_matrix_sretest;
    % Calcoliamo la Partial Correlation T2 r=0.5 con valori negativi a zero
    pc_t2_matrix2_valzero = pc_t2_matrix2_valzero + pc_t2_matrix_sretest_valzero;
    
end

% MS-Coherence
coherence_matrix2 = coherence_matrix2/n_soggetti;
% Pearson
corr_pearson2 = corr_pearson2/n_soggetti;
% Pearson 2
corr_pearson2_valzero = corr_pearson2_valzero/n_soggetti;
% Imaginery Coherency
img_coherency_matrix2 = img_coherency_matrix2/n_soggetti;
% Imaginery Coherency 2
img_coherency_matrix2_val_abs_zero = img_coherency_matrix2_val_abs_zero/n_soggetti;
% PLV
plv_matrix2 = plv_matrix2/n_soggetti;
% PLI
pli_matrix2 = pli_matrix2/n_soggetti;
% WPLI
wpli_matrix2 = wpli_matrix2/n_soggetti;
% Partial Correlation
pc_matrix2 = pc_matrix2/n_soggetti;
% Partial Correlation con valori negativi a zero
pc_matrix2_valzero = pc_matrix2_valzero/n_soggetti;
% Partial Correlation T2 r=0.5
pc_t2_matrix2 = pc_t2_matrix2/n_soggetti;
% Partial Correlation T2 r=0.5 con valori negativi a zero
pc_t2_matrix2_valzero = pc_t2_matrix2_valzero/n_soggetti;


path_save = strcat('workspace_84reg_', s_volumes, '/retest/ws_retest_medio.mat');
save(path_save, 'coherence_matrix2', 'corr_pearson2', 'img_coherency_matrix2',...
    'plv_matrix2', 'pli_matrix2', 'wpli_matrix2', 'pc_matrix2', 'pc_matrix2_valzero', ...
    'corr_pearson2_valzero', 'img_coherency_matrix2_val_abs_zero', ...
    'pc_t2_matrix2', 'pc_t2_matrix2_valzero');

% MEGAMIX

percorso = strcat('workspace_84reg_', s_volumes, '/1200/ws_1200_medio.mat');
load(percorso);
percorso = strcat('workspace_84reg_', s_volumes, '/retest/ws_retest_medio.mat');
load(percorso);   

% MS-Coherence
coherence_matrix3 = (coherence_matrix1 + coherence_matrix2)/2;
% Pearson
corr_pearson3 = (corr_pearson1 + corr_pearson2)/2;
% Pearson 2
corr_pearson3_valzero = (corr_pearson1_valzero + corr_pearson2_valzero)/2;
% Imaginery Coherency
img_coherency_matrix3 = (img_coherency_matrix1 + img_coherency_matrix2)/2;
% Imaginery Coherency 2
img_coherency_matrix3_val_abs_zero = (img_coherency_matrix1_val_abs_zero + img_coherency_matrix2_val_abs_zero)/2;
% PLV
plv_matrix3 = (plv_matrix1 + plv_matrix2)/2;
% PLI
pli_matrix3 = (pli_matrix1 + pli_matrix2)/2;
% W-PLI
wpli_matrix3 = (wpli_matrix1 + wpli_matrix2)/2;
% Partial Correlation
pc_matrix3 = (pc_matrix1 + pc_matrix2)/2;
% Partial Correlation con valori negativi a zero
pc_matrix3_valzero = (pc_matrix1_valzero + pc_matrix2_valzero)/2;
% Partial Correlation T2 r=0.5
pc_t2_matrix3 = (pc_t2_matrix1 + pc_t2_matrix2)/2;
% Partial Correlation T2 r=0.5 con valori negativi a zero
pc_t2_matrix3_valzero = (pc_t2_matrix1_valzero + pc_t2_matrix2_valzero)/2;

path_save = strcat('workspace_84reg_', s_volumes, '/ws_all_medio.mat');
save(path_save, 'coherence_matrix3', 'corr_pearson3', 'img_coherency_matrix3',...
    'plv_matrix3', 'pli_matrix3', 'wpli_matrix3', 'pc_matrix3', 'pc_matrix3_valzero', ...
    'corr_pearson3_valzero', 'img_coherency_matrix3_val_abs_zero', ...
    'pc_t2_matrix3', 'pc_t2_matrix3_valzero');
    
