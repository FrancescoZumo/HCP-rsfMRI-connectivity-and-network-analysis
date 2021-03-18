function img_coherency_matrix = imagery_coherency(hilbert_matrix, vec_voxels)
% Authors: Edoardo Paolini, Walter Endrizzi
% 18/04/2020
% Questa funzione, data una matrice di Hilbert di dati EEG, MEG o fMRI, e il vettore 
% delle regioni compie l'analisi tramite la parte immaginaria delle Coherency
% tra le varie colonne (rappresentanti i segnali di ogni regione), restituendo una matrice quadrata dove ogni 
% cella è il valore di Imaginery Coherency tra due time-series.
% NB: la parte commentata nel codice con oppure deve essere simultanea per
% valere (ovvero valgono se entrambe attive)

img_coherency_matrix = zeros(length(vec_voxels));

for i = vec_voxels
   for k = vec_voxels
       if k == i
           img_coherency_matrix(i,k) = 1;
       else
           xy = mean(abs(hilbert_matrix(:,i)).*abs(hilbert_matrix(:,k)).*exp(1j*(angle(hilbert_matrix(:,i)) - angle(hilbert_matrix(:,k)))));
           xx = mean(abs(hilbert_matrix(:,i)).^2);
           yy = mean(abs(hilbert_matrix(:,k)).^2);
           im_coh = imag(xy./sqrt(xx.*yy));
           img_coherency_matrix(i,k) = im_coh;
           img_coherency_matrix(k,i) = im_coh;
       end
   end
end