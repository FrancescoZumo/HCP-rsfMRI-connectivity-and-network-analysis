function [img_coherency_matrix_val_abs_zero] = abs_zero_imcoh(img_coherency_matrix, voxels)
% Prendiamo la matrice 84x84 di ImCoh e mettiamo positivi tutti i valori
% negativi

% ABS
img_coherency_matrix_val_abs_zero = abs(img_coherency_matrix);

% A ZERO
%{
aux = corr_pearson_sretest < 0;
img_coherency_matrix_sretest_valzero = zeros(voxels);
for k=1:voxels
    for m=1:voxels
        if aux(k,m) == 0
            img_coherency_matrix_sretest_valzero(k,m) = img_coherency_matrix_sretest(k,m);
        end
    end
end
%}