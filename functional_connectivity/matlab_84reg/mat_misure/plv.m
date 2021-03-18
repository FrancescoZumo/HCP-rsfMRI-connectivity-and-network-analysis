function plv_matrix = plv(hilbert_matrix, vec_voxels)
% Authors: Edoardo Paolini, Walter Endrizzi
% 18/04/2020
% Questa funzione, data una matrice di Hilbert di dati EEG, MEG o fMRI, e il vettore 
% delle regioni compie l'analisi tramite Phase Locking Value (PLV)
% tra le varie colonne (rappresentanti i segnali di ogni regione), restituendo una matrice quadrata dove ogni 
% cella è il valore di PLV tra due time-series.

plv_matrix = zeros(length(vec_voxels));

for i = vec_voxels
   for k = vec_voxels
       if k == i
           plv_matrix(i,k) = 1;
       else
           plv_value = abs(mean(exp(1j*(angle(hilbert_matrix(:,i)) - angle(hilbert_matrix(:,k))))));
           plv_matrix(i,k) = plv_value;
           plv_matrix(k,i) = plv_value;
       end
   end
end