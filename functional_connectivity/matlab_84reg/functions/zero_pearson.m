function [corr_pearson_valzero] = zero_pearson(corr_pearson, voxels)
% Prendiamo la matrice 84x84 di Pearson e mettiamo a zero tutti i valori
% negativi

% Portare a zero i valori negativi
aux = corr_pearson < 0;
corr_pearson_valzero = zeros(voxels);
for k=1:voxels
    for m=1:voxels
        if aux(k,m) == 0
            corr_pearson_valzero(k,m) = corr_pearson(k,m);
        end
    end
end