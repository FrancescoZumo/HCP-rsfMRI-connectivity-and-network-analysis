function coherence_matrix = calc_mscoherence_hilbert(hilbert_matrix, vec_voxels)
% Authors: Edoardo Paolini, Walter Endrizzi
% 18/04/2020
% Questa funzione, data una matrice di dati EEG, MEG o fMRI, e il vettore 
% delle regioni compie la Ms-Coherence tra le varie colonne (rappresentanti 
% i segnali di ogni regione), restituendo una matrice quadrata dove ogni 
% cella è il valore di Ms-Coherence medio tra due time-series.


coherence_matrix = zeros(length(vec_voxels));
Fs = 1/0.72;
volumes = 400;
f = 0:Fs/volumes:Fs-Fs/volumes;

for i = vec_voxels
   for k = vec_voxels
      if k == i
          coherence_matrix(i,k)=1;
          continue
      else
          xy = mean(abs(hilbert_matrix(:,i)).*abs(hilbert_matrix(:,k)).*exp(1j*(angle(hilbert_matrix(:,i)) - angle(hilbert_matrix(:,k)))));
           xx = mean(abs(hilbert_matrix(:,i)).^2);
           yy = mean(abs(hilbert_matrix(:,k)).^2);
           all_coherence = abs(xy./sqrt(xx.*yy)).^2;
          coherence = mean(all_coherence);
          coherence_matrix(i,k)= coherence;
          coherence_matrix(k,i)= coherence;
      end
    end  
end