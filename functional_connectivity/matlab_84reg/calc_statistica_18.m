function [matrix_result] = calc_statistica_18(matrix_statistica, voxels, vet_cum)
% Funzione che, data una matrice, risultato di una misura statistica,
% restituisce una matrice 18x18, dove l'elemento a(i,j) è il valore medio
% della misura statistica sulla connettività tra il network i-esimo e
% quello j-esimo. La matrice è 18x18 perchè i network sono 9 (compreso il
% no network e cerebellum) da considerare due volte per Right / Left

% Istanziamo la matrice risultato
matrix_result = zeros(length(vet_cum), length(vet_cum));
% Creiamo la matrice ausiliare che ci serve per delimitare i network
vet_aux = cat(2, 1, vet_cum(1,1:end-1)+1);
% Ciclo esterno che ci fa scorrere, in modo globale, orizzontalmente lungo
% i 16 network
for m = 1:length(vet_cum)
    % Indice che ci fa scorrere lungo i vettori vet_cum e vet_aux
    count_cum = m;
    % Variabile somma che tiene conto dei valori della matrice di
    % statistica
    sum = 0;
    % Variabile che conta quanti valori di statistica sono stati passati
    count = 0;
    % Cicliamo sulle righe
    for i = vet_aux(count_cum):voxels
        % Controlliamo quando siamo arrivati alla fine di un network, così
        % possiamo mediare i valori
        if i == vet_cum(count_cum)+1
            matrix_result(count_cum,m) = sum/count;
            count_cum = count_cum + 1;
            sum = 0;
            count = 0;
        end
        % Cicliamo sulle colonne del m-esimo network sulle x
        for k = vet_aux(m):vet_cum(m)
            if isnan(matrix_statistica(i,k))
                break;
            end
            sum = sum + matrix_statistica(i,k);
            count = count + 1;
        end
        % Se arrivati all'ultima riga
        if i == voxels
            matrix_result(count_cum,m) = sum/count;
        end
    end
end


