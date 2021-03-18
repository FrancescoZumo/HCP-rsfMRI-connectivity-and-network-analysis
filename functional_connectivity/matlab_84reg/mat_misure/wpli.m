function wpli_matrix = wpli(hilbert_matrix, vec_voxels)
% Authors: Edoardo Paolini, Walter Endrizzi
% 18/04/2020
% Questa funzione, data una matrice di Hilbert di dati EEG, MEG o fMRI, e il vettore 
% delle regioni compie l'analisi tramite Weighted Phase Lag Index (W-PLI)
% tra le varie colonne (rappresentanti i segnali di ogni regione), restituendo una matrice quadrata dove ogni 
% cella è il valore di W-PLI tra due time-series.

wpli_matrix = zeros(length(vec_voxels));

for i = vec_voxels
   for k = vec_voxels
       if k == i
           wpli_matrix(i,k) = 1;
       else
           num = abs(mean(angle(hilbert_matrix(:,i))- angle(hilbert_matrix(:,k))));
           wpli_value = num / mean(abs(angle(hilbert_matrix(:,i))-angle(hilbert_matrix(:,k))));
           wpli_matrix(i,k) = wpli_value;
           wpli_matrix(k,i) = wpli_value;
       end
   end
end