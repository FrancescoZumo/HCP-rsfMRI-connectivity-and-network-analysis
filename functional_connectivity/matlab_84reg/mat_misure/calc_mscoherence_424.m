function coherence_matrix = calc_mscoherence_424(dati_matrix, vec_voxels)
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
   coh1 = dati_matrix(:,i);
   for k = vec_voxels
      if k == i
          coherence_matrix(i,k)=1;
          continue
      else
          coh2 = dati_matrix(:,k);
          all_coherence = mscohere(coh1, coh2, [], [], f(4:24), Fs);
          coherence = mean(all_coherence);
          coherence_matrix(i,k)= coherence;
          coherence_matrix(k,i)= coherence;
      end
    end  
end