%% DATI GENERALI

% Numero soggetti, lista dei soggetti, numero regioni, volumi, TR
load('subjects.mat');
[vet_dist, vet_label, vet_color, vet_cum] = label(brain_sort_matrix, voxels);

%% ICC ILARIA - Intraclass Correlation Coefficients

% ICC CALCOLATO VALORE PER VALORE, QUINDI OTTENENDO UNA MATRICE DI ICC
% Matrice dei valori ICC
ICC_matrix = zeros(voxels);
% Array di ausilio per calcolare std per ogni regione
std_inter_array = zeros(1,n_soggetti);
std_intra_array = zeros(1,n_soggetti);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
            % Carico soggetto s1200
            percorso = strcat('workspace_msc_424/1200/ws_', lista_soggetti(m,:), '.mat');
            load(percorso);
            % Carico soggetto sretest che uso per overall mean
            percorso = strcat('workspace_msc_424/retest/ws_', lista_soggetti(m,:), '.mat');
            load(percorso);
            % Accumulo valori connettività regione di ogni soggetto
            std_inter_array(1,m) = coh_matrix_s1200(i,k);
            % Faccio std tra medesima connettività regione del medesimo soggetto nelle
            % due sessioni
            std_intra_array(1,m) = (coh_matrix_s1200(i,k) - coh_matrix_sretest(i,k))^2;
        end
        % Calcolo valore ICC tra 
        ICC_matrix(i,k) = std(std_inter_array)^2 / (std(std_inter_array)^2 + sum(std_intra_array)/(2*n_soggetti));
    end
end

%% ICC - Intraclass Correlation Coefficients

% ICC CALCOLATO VALORE per VALORE, QUINDI OTTENENDO UNA MATRICE DI ICC
% Matrice dei valori ICC
ICC_matrix = zeros(voxels);
% Matrice 45x2 che raccoglie i valori
ICC_aux = zeros(n_soggetti,2);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
            % Carico soggetto s1200
            percorso = strcat('workspace_45/1200/ws_', lista_soggetti(m,:), '.mat');
            load(percorso);
            % Carico soggetto sretest che uso per overall mean
            percorso = strcat('workspace_45/retest/ws_', lista_soggetti(m,:), '.mat');
            load(percorso);
            ICC_aux(m,1) = pli_matrix_s1200(i,k);
            ICC_aux(m,2) = pli_matrix_sretest(i,k);
        end
        ICC_matrix(i,k) = ICC(ICC_aux, '3', '1');
    end
end

max_icc = max(max(ICC_matrix));

% Media dei valori risultanti
media_ICC = 0;
count = 0;
for i = 1:voxels
    for k = 1:i
        if isnan(ICC_matrix(i,k))
            continue;
        end
        media_ICC = media_ICC + ICC_matrix(i,k);
        count = count + 1;
    end
end
media_ICC = media_ICC / count;

%% CV_intra - Coefficient of Variation

% CV_intra -> VALORE per VALORE
CV_intra_matrix = zeros(voxels);
media_CVintra_array = zeros(1,n_soggetti);
sigws_array = zeros(1,n_soggetti);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
            % Carico soggetto s1200
            percorso = strcat('workspace_msc_424/1200/ws_', lista_soggetti(m,:), '.mat');
            load(percorso);
            % Carico soggetto sretest che uso per overall mean
            percorso = strcat('workspace_msc_424/retest/ws_', lista_soggetti(m,:), '.mat');
            load(percorso); 
            % Vettore che serve per l'overall mean
            media_CVintra_array(1,m) = mean([coh_matrix_s1200(i,k), coh_matrix_sretest(i,k)]);
            % Calcolo per varianza inter-soggetto (sigma_ws)
            sigws_array(1,m) = (coh_matrix_s1200(i,k) - coh_matrix_sretest(i,k))^2;
        end
        CV_intra_matrix(i,k) = ((sum(sigws_array)/(2*n_soggetti))/mean(media_CVintra_array))*100;
    end
end

% Media intra CV
media_CV_intra = 0;
count = 0;
for i = 1:voxels
    for k = 1:i
        if isnan(CV_intra_matrix(i,k))
            continue;
        end
        media_CV_intra = media_CV_intra + CV_intra_matrix(i,k);
        count = count + 1;
    end
end
media_CV_intra = media_CV_intra / count;

%% CV_inter - Coefficient of Variation

% CV_inter -> VALORE per VALORE

% Facciamo sul 1200 (Test)
CV_inter_1200_matrix = zeros(voxels);
media_CVinter_array = zeros(1,n_soggetti);
sig_array = zeros(1,n_soggetti);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
            % Carico soggetto s1200
            percorso = strcat('workspace_45/1200/ws_', lista_soggetti(m,:), '.mat');
            load(percorso); 
            % Vettore che serve per l'overall mean
            media_CVinter_array(1,m) = plv_matrix_s1200(i,k);
            % Calcolo per varianza inter-soggetto (sigma_ws)
            sig_array(1,m) = plv_matrix_s1200(i,k);
        end
        CV_inter_1200_matrix(i,k) = (std(sig_array) / mean(media_CVinter_array))*100;
    end
end

% Facciamo sul Retest
CV_inter_retest_matrix = zeros(voxels);
media_CVinter_array = zeros(1,n_soggetti);
sig_array = zeros(1,n_soggetti);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
            % Carico soggetto sretest
            percorso = strcat('workspace_45/retest/ws_', lista_soggetti(m,:), '.mat');
            load(percorso); 
            % Vettore che serve per l'overall mean
            media_CVinter_array(1,m) = plv_matrix_sretest(i,k);
            % Calcolo per varianza inter-soggetto (sigma_ws)
            sig_array(1,m) = plv_matrix_sretest(i,k);
        end
        CV_inter_retest_matrix(i,k) = (std(sig_array) / mean(media_CVinter_array))*100;
    end
end

% Facciamo la media delle due 
CV_inter_matrix = (CV_inter_1200_matrix + CV_inter_retest_matrix)/2;


%% KENDALL'S COEFFICIENT OF CONCORDANCE

% KENDALL CALCOLATO REGIONE PER REGIONE, QUINDI OTTENENDO UNA MATRICE DI
% KENDALL
% Matrice dei valori Kendall
kendall_matrix = zeros(voxels);
% Matrice 45x2 che raccoglie i valori
kendall_aux = zeros(2,n_soggetti);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
            % Carico soggetto s1200
            percorso = strcat('workspace_45/1200/ws_', lista_soggetti(m,:), '.mat');
            load(percorso);
            % Carico soggetto sretest che uso per overall mean
            percorso = strcat('workspace_45/retest/ws_', lista_soggetti(m,:), '.mat');
            load(percorso);
            kendall_aux(m,1) = corr_pearson_s1200(i,k);
            kendall_aux(m,2) = corr_pearson_sretest(i,k);
        end
        kendall_matrix(i,k) = KendallsW(kendall_aux);
    end
end

%% Root-Mean-Square Deviation

% Calcoliamo per ogni soggetto il RMSD su Pearson
rs_array = zeros(1,n_soggetti);
for i=1:n_soggetti
    percorso = strcat('workspace_45_norm/1200/ws_', lista_soggetti(i,:), '_norm.mat');
    load(percorso);
    % Carico soggetto sretest che uso per overall mean
    percorso = strcat('workspace_45_norm/retest/ws_', lista_soggetti(i,:), '_norm.mat');
    load(percorso);
    rs_array(1,i) = RMSD(corr_pearson_s1200_norm, corr_pearson_sretest_norm);
end
media_rs_array = mean(rs_array);

% Calcoliamo RMSD sulle matrici di media
percorso = strcat('workspace_45_norm/1200/ws_1200_medio_norm.mat');
load(percorso);
% Carico soggetto sretest che uso per overall mean
percorso = strcat('workspace_45_norm/retest/ws_retest_medio_norm.mat');
load(percorso);
rs_medie = RMSD(corr_pearson1_norm, corr_pearson2_norm);

%% DICE COEFFICIENT

dc_array = zeros(1,n_soggetti);
for i=1:45
    percorso = strcat('workspace_45_norm/1200/ws_', lista_soggetti(i,:), '_norm.mat');
    load(percorso);
    % Carico soggetto sretest che uso per overall mean
    percorso = strcat('workspace_45_norm/retest/ws_', lista_soggetti(i,:), '_norm.mat');
    load(percorso);
    dc_array(1,i) = DC(corr_pearson_s1200_norm, corr_pearson_sretest_norm, 0.8, 0.8, 1);
end
media_dc_array = mean(dc_array);

% Calcoliamo RMSD sulle matrici di media
percorso = strcat('workspace_45_norm/1200/ws_1200_medio_norm.mat');
load(percorso);
% Carico soggetto sretest che uso per overall mean
percorso = strcat('workspace_45_norm/retest/ws_retest_medio_norm.mat');
load(percorso);
dc_medie = DC(corr_pearson1_norm, corr_pearson2_norm, 0.8, 0.8, 1);

%% Wilcoxon signed rank test
% returns the p-value of a paired, two-sided test for the null hypothesis that 
% x – y comes from a distribution with zero median.

% Matrice dei valori Wilcoxon
w_matrix = zeros(voxels);
h_matrix = zeros(voxels);
% Matrice 45x2 che raccoglie i valori
w_aux = zeros(n_soggetti,2);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
            % Carico soggetto s1200
            percorso = strcat('workspace_45_424_84reg/1200/ws_', lista_soggetti(m,:), '.mat');
            load(percorso);
            % Carico soggetto sretest che uso per overall mean
            percorso = strcat('workspace_45_424_84reg/retest/ws_', lista_soggetti(m,:), '.mat');
            load(percorso);
            w_aux(m,1) = corr_pearson_s1200(i,k);
            w_aux(m,2) = corr_pearson_sretest(i,k);
        end
        [w_matrix(i,k), h_matrix(i,k)] = signrank(w_aux(:,1)', w_aux(:,2)');
    end
end

% Media dei valori risultanti
media_w = 0;
count = 0;
for i = 1:voxels
    for k = 1:i
        if isnan(w_matrix(i,k))
            continue;
        end
        media_w = media_w + w_matrix(i,k);
        count = count + 1;
    end
end
media_w = media_w / count;

%% PLOTTING MATRICI

plot_matrix(CV_intra_matrix, 'ICC', [0.2 0.7], voxels,...
    vet_dist, vet_label, vet_color, vet_cum);

%% Calcolo Statistica su Network e Plotting risultato

% Calcoliamo
matrix_statistica = calc_statistica_18(ICC_matrix, voxels, vet_cum);
% Plottiamo
plot_statistics(matrix_statistica, 'ICC networks', [0 1], length(matrix_statistica(1,:)), vet_label);