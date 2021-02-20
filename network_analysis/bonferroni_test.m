function [bonf_P_wilcoxon_matrix, bonf_H_wilcoxon_matrix] = bonferroni_test(P_wilcoxon_matrix, voxels)

% Numero dei tets. Consideriamo solo la matrice triangolare inferiore e non
% dobbiamo fare cose strane per il calcolo delle nuove, perchè tanto i
% valori superiori sono già a zero quindi x*n_test = 0
n_test = (voxels*(voxels-1))/2;

% Generiamo le nuove matrici P-Value con la Correzione di Bonferroni
bonf_P_wilcoxon_matrix = P_wilcoxon_matrix .* n_test;

% Generiamo le nuove matrici H-Value con la Correzione di Bonferroni
bonf_H_wilcoxon_matrix = bonf_P_wilcoxon_matrix < 0.05;
