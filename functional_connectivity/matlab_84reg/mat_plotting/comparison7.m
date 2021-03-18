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

% Scelta 5 soggetti random
subjects2 = randperm(45,7);
subjects = [lista_soggetti(subjects2(1)), lista_soggetti(subjects2(2)), lista_soggetti(subjects2(3)),...
    lista_soggetti(subjects2(4)), lista_soggetti(subjects2(5)), lista_soggetti(subjects2(6)), lista_soggetti(subjects2(7))];
clear subjects2;

%% MISURE 1200

% Carichiamo il workspace medio
load('workspace_46/1200/ws_1200_medio.mat');

% Scegliere la misura di connettività
fprintf('Su quale misura si vuole fare il confronto?\n(ms-coherence = msc)\n(pearson = pes)\n(determinazione = det)\n');
fprintf('(imc = imaginery coherency)\n(plv = plv)\n(pli = pli)\n(wpli = wpli)\n');
measure = input('Risposta: ');
if strcmp(measure, 'msc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison MS-Coherence');
    for i = 1:7
        % Calcoliamo MS-Coherence
        percorso = strcat('workspace_46/1200/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(coherence_matrix_s1200), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(coherence_matrix1), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'pes')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Pearson');
    for i = 1:7
        % Calcoliamo Pearson
        percorso = strcat('workspace_46/1200/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(corr_pearson_s1200), colormap jet, caxis([-1 1]);
    end
    subplot(2,4,8);
    imagesc(corr_pearson1), colormap jet, caxis([-1 1]);
elseif strcmp(measure, 'det')
     % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Determinazione');
    for i = 1:7
        % Calcoliamo Determinazione
        percorso = strcat('workspace_46/1200/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(coef_det_s1200), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(coef_det1), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'imc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Imaginery Coherency');
    for i = 1:7
        % Calcoliamo MS-Coherence
        percorso = strcat('workspace_46/1200/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(img_coherency_matrix_s1200), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(img_coherency_matrix1), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'plv')
     % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLV');
    for i = 1:7
        % Calcoliamo PLV
        percorso = strcat('workspace_46/1200/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(plv_matrix_s1200), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(plv_matrix1), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'pli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLI');
    for i = 1:7
        % Calcoliamo PLI
        percorso = strcat('workspace_46/1200/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(pli_matrix_s1200), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(pli_matrix1), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'wpli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison W-PLI');
    for i = 1:7
        % Calcoliamo W-PLI
        percorso = strcat('workspace_46/1200/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(wpli_matrix_s1200), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(wpli_matrix1), colormap jet, caxis([0 1]);
else
    error('Errore di inserimento. Rilanciare la sezione.');
end

%% MISURE RETEST

% Carichiamo il workspace medio
load('workspace_46/retest/ws_retest_medio.mat');

% Scegliere la misura di connettività
fprintf('Su quale misura si vuole fare il confronto?\n(ms-coherence = msc)\n(pearson = pes)\n(determinazione = det)\n');
fprintf('(imc = imaginery coherency)\n(plv = plv)\n(pli = pli)\n(wpli = wpli)\n');
measure = input('Risposta: ');
if strcmp(measure, 'msc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison MS-Coherence');
    for i = 1:7
        % Calcoliamo MS-Coherence
        percorso = strcat('workspace_46/retest/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(coherence_matrix_sretest), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(coherence_matrix2), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'pes')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Pearson');
    for i = 1:7
        % Calcoliamo Pearson
        percorso = strcat('workspace_46/retest/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(corr_pearson_sretest), colormap jet, caxis([-1 1]);
    end
    subplot(2,4,8);
    imagesc(corr_pearson2), colormap jet, caxis([-1 1]);
elseif strcmp(measure, 'det')
     % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Determinazione');
    for i = 1:7
        % Calcoliamo Determinazione
        percorso = strcat('workspace_46/retest/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(coef_det_sretest), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(coef_det2), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'imc')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison Imaginery Coherency');
    for i = 1:7
        % Calcoliamo Imaginery Coherency
        percorso = strcat('workspace_46/retest/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(img_coherency_matrix_sretest), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(img_coherency_matrix2), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'plv')
     % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLV');
    for i = 1:7
        % Calcoliamo PLV
        percorso = strcat('workspace_46/retest/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(plv_matrix_sretest), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(plv_matrix2), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'pli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison PLI');
    for i = 1:7
        % Calcoliamo PLI
        percorso = strcat('workspace_46/retest/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(pli_matrix_sretest), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(pli_matrix2), colormap jet, caxis([0 1]);
elseif strcmp(measure, 'wpli')
    % Definiamo la figure
    figure('NumberTitle', 'off', 'Name', 'Comparison W-PLI');
    for i = 1:7
        % Calcoliamo W-PLI
        percorso = strcat('workspace_46/retest/ws_', subjects(i), '.mat');
        load(percorso);
        subplot(2,4,i);
        imagesc(wpli_matrix_sretest), colormap jet, caxis([0 1]);
    end
    subplot(2,4,8);
    imagesc(wpli_matrix2), colormap jet, caxis([0 1]);
else
    error('Errore di inserimento. Rilanciare la sezione.');
end