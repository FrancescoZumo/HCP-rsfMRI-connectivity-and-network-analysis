function [vet, vet2, vet3, vet4] = label(brain_matrix, voxels)

% Creiamo il vettore di tutti i label 
vet_label2 = ["L-Visual", "L-Somatomotor", "L-Dorsal\_Attention", "L-Ventral\_Attention",...
    "L-Limbic", "L-Frontoparietal", "L-Default", "L-No\_Network", "L-Cerebellum"...
    "R-Visual", "R-Somatomotor", "R-Dorsal\_Attention", "R-Ventral\_Attention",...
    "R-Limbic", "R-Frontoparietal", "R-Default", "R-No\_Network", "R-Cerebellum"];
% Creiamo il vettore degli 8 colori
%{
vet_colori = [0,0,0; 0,0,1; 0,1,0; 0,1,1; 1,0,0; 1,0,1; 1,1,0; 1,1,1;...
   0,0,0; 0,0,1; 0,1,0; 0,1,1; 1,0,0; 1,0,1; 1,1,0; 1,1,1;...
   0,0,0; 0,0,1; 0,1,0; 0,1,1; 1,0,0; 1,0,1; 1,1,0; 1,1,1;...
   0,0,0; 0,0,1; 0,1,0; 0,1,1; 1,0,0; 1,0,1; 1,1,0; 1,1,1];
%}
vet_colori = vertcat(lines(7),[1,1,1], [1,0.654,1]);
vet_colori = vertcat(vet_colori, vet_colori);

% Creiamo il vettore dei colori che sarà plasamto in base ai network
% presenti, e lo daremo come risultato della funzione
vet3 = zeros(voxels,3);
% Numero totale dei network (9 SX e 9 DX)
a = 18;
% Vettore logico che ci servirà per creare il vettore dei label
% da dare come risultato della funzione
vet_logico = false(1,a);
% indice utile per i vari vettori
k = 1;
% Trasformiamo in interi gli string che denotano i vari network
brain_int = uint8(str2double(brain_matrix(:,2)));
h = brain_int(1);
cont = 0;
% Creiamo il vettore dei label con il ciclo
% Ciclo emisfero SX
for i = 1:voxels
    cont = cont+1;
    if h > brain_int(i) || (h == 0 && brain_int(i) ~= h)
        h = brain_int(i);
        break;
    end
    if h ~= brain_int(i)
        h = brain_int(i);
        k = k + 1;
    end
    if vet_logico(h) == false
        vet_logico(h) = true;
    end
end
if h == 0
    vet_logico(h+9) = true;
end
% Ciclo emisfero DX
cont = cont-1;
for i = cont:voxels
    if h ~= brain_int(i)
        h = brain_int(i);
        k = k + 1;
    end
    if h ~= 0
        if vet_logico(h+9) == false
            vet_logico(h+9) = true;
        end
    else
        if vet_logico(h+18) == false
            vet_logico(h+18) = true;
        end
    end
end

% Vediamo con il vettore logico quali network ci sono o meno
% e creiamo quindi il vettore dei label
k = k-1;
cont = 1;
vet2 = string(double(zeros(1,k)));
for i = 1:a
    if vet_logico(i) == true
        vet2(cont) = vet_label2(i);
        cont = cont +1;
    end
end

% Rifacciamo il procedimento per il vettore delle distanze e dei colori
vet = zeros(1,k+1);
k = 1;
h = brain_int(1);
cont = 0;
% Ciclo emisfero SX
for i = 1:voxels
    cont = cont+1;
    if h > brain_int(i) || (h == 0 && brain_int(i) ~= h)
        break;
    end
    if h ~= brain_int(i)
        h = brain_int(i);
        k = k + 1;
    end
    vet(1,k) = vet(1,k) + 1;
    vet3(i,:) = vet_colori(h,:);
end
% Ciclo emisfero DX
for i = cont:voxels
    if h ~= brain_int(i)
        h = brain_int(i);
        k = k + 1;
    end
    vet(1,k) = vet(1,k) + 1;
    vet3(i,:) = vet_colori(h+9,:);
end
vet_medio = vet/2;
vet = cumsum(vet);
vet4 = vet(1,1:end-1);
vet = vet - vet_medio;
%z = 0;
vet = vet(1,1:end-1);
vet = vet+1;
        
end




    