%% DATI GENERALI

% Numero soggetti, lista dei soggetti, numero regioni, volumi, TR
n_soggetti = 45;
lista_soggetti = string(readmatrix('soggetti46.txt'));
volumes = 400;
voxels = 84;
vec_vol = 1:volumes;
vec_voxels = 1:voxels;
TR = 0.782;

% File per plotting delle regioni accanto alle regioni
% Creiamo la matrice con i nomi delle regioni e importiamoli dal txt
fsdefault_matrix = strings(voxels,2);
fsdefault_matrix(:,1) = importdata('fs_default_2.txt');
% Estrapoliamo vettore regioni funzionali
network_matrix_aux = importdata('Schaefer_final_networks.txt'); 
fsdefault_matrix(:,2) = network_matrix_aux(:,1);
clear network_matrix_aux;
% Carichiamo indici della riorganizzazione funzionale
Schaefer_index_matrix = readmatrix('Schaefer_final_reorganization.txt');
% Creiamo la matrice nomi secondo Schaefer
Schaefer_matrix = strings(voxels,2);
for k = vec_voxels
    Schaefer_matrix(k,:) = fsdefault_matrix(Schaefer_index_matrix(k,1),:);
end
brain_sort_matrix = Schaefer_matrix;
clear Schaefer_matrix;
[vet_dist, vet_label, vet_color, vet_cum] = label(brain_sort_matrix, voxels);

%% Misure di un soggetto

sog = string(input('Inserire il soggetto che si vuole analizzare: '));
q = input('Si vuole analizzare 1200 o Retest?\n(1200 -> 1200)\n(Retest -> retest)\nRisposta: ');

if strcmp(q,'1200')
    % 1200

    percorso = strcat('workspace_46/1200/ws_', sog, '.mat');
    load(percorso);

    % Plottiamo MS-Coherence
    plot_matrix(coherence_matrix_s1200, 'MS-Coherence 1200', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo Pearson
    plot_matrix(corr_pearson_s1200, 'Correlazione di Pearson 1200', [-1 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo Determinazione
    plot_matrix(coef_det_s1200, 'Coefficiente di Determinazione 1200', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo Imaginery Coherency
    plot_matrix(img_coherency_matrix_s1200, 'Imaginery Coherency 1200', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo PLV
    plot_matrix(plv_matrix_s1200, 'PLV 1200', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo PLI
    plot_matrix(pli_matrix_s1200, 'PLI 1200', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo PLI
    plot_matrix(wpli_matrix_s1200, 'W-PLI 1200', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);

elseif strcmp(q,'retest')
    % RETEST

    percorso = strcat('workspace_46/retest/ws_', sog, '.mat');
    load (percorso);

    % Plottiamo MS-Coherence
    plot_matrix(coherence_matrix_sretest, 'MS-Coherence Retest', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo Pearson
    plot_matrix(corr_pearson_sretest, 'Correlazione di Pearson Retest', [-1 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo Determinazione
    plot_matrix(coef_det_sretest, 'Coefficiente di Determinazione Retest', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo Imaginery Coherency
    plot_matrix(img_coherency_matrix_sretest, 'Imaginery Coherency Retest', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo PLV
    plot_matrix(plv_matrix_sretest, 'PLV Retest', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo PLI
    plot_matrix(pli_matrix_sretest, 'PLI Retest', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    % Plottiamo PLI
    plot_matrix(wpli_matrix_sretest, 'W-PLI Retest', [0 1], voxels,...
        vet_dist, vet_label, vet_color, vet_cum);
    
else
    error('Errore di inserimento. Rilanciare la sezione.');
end 

%% Misure media 1200

% Carichiamo workspace
load('workspace_46/1200/ws_1200_medio.mat');

% Plottiamo MS-Coherence
plot_matrix(coherence_matrix1, 'MS-Coherence 1200', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson
plot_matrix(corr_pearson1, 'Correlazione di Pearson 1200', [-1 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Determinazione
plot_matrix(coef_det1, 'Coefficiente di Determinazione 1200', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency
plot_matrix(img_coherency_matrix1, 'Imaginery Coherency 1200', [0 0.3], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLV
plot_matrix(plv_matrix1, 'PLV 1200', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(pli_matrix1, 'PLI 1200', [0 0.3], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(wpli_matrix1, 'W-PLI 1200', [0 0.5], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% Misure media Retest

% Carichiamo workspace
load('workspace_46/retest/ws_retest_medio.mat');

% Plottiamo MS-Coherence
plot_matrix(coherence_matrix2, 'MS-Coherence Retest', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson
plot_matrix(corr_pearson2, 'Correlazione di Pearson Retest', [-1 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Determinazione
plot_matrix(coef_det2, 'Coefficiente di Determinazione Retest', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency
plot_matrix(img_coherency_matrix2, 'Imaginery Coherency Retest', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLV
plot_matrix(plv_matrix2, 'PLV Retest', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(pli_matrix2, 'PLI Retest', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(wpli_matrix2, 'W-PLI Retest', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% Misure media tot

% Carichiamo workspace
load('workspace_46/ws_all_medio.mat');

% Plottiamo MS-Coherence
plot_matrix(coherence_matrix3, 'MS-Coherence', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Pearson
plot_matrix(corr_pearson3, 'Correlazione di Pearson', [-1 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Determinazione
plot_matrix(coef_det3, 'Coefficiente di Determinazione', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo Imaginery Coherency
plot_matrix(img_coherency_matrix3, 'Imaginery Coherency', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLV
plot_matrix(plv_matrix3, 'PLV', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(pli_matrix3, 'PLI', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);
% Plottiamo PLI
plot_matrix(wpli_matrix3, 'W-PLI', [0 1], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% Confronto un soggetto 1200 - Retest

% Scegliamo il soggetto
sog = string(input('Inserire il soggetto che si vuole analizzare: '));

% Carichiamo i workspace 1200 e Retest del soggetto
percorso = strcat('workspace_46/1200/ws_', sog, '.mat');
load(percorso);
percorso = strcat('workspace_46/retest/ws_', sog, '.mat');
load (percorso);

% Chiediamo la misura da confrontare
fprintf('Su quale misura si vuole fare il confronto?\n(ms-coherence = msc)\n(pearson = pes)\n(determinazione = det)\n');
fprintf('(imc = imaginery coherency)\n(plv = plv)\n(pli = pli)\n(wpli = wpli)\n');
measure = input('Risposta: ');

if strcmp(measure, 'msc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison MS-Coherence');
    % Plottiamo
    subplot(1,2,1);
    imagesc(coherence_matrix_s1200), colormap jet, caxis([0 1]);
    subplot(1,2,2);
    imagesc(coherence_matrix_sretest), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'pes')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Pearson');
    % Plottiamo
    subplot(1,2,1);
    imagesc(corr_pearson_s1200), colormap jet, caxis([-1 1]), colorbar;
    subplot(1,2,2);
    imagesc(corr_pearson_sretest), colormap jet, caxis([-1 1]), colorbar;
elseif strcmp(measure, 'det')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Determinazione');
    % Plottiamo
    subplot(1,2,1);
    imagesc(coef_det_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(coef_det_sretest), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'imc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Imaginery Coherency');
    % Plottiamo
    subplot(1,2,1);
    imagesc(img_coherency_matrix_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(img_coherency_matrix_sretest), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'plv')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLV');
    % Plottiamo
    subplot(1,2,1);
    imagesc(plv_matrix_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(plv_matrix_sretest), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'pli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLI');
    % Plottiamo
    subplot(1,2,1);
    imagesc(pli_matrix_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(pli_matrix_sretest), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'wpli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison W-PLI');
    % Plottiamo
    subplot(1,2,1);
    imagesc(wpli_matrix_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(wpli_matrix_sretest), colormap jet, caxis([0 1]), colorbar;
else
    error('Errore di inserimento. Rilanciare la sezione.');
end

%% Confronto un soggetto 1200 - Media1200

% Scegliamo il soggetto
sog = string(input('Inserire il soggetto che si vuole analizzare: '));

% Carichiamo i workspace 1200 e media
percorso = strcat('workspace_46/1200/ws_', sog, '.mat');
load(percorso);
load('workspace_46/1200/ws_1200_medio.mat');

% Chiediamo la misura da confrontare
fprintf('Su quale misura si vuole fare il confronto?\n(ms-coherence = msc)\n(pearson = pes)\n(determinazione = det)\n');
fprintf('(imc = imaginery coherency)\n(plv = plv)\n(pli = pli)\n(wpli = wpli)\n');
measure = input('Risposta: ');

if strcmp(measure, 'msc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison MS-Coherence');
    % Plottiamo
    subplot(1,2,1);
    imagesc(coherence_matrix_s1200), colormap jet, caxis([0 1]);
    subplot(1,2,2);
    imagesc(coherence_matrix1), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'pes')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Pearson');
    % Plottiamo
    subplot(1,2,1);
    imagesc(corr_pearson_s1200), colormap jet, caxis([-1 1]), colorbar;
    subplot(1,2,2);
    imagesc(corr_pearson1), colormap jet, caxis([-1 1]), colorbar;
elseif strcmp(measure, 'det')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Determinazione');
    % Plottiamo
    subplot(1,2,1);
    imagesc(coef_det_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(coef_det1), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'imc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Imaginery Coherency');
    % Plottiamo
    subplot(1,2,1);
    imagesc(img_coherency_matrix_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(img_coherency_matrix1), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'plv')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLV');
    % Plottiamo
    subplot(1,2,1);
    imagesc(plv_matrix_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(plv_matrix1), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'pli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLI');
    % Plottiamo
    subplot(1,2,1);
    imagesc(pli_matrix_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(pli_matrix1), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'wpli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison W-PLI');
    % Plottiamo
    subplot(1,2,1);
    imagesc(wpli_matrix_s1200), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(wpli_matrix1), colormap jet, caxis([0 1]), colorbar;
else
    error('Errore di inserimento. Rilanciare la sezione.');
end

%% Confronto un soggetto Retest - MediaRetest

% Scegliamo il soggetto
sog = string(input('Inserire il soggetto che si vuole analizzare: '));

% Carichiamo i workspace 1200 e media
percorso = strcat('workspace_46/retest/ws_', sog, '.mat');
load(percorso);
load('workspace_46/1200/ws_retest_medio.mat');

% Chiediamo la misura da confrontare
fprintf('Su quale misura si vuole fare il confronto?\n(ms-coherence = msc)\n(pearson = pes)\n(determinazione = det)\n');
fprintf('(imc = imaginery coherency)\n(plv = plv)\n(pli = pli)\n(wpli = wpli)\n');
measure = input('Risposta: ');

if strcmp(measure, 'msc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison MS-Coherence');
    % Plottiamo
    subplot(1,2,1);
    imagesc(coherence_matrix_sretest), colormap jet, caxis([0 1]);
    subplot(1,2,2);
    imagesc(coherence_matrix2), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'pes')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Pearson');
    % Plottiamo
    subplot(1,2,1);
    imagesc(corr_pearson_sretest), colormap jet, caxis([-1 1]), colorbar;
    subplot(1,2,2);
    imagesc(corr_pearson2), colormap jet, caxis([-1 1]), colorbar;
elseif strcmp(measure, 'det')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Determinazione');
    % Plottiamo
    subplot(1,2,1);
    imagesc(coef_det_sretest), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(coef_det2), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'imc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Imaginery Coherency');
    % Plottiamo
    subplot(1,2,1);
    imagesc(img_coherency_matrix_sretest), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(img_coherency_matrix2), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'plv')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLV');
    % Plottiamo
    subplot(1,2,1);
    imagesc(plv_matrix_sretest), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(plv_matrix2), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'pli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLI');
    % Plottiamo
    subplot(1,2,1);
    imagesc(pli_matrix_sretest), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(pli_matrix2), colormap jet, caxis([0 1]), colorbar;
elseif strcmp(measure, 'wpli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison W-PLI');
    % Plottiamo
    subplot(1,2,1);
    imagesc(wpli_matrix_sretest), colormap jet, caxis([0 1]), colorbar;
    subplot(1,2,2);
    imagesc(wpli_matrix2), colormap jet, caxis([0 1]), colorbar;
else
    error('Errore di inserimento. Rilanciare la sezione.');
end