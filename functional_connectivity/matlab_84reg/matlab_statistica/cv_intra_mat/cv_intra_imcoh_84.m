function [CV_intra_matrix] = cv_intra_imcoh_84(voxels)
% Calcola il Coeffient of Variation secondo la formula presente
% nel paper "On the Viability of Diffusion MRI-Based Microstructural Biomarkers
% in Ischemic Stroke" di Boscolo Galazzo et al. (2018)

n_soggetti = 45;
lista_soggetti = string(readmatrix('soggetti46.txt'));
s_volumes = '800';

% CV_intra -> VALORE per VALORE
CV_intra_matrix = zeros(voxels);
media_CVintra_array = zeros(1,n_soggetti);
sigws_array = zeros(1,n_soggetti);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
           % Carico soggetto s1200
            img_coherency_matrix_s1200_val_abs_zero_norm = conn_measures.s_1200{m}.img_coherency_matrix_s1200_val_abs_zero_norm;
            % Carico soggetto sretest che uso per overall mean
            img_coherency_matrix_sretest_val_abs_zero_norm = conn_measures.s_retest{m}.img_coherency_matrix_sretest_val_abs_zero_norm;
            % Vettore che serve per l'overall mean
            media_CVintra_array(1,m) = mean([img_coherency_matrix_s1200_val_abs_zero_norm(i,k), img_coherency_matrix_sretest_val_abs_zero_norm(i,k)]);
            % Calcolo per varianza inter-soggetto (sigma_ws)
            sigws_array(1,m) = (img_coherency_matrix_s1200_val_abs_zero_norm(i,k) - img_coherency_matrix_sretest_val_abs_zero_norm(i,k))^2;
        end
        CV_intra_matrix(i,k) = ((sum(sigws_array)/(2*n_soggetti))/mean(media_CVintra_array))*100;
    end
end