function [result_matrix] = nan_diagonal(functional_matrix, voxels)
% Prendiamo la matrice 84x84 funzionale e mettiamo a NaN i valori della
% diagonale

% Portare a zero i valori negativi
result_matrix = zeros(voxels);
for k=1:voxels
    for m=1:voxels
        if k == m
            result_matrix(k,m) = NaN;
        else
            result_matrix(k,m) = functional_matrix(k,m);
        end
    end
end