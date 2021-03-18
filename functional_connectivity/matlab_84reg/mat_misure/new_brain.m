function [res_matrix] = new_brain(brain_matrix)
% Isola cerebellum da no-network e ordina mettendo cerebellum sotto
% no-networh

% Parte sx
m_aux = brain_matrix(35,:);
for i = 36:42
    brain_matrix(i-1,:) = brain_matrix(i,:);
     brain_matrix(i-1,2) = '8';
end
brain_matrix(42,:) = m_aux;

for i = 77:83
    brain_matrix(i,2) = '8';
end

% Mettiamo i valori del cerebellum a 9
brain_matrix(42,2) = '9';
brain_matrix(84,2) = '9';

res_matrix = brain_matrix;