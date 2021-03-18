function pdc_matrix = pdc(fMRI_norm_matrix, brain_sort_matrix, sign_in_network)

% Dati
volumes = 400;
voxels = 84;
vec_vol = 1:volumes;
vec_voxels = 1:voxels;
TR = 0.72;
n_networks = 16;

% Creiamo il vettore tempo
L = TR * volumes;
time = (0:TR:L-TR);
Fs = 1/TR;

% mi aspetto 16 canali x 400 samples, ciclo su fMRI_norm_matrix e raggruppo
% per network, alla fine medio
test = zeros(400,16);
m = 1;
while str2double(brain_sort_matrix(m,2)) ~= 0
    test(:,str2double(brain_sort_matrix(m,2))) = test(:,str2double(brain_sort_matrix(m,2)))+fMRI_norm_matrix(:,m);
    m = m+1;
end

while str2double(brain_sort_matrix(m,2)) == 0
    test(:,str2double(brain_sort_matrix(m,2))+8) = test(:,str2double(brain_sort_matrix(m,2))+8) + fMRI_norm_matrix(:,m);
    m =m+ 1;
end
j = m;
for m = j :84
   if str2double(brain_sort_matrix(m,2))== 0
       test(:,str2double(brain_sort_matrix(m,2))+16) = test(:,str2double(brain_sort_matrix(m,2))+16) + fMRI_norm_matrix(:,m);  
   else
       test(:,str2double(brain_sort_matrix(m,2))+8) = test(:,str2double(brain_sort_matrix(m,2)))+fMRI_norm_matrix(:,m);
   end
end

for l = 1:16
    test(:,l) = test(:,l)/sign_in_network(l);
end

Y = test'; %test matrice 400x16, segnali mediati per ogni network => Y = 16 x 400

% PARTE 1 => IDENTIFICAZIONE DEL MODELLO MVAR (YULE WALKER)
% Mode, determines estimation algorithm (0: builtin least squares, else other methods -> mvar.m in biosig package)
% Am = [A(1)...A(p)], M*pM matrix of the estimated MVAR model coefficients
% S, estimated M*M input covariance matrix
% Yp, estimated time series
% Up, estimated residuals
% Y = fMRI_norm_matrix'; %=>per studiare le time series singolarmente

p = 4; %ordine del modello   
[M,N] = size(Y); %M numero di segnali =16. N numero di campioni = 400
Z = NaN * ones(p*M, N-p); %observation matrix ones(4*16, 400-4)

for j = 1:p
    for ii =1:M
        Z((j-1)*M+ii,1:N-p)=Y(ii,p+1-j:N-j);
    end
end

Mdl = varm(n_networks, p);
Amp = estimate(Mdl,Y');
Am = [];
for iii = 1 : p
   Am = horzcat(Am, Amp.AR{1,iii});
end

Yp = Am*Z; 
Yp= [NaN*ones(M,p) Yp]; %vector of predicted data %con questa operazione Yp passa da 84x390 a 84x400 (aggiungo p colonne lunghe 84 di NaN)

Up = Y-Yp; %dalla matrice originale rimuovo i valori predetti
Up = Up(:,p+1:N); %residuals of strictly causal model->  %rimuovo le p colonne di NaN

% PARTE 2 => ANALISI NEL DOMINIO DELLA FREQUENZA DEL MODELLO MVAR RICAVATO SOPRA
% N = number of points for calculation of the spectral functions
% Fs = sampling frequency
%il vettore che lui usa qua è di 400! noi per la tdf lo usiamo di 200
%invece che usare il suo f lungo 400, se usiamo il nostro lungo 200? => la
%PDC risulta su 200 valori

f = 0:Fs/volumes:Fs-Fs/volumes; %frequency vector

z = 1i*2*pi/Fs;  %= 0 + 4.5239i
PDC1=zeros(M,M,N); % PDC Baccala Sameshima 2001

tmp1=zeros(M,1); 
tmp4=tmp1'; %denominators for PDC (row!)

A = [eye(M) -Am]; % matrix from which M*M blocks are selected to calculate spectral functions
tmp3 = zeros(1,16);

for n=1:N % at each frequency
    
        %%% Coefficient matrix in the frequency domain
        As = zeros(M,M); % matrix As(z)=I-sum(A(k))
        for k = 1:p+1
            As = As + A(:,k*M+(1-M:0))*exp(-z*(k-1)*f(n));  %indicization (:,k*M+(1-M:0)) extracts the k-th M*M block from the matrix B (A(1) is in the second block, and so on)
        end
        
        %%% denominators of PDC
        for m = 1:M
            tmpp1 = squeeze(As(:,m)); % this takes the m-th column of As...
            tmp3(m) = sqrt(tmpp1'*tmpp1); % for the PDC - don't use covariance information
        end
           
        %%% Partial Directed Coherence (Eq. 15 without sigmas)
        PDC1(:,:,n)  = As./tmp3(ones(1,M),:);
        %nota: tmp3(ones(1,M),:) crea M righe tutte uguali a tmp3 - la colonna (ossia il den) è la stessa - trova in un colpo solo tutti i denominatori per PDC
end

% Calcolo
pdc_matrix = zeros(M);

for ii = 1 :M
    for jj = 1:M        
        pdc_matrix(ii,jj) = mean(abs(PDC1(ii,jj,4:24))) ;
    end
end