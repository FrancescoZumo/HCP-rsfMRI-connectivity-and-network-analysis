function [ICC_matrix] = ICC_pli_84(voxels)
% Calcola l'Intraclass Correlation Coefficient secondo la formula presente
% nel paper "On the Viability of Diffusion MRI-Based Microstructural Biomarkers
% in Ischemic Stroke" di Boscolo Galazzo et al. (2018)

n_soggetti = 45;
lista_soggetti = string(readmatrix('soggetti46.txt'));
s_volumes = '800';

% ICC PEARSON 

% Matrice dei valori ICC
ICC_matrix = zeros(voxels);
% Array di ausilio per calcolare std per ogni regione
std_inter_array = zeros(1,n_soggetti);
std_intra_array = zeros(1,n_soggetti);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
            % Carico soggetto s1200
            pli_matrix_s1200_norm = conn_measures.s_1200{m}.pli_matrix_s1200_norm;
            % Carico soggetto sretest che uso per overall mean
            pli_matrix_sretest_norm = conn_measures.s_retest{m}.pli_matrix_sretest_norm;
            % Accumulo valori connettivit� regione di ogni soggetto
            std_inter_array(1,m) = (pli_matrix_s1200_norm(i,k) + pli_matrix_sretest_norm(i,k))/2;
            % Faccio std tra medesima connettivit� regione del medesimo soggetto nelle
            % due sessioni
            std_intra_array(1,m) = (pli_matrix_s1200_norm(i,k) - pli_matrix_sretest_norm(i,k))^2;
        end
        % Calcolo valore ICC tra 
        ICC_matrix(i,k) = std(std_inter_array)^2 / (std(std_inter_array)^2 + sum(std_intra_array)/(2*n_soggetti));
    end
end