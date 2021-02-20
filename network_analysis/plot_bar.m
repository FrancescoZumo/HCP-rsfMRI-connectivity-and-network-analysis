load('results/full_workspace.mat');
load('barin_sort_matrix.mat');
load('vet_color.mat');

% da aggiungere una n quando rilancerai lo script network_analysis.m
net_measure_name = {'Betweenness_centrality'};

% vettore colori network
vet_colori = vertcat(lines(7),[0,0,0], [1,0.654,1]);
vet_colori = vertcat(vet_colori, vet_colori);

% vettore 84x1 che assegna  network a ogni nodo
vet_networks = round(str2double(brain_sort_matrix(:, 2)));
% statistiche che verranno considerate
stats_names = {'ICC', 'cv_intra', 'cv_inter', 'Wilcoxon_bonferroni_p_matrix', 'Wilcoxon_bonferroni_h_matrix'};
% struttura in cui verranno salvate le tabelle risultanti
stat_tables = cell2struct(cell(numel(stats_names), 1) ,stats_names);

% per ogni misura di connettività
for m = 1:numel(short_m_names)
    
    %% stat media per ogni network (ad ogni ciclo esterno, genero l'm-esima riga di ogni tabella finale)
    for stat = 1:numel(stats_names)
        % importo il vettore della statistica in questione per ogni nodo
        vett_stat_original = group_measures.(short_m_names{m}).stats.(net_measure_name{1}).(stats_names{stat})(:, 1);
        % contatore nodi per ogni network
        vett_counter = zeros(1, 9);
        % AZZERO verrore temporaneo
        vett_stat_temp = zeros(1, 9);
        
        % per ogni nodo, 
        for node = 1:84
            % sommo valore del nodo attuale di statistica all'accumulo di
            % valori del corrispondente network
            vett_stat_temp(vet_networks(node)) = vett_stat_temp(vet_networks(node)) + vett_stat_original(node);
            % incremento contatore network
            vett_counter(vet_networks(node)) = vett_counter(vet_networks(node)) + 1;
        end
        % faccio la media
        vett_stat_temp = vett_stat_temp ./ vett_counter;
        % inserisco la riga nella tabella corrispondente
        stat_tables.(stats_names{stat})(m, :) = vett_stat_temp;
        
    end
    
    
    %% barplot
    %{
    % prendiamo i risultati di BC test e retest
    T = group_measures.(short_m_names{m}).s_1200.(net_measure_name{1});
    R = group_measures.(short_m_names{m}).s_retest.(net_measure_name{1});
    
    % riordiniamo i valori della metrica
    T_index = [T, linspace(1, 84, 84)'];
    T_index = sortrows(T_index, 1,'descend');
    R_index = [R, linspace(1, 84, 84)'];
    R_index = sortrows(R_index, 1,'descend');
    
    R_indexTemp = [R, linspace(1, 84, 84)'];
    R_ordered_like_T = R_indexTemp;
    for i = 1:84
        R_ordered_like_T(i, :) = R_indexTemp(T_index(i, 2));
    end

    % ordiniamo i colori secondo l'ordine di T_index/R_index
    vett2T = zeros(84,3);
    vett2R = zeros(84,3);
    sortedLabelsT = brain_sort_matrix(:, 1);
    sortedLabelsR = brain_sort_matrix(:, 1);
    for i = 1:84
        vett2T(i,:) = vet_colori(str2double(brain_sort_matrix(round(T_index(i, 2)),2)), :);
        sortedLabelsT(i) = brain_sort_matrix(round(T_index(i, 2)),1);
        vett2R(i,:) = vet_colori(str2double(brain_sort_matrix(round(R_index(i, 2)),2)), :);
        sortedLabelsR(i) = brain_sort_matrix(round(R_index(i, 2)),1);
    end 
    
    % plot e salvataggio delle figure
    
    h(1) = figure(1);
    sortedFigure = bar(T_index(:, 1), 'FaceColor','flat');
    set(gca, 'XTick', linspace(1, 84, 84), 'XTickLabel', sortedLabelsT);
    xtickangle(45);
    title(strcat(short_m_names{m}, ' BC Test ordered'));

    for i = 1:84
        sortedFigure.CData(i,:) = vett2T(i,:);
    end

    
    h(2) = figure(2);
    sortedFigure = bar(R_index(:, 1), 'FaceColor','flat');
    set(gca, 'XTick', linspace(1, 84, 84), 'XTickLabel', sortedLabelsR);
    xtickangle(45);
    title(strcat(short_m_names{m}, ' BC Retest ordered'));

    for i = 1:84
        sortedFigure.CData(i,:) = vett2R(i,:);
    end
    
    
    h(3) = figure(3);
    not_sorted = bar(T, 'FaceColor','flat');
    set(gca, 'XTick', linspace(1, 84, 84), 'XTickLabel', brain_sort_matrix(:, 1));
    xtickangle(45);
    title(strcat(short_m_names{m}, ' BC Test'));

    for i = 1:84
        not_sorted.CData(i,:) = vet_color(i,:);
    end
    
    
    h(4) = figure(4);
    not_sorted = bar(R, 'FaceColor','flat');
    set(gca, 'XTick', linspace(1, 84, 84), 'XTickLabel', brain_sort_matrix(:, 1));
    xtickangle(45);
    title(strcat(short_m_names{m}, ' BC Retest'));

    for i = 1:84
        not_sorted.CData(i,:) = vet_color(i,:);
    end
    
    
    h(5) = figure(5);
    TestVRetest = bar([T_index(:, 1), R_ordered_like_T(:, 1)], 'FaceColor','flat');
    set(gca, 'XTick', linspace(1, 84, 84), 'XTickLabel', brain_sort_matrix(:, 1));
    xtickangle(45);
    title(strcat(short_m_names{m}, ' BC TestVsRetest ordered by Test'));

    for i = 1:84
        TestVRetest(1).CData(i,:) = vett2T(i,:);
        TestVRetest(2).CData(i,:) = vett2T(i,:);
    end

    savefig(h,strcat('results/Figures_str_', short_m_names{m}, '.fig'))
    close(h)
    %}
    
end