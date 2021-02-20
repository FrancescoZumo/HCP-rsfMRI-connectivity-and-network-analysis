function [w_matrix, h_matrix] = wilcoxon_wpli_84(voxels)
% returns the p-value of a paired, two-sided test for the null hypothesis that 
% x – y comes from a distribution with zero median.

n_soggetti = 45;
lista_soggetti = string(readmatrix('soggetti46.txt'));
s_volumes = '800';

% Matrice dei valori Wilcoxon
w_matrix = zeros(voxels);
h_matrix = zeros(voxels);
% Matrice 45x2 che raccoglie i valori
w_aux = zeros(n_soggetti,2);
for i = 1:voxels
    for k = 1:i
        for m = 1:n_soggetti
            % Carico soggetto s1200
            percorso = strcat('workspace_84reg_', s_volumes, '_norm/1200/ws_',lista_soggetti(m,:),'_norm.mat');
            load(percorso);
            % Carico soggetto sretest che uso per overall mean
            percorso = strcat('workspace_84reg_', s_volumes, '_norm/retest/ws_',lista_soggetti(m,:),'_norm.mat');
            load(percorso);
            if i == k
                w_aux(m,1) = 1;
                w_aux(m,2) = 1;
            else
                w_aux(m,1) = wpli_matrix_s1200_norm(i,k);
                w_aux(m,2) = wpli_matrix_sretest_norm(i,k);
            end
        end
        [w_matrix(i,k), h_matrix(i,k)] = signrank(w_aux(:,1)', w_aux(:,2)');
    end
end