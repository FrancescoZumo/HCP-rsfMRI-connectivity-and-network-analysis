function pli_matrix = pli_sin(hilbert_matrix, vec_voxels)
% Authors: Edoardo Paolini, Walter Endrizzi
% 18/04/2020
% Questa funzione, data una matrice di Hilbert di dati EEG, MEG o fMRI, e il vettore 
% delle regioni compie l'analisi tramite Phase Locking Value (PLV)
% tra le varie colonne (rappresentanti i segnali di ogni regione), restituendo una matrice quadrata dove ogni 
% cella è il valore di PLV tra due time-series.

pli_matrix = zeros(length(vec_voxels));

for i = vec_voxels
   for k = vec_voxels
       if k == i
           pli_matrix(i,k) = 1;
       else
           pli_value = abs(mean(sign(sin(angle(hilbert_matrix(:,i)) - angle(hilbert_matrix(:,k))))));
           pli_matrix(i,k) = pli_value;
           pli_matrix(k,i) = pli_value;
       end
   end
end