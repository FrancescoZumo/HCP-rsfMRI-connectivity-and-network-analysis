%% DATI GENERICI

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

%% PLOTTIAMO LE MEDIE

% Carichiamo le misure di media
% 1200
load('workspace_46/1200/ws_1200_medio.mat');
% Retest
load('workspace_46/retest/ws_retest_medio.mat');
% Megamix
load('workspace_46/ws_all_medio.mat');

%Plottiamo

% 1200
figure('NumberTitle', 'off', 'Name', 'Misure di media 1200');
% MS-Coherence
subplot(2,3,1);
imagesc(coherence_matrix1), colormap jet, caxis([0 1]);
% Pearson
subplot(2,3,2);
imagesc(corr_pearson1), colormap jet, caxis([-1 1]);
% Imagery Coherency
subplot(2,3,3);
imagesc(img_coherency_matrix1), colormap jet, caxis([0 1]);
% PLV
subplot(2,3,4);
imagesc(plv_matrix1), colormap jet, caxis([0 1]);
% PLI
subplot(2,3,5);
imagesc(pli_matrix1), colormap jet, caxis([0 1]);
% W-PLI
subplot(2,3,6);
imagesc(wpli_matrix1), colormap jet, caxis([0 1]);

% Retest
figure('NumberTitle', 'off', 'Name', 'Misure di media Retest');
% MS-Coherence
subplot(2,3,1);
imagesc(coherence_matrix2), colormap jet, caxis([0 1]);
% Pearson
subplot(2,3,2);
imagesc(corr_pearson2), colormap jet, caxis([-1 1]);
% Imagery Coherency
subplot(2,3,3);
imagesc(img_coherency_matrix2), colormap jet, caxis([0 1]);
% PLV
subplot(2,3,4);
imagesc(plv_matrix2), colormap jet, caxis([0 1]);
% PLI
subplot(2,3,5);
imagesc(pli_matrix2), colormap jet, caxis([0 1]);
% W-PLI
subplot(2,3,6);
imagesc(wpli_matrix2), colormap jet, caxis([0 1]);

% Megamix
figure('NumberTitle', 'off', 'Name', 'Misure di media Megamix');
% MS-Coherence
subplot(2,3,1);
imagesc(coherence_matrix3), colormap jet, caxis([0 1]);
% Pearson
subplot(2,3,2);
imagesc(corr_pearson3), colormap jet, caxis([-1 1]);
% Imagery Coherency
subplot(2,3,3);
imagesc(img_coherency_matrix3), colormap jet, caxis([0 1]);
% PLV
subplot(2,3,4);
imagesc(plv_matrix3), colormap jet, caxis([0 1]);
% PLI
subplot(2,3,5);
imagesc(pli_matrix3), colormap jet, caxis([0 1]);
% W-PLI
subplot(2,3,6);
imagesc(wpli_matrix3), colormap jet, caxis([0 1]);

%% SINGOLE FIGURE

% Carichiamo le misure di media
% 1200
load('workspace_46/1200/ws_1200_medio.mat');
% Retest
load('workspace_46/retest/ws_retest_medio.mat');
% Megamix
load('workspace_46/ws_all_medio.mat');

%Plottiamo

% 1200
% MS-Coherence
figure('NumberTitle', 'off', 'Name', 'Misure di media 1200');
imagesc(coherence_matrix1), colormap jet, caxis([0 1]);
% Pearson
subplot(2,3,2);
imagesc(corr_pearson1), colormap jet, caxis([-1 1]);
% Imagery Coherency
subplot(2,3,3);
imagesc(img_coherency_matrix1), colormap jet, caxis([0 1]);
% PLV
subplot(2,3,4);
imagesc(plv_matrix1), colormap jet, caxis([0 1]);
% PLI
subplot(2,3,5);
imagesc(pli_matrix1), colormap jet, caxis([0 1]);
% W-PLI
subplot(2,3,6);
imagesc(wpli_matrix1), colormap jet, caxis([0 1]);

% Retest
figure('NumberTitle', 'off', 'Name', 'Misure di media Retest');
% MS-Coherence
subplot(2,3,1);
imagesc(coherence_matrix2), colormap jet, caxis([0 1]);
% Pearson
subplot(2,3,2);
imagesc(corr_pearson2), colormap jet, caxis([-1 1]);
% Imagery Coherency
subplot(2,3,3);
imagesc(img_coherency_matrix2), colormap jet, caxis([0 1]);
% PLV
subplot(2,3,4);
imagesc(plv_matrix2), colormap jet, caxis([0 1]);
% PLI
subplot(2,3,5);
imagesc(pli_matrix2), colormap jet, caxis([0 1]);
% W-PLI
subplot(2,3,6);
imagesc(wpli_matrix2), colormap jet, caxis([0 1]);

% Megamix
figure('NumberTitle', 'off', 'Name', 'Misure di media Megamix');
% MS-Coherence
subplot(2,3,1);
imagesc(coherence_matrix3), colormap jet, caxis([0 1]);
% Pearson
subplot(2,3,2);
imagesc(corr_pearson3), colormap jet, caxis([-1 1]);
% Imagery Coherency
subplot(2,3,3);
imagesc(img_coherency_matrix3), colormap jet, caxis([0 1]);
% PLV
subplot(2,3,4);
imagesc(plv_matrix3), colormap jet, caxis([0 1]);
% PLI
subplot(2,3,5);
imagesc(pli_matrix3), colormap jet, caxis([0 1]);
% W-PLI
subplot(2,3,6);
imagesc(wpli_matrix3), colormap jet, caxis([0 1]);
