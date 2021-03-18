function img_coherency_matrix = imaCohe(hilbert_matrix, vec_voxels)
% Authors: Edoardo Paolini, Walter Endrizzi
% 18/04/2020
% Questa funzione, data una matrice di Hilbert di dati EEG, MEG o fMRI, e il vettore 
% delle regioni compie l'analisi tramite la parte immaginaria delle Coherency
% tra le varie colonne (rappresentanti i segnali di ogni regione), restituendo una matrice quadrata dove ogni 
% cella è il valore di Imaginery Coherency tra due time-series.
% NB: la parte commentata nel codice con oppure deve essere simultanea per
% valere (ovvero valgono se entrambe attive)

% Si poteva anche passare fMRI_norm_matrix, al posto di hilbert e prendere
% la parte reale (comunque nella teoria, e anche nella pratica, sono
% uguali, appunto perche real di hilbert è il segnale stesso, ovvero
% fMRI_norm_matrix)

img_coherency_matrix = zeros(length(vec_voxels));
Fs = 1/0.72;
volumes = 400;
f = 0:Fs/volumes:Fs-Fs/volumes;

for i = vec_voxels
   for k = vec_voxels
       if k == i
           img_coherency_matrix(i,k) = 1;
       else
           xy = mean(abs(hilbert_matrix(:,i)).*abs(hilbert_matrix(:,k)).*sin(angle(hilbert_matrix(:,i)) - angle(hilbert_matrix(:,k))));
           xx = mean(abs(hilbert_matrix(:,i)).^2);
           yy = mean(abs(hilbert_matrix(:,k)).^2);
           im_coh = xy./sqrt(xx.*yy);
           img_coherency_matrix(i,k) = im_coh;
           img_coherency_matrix(k,i) = im_coh;
       end
   end
end