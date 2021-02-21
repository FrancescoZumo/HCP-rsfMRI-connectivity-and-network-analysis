% Author: Francesco Zumerle, University of Verona

% notes (to be removed later)
%
% The network matrices should not contain self-self connections. 
% In other words, all values on the main diagonal of these matrices should
% be set to 0.

% In most cases, the network matrices should not contain negative weights. 
% However, a substantial number of functions can process matrices with 
% positive and negative weights. These functions typically end with sign.m 
% (for signed networks).


%% PREPARING STRUCTURES

% folders containing workspaces used
ws_folders = {'1200', 'retest'};

% names used for structure
ws_pattern = '[0-9]+';
folder_names = ws_folders;
for m = 1:numel(ws_folders)
    if numel(regexp(ws_folders{m}, ws_pattern)) ~= 0
        folder_names{1} = strcat('s_', folder_names{1});
        folder_names{2} = strcat('s_', folder_names{2});
        break
    end
end

% temp cell array
c = cell(length(folder_names),1);

% creating structures
conn_measures = cell2struct(c,folder_names);
group_substruct = conn_measures;

% subjects contained in one folder
nSubjects = 45;

% for each folder contained in ws_folders ...
for m = 1:numel(ws_folders)
    
    conn_measures.(folder_names{m}) = cell(nSubjects, 1);
    net_substruct.(folder_names{m}) = cell(nSubjects, 1);
    
    % save name of each file contained in folder that matches pattern
    % 'ws_*.mat'
    ws_path = dir(strcat('workspace_84reg_800_norm/', ws_folders{m}, '/ws_*.mat'));
    
    if size(ws_path, 1) == 0
        error('directory not found, check your current directory');
    end
    
    % for each file contained in ws_path ...
    k = 1;
    for i = 1:size(ws_path, 1)
        
        % complete check with regexp, so I only use files with specific
        % name
        ws_pattern = 'ws_[0-9]+_norm.mat';
        matches = regexp(ws_path(i).name, ws_pattern);
        if numel(matches) == 0
            continue;
        end
        
        % load subject workspace
        conn_measures.(folder_names{m}){k} = load(strcat(ws_path(i).folder, '/', ws_path(i).name));
        k = k + 1;
    end
end

%% NETWORK MEASURES

measure_1200_names = fieldnames(conn_measures.(folder_names{1}){1});
measure_retest_names = fieldnames(conn_measures.(folder_names{2}){1});

measure_1200_names = measure_1200_names([1, 3, 9, 10, 11, 12]);
measure_retest_names = measure_retest_names([1, 3, 9, 10, 11, 12]);

short_m_names = measure_1200_names;

for n = 1:numel(short_m_names)
    if numel(regexp(short_m_names{n}, '[\w]+_s[retest, 1200]+_[val_abs_zero_, valzero_]*norm'))
        short_m_names{n} = erase(short_m_names{n}, 's1200_');
        short_m_names{n} = erase(short_m_names{n}, 'sretest_');
        short_m_names{n} = erase(short_m_names{n}, '_norm');
    end
end


% temp cell array
c = cell(length(short_m_names),1);

net_measures = cell2struct(c, short_m_names); 
group_measures = cell2struct(c, short_m_names);


%%
% for each conn_measure
for m = 1:numel(short_m_names)
% for m = 1
    
    net_measures.(short_m_names{m}) = net_substruct;
    group_measures.(short_m_names{m}) = group_substruct;
    
    % for each folder
    for f = 1:numel(folder_names)
        
        if f == 1
            measure_names = measure_1200_names;
        else
            measure_names = measure_retest_names;
        end

        %for each subject
        for i = 1:nSubjects
        % for i = 1
            %% SINGLE SUBJECT MEASURES

            % copy current conn_measure as weight matrix
            W = conn_measures.(folder_names{f}){i}.(measure_names{m});

            % removing self-self connections from matrix imported
            W = W .* ~eye(size(W));
            
            % removing NaN values
            W(isnan(W))=0;
            
            % remove negative values
            W = W .* (W > 0);

            % Strength
            % - weighed
            str = strengths_und(W)';

            % Connection-length matrix
            % It can be obtained from weight matrix: length(i,j) = 1/weight(i,j)
            % - weighed
            L = weight_conversion(W, 'lengths');

            % betweeness centrality
            BC = betweenness_wei(L);
            
            % normalization
            BC = BC ./ (83 * 82);

            % shorted weighed path and with Dijkstra algorithm
            % D: distance (shortest weighted path) matrix
            % B: number of edges in shortest weighted path matrix
            [D,B] = distance_wei(L);

            % MODULARITY_UND
            % Ci: optimal community structure
            % Q:  maximized modularity
            [Ci, Q] = modularity_und(W);

            % participation coefficient
            % no negative values
            P = participation_coef(W, Ci, 0);

            % MODULE_DEGREE_ZSCORE
            Z = module_degree_zscore(W, Ci, 0);

            % weights normalization between 0 and 1,
            % needed for clustering_coef and transitivity
            W_nrm = weight_conversion(W, 'normalize');

            % TRANSITIVITY_WU    Transitivity
            % Transitivity is the ratio of 'triangles to triplets' in the network.
            % (A classical version of the clustering coefficient).
            T = transitivity_wu(W_nrm);

            % clustering coefficient
            C = clustering_coef_wu(W_nrm);

            % characteristic path length
            lambda = charpath(D);
            
            % Global and Local Efficiency
            Eglob = efficiency_wei(W);
            Eglobv2 = efficiency_wei(W_nrm);
            
            % density and number of vertices/edges
            [kden,N,K] = density_und(W);
            
            % Small world propensity
            [SWP, delta_C, delta_L] = small_world_propensity(W);
            
            %% NORMALIZED MEASURES 
            
            % Generating n random networks
            n_rand_net = 1;
            str_norm = 0;
            SW = 0;
            BC_rand = zeros(84,n_rand_net);
            % BC_norm = 0;
            Eglob_norm = 0;
            for z = 1:n_rand_net
                % random matrix with null_model_und_sign
                W_rand = null_model_und_sign(W);
                % removing self-self connections
                W_rand = W_rand .* ~eye(size(W_rand));
                
                % repeating network measures
                W_rand_nrm = weight_conversion(W_rand, 'normalize');
                C_rand = clustering_coef_wu(W_rand_nrm);
                L_rand = weight_conversion(W_rand, 'lengths');
                D_rand = distance_wei(L_rand);
                lambda_rand = charpath(D_rand);
                
                % Strength
                str_norm = str_norm + str ./ strengths_und(W_rand)';
                
                % Network small-worldness
                SW = SW + (mean(C)/mean(C_rand))/(lambda/lambda_rand);
                
                % Betweeness centrality
                BC_rand(:, z) = betweenness_wei(L_rand);
                
                % Gobal efficiency
                Eglob_norm = Eglob_norm + Eglob / efficiency_wei(W_rand);
            end
            % results
            str_norm = str_norm ./ n_rand_net;
            SW = SW / n_rand_net;
            BC_norm = BC ./ mean(BC_rand, 2);
            Eglob_norm = Eglob_norm / n_rand_net;
            
            % Network small-worldness without random values
            % S = mean(C)/lambda;

            %% SAVING RESULTS
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Weight') = W;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('Strength') = str;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('Strength_normalized') = str_norm;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Length') = L;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('Betweenness_centrality') = BC;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('Betweenness_centrality_normalized') = BC_norm;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('BC_rand_values_used') = BC_rand;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Distance') = D;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('n_of_edges_in_shortest_path') = B;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Modularity') = Ci;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Participation_coefficient') = P;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Module_degree_zscore') = Z;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Transitivity') = T;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Clustering_coefficient') = C;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Average_Clustering_coefficient') = mean(C);
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Characteristic_path_length') = lambda;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('Global_efficiency') = Eglob;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('Global_efficiency_W_nrm') = Eglobv2;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('Global_efficiency_normalized') = Eglob_norm;
            % net_measures.(short_m_names{m}).(folder_names{f}){i}.('Local_efficiency') = Eloc;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('Small_worldness') = SW;
            net_measures.(short_m_names{m}).(folder_names{f}){i}.('Small_world_propensity') = SWP;

            %% GROUP MEASURES
            
            % initialize variables for mean measures
            if i == 1
                W_mean = 0;
                str_mean = 0;
                str_norm_mean = 0;
                L_mean = 0;
                BC_mean = 0;
                BC_norm_mean = 0;
                D_mean = 0;
                B_mean = 0;
                Ci_mean = 0;
                P_mean = 0;
                Z_mean = 0;
                T_mean = 0;
                C_mean = 0;
                lambda_mean = 0;
                Eglob_mean = 0;
                Eglobv2_mean = 0;
                Eglob_norm_mean = 0;
                % Eloc_mean = 0;
                SW_mean = 0;
                SWP_mean = 0;
                
                % std deviation of rand Betweenness centrality
                BC_std_dev = zeros(84, nSubjects);
            end
            % mean of measures
            W_mean = W_mean + W;
            str_mean = str_mean + str;
            str_norm_mean = str_norm_mean + str_norm;
            L_mean = L_mean + L;
            BC_mean = BC_mean + BC;
            BC_norm_mean = BC_norm_mean + BC_norm;
            D_mean = D_mean + D;
            B_mean = B_mean + B;
            Ci_mean = Ci_mean + Ci;
            P_mean = P_mean + P;
            Z_mean = Z_mean + Z;
            T_mean = T_mean + T;
            C_mean = C_mean + C;
            lambda_mean = lambda_mean + lambda;
            Eglob_mean = Eglob_mean + Eglob;
            Eglobv2_mean = Eglobv2_mean + Eglobv2;
            Eglob_norm_mean = Eglob_norm_mean + Eglob_norm;
            % Eloc_mean = Eloc_mean + Eloc;
            SW_mean = SW_mean + SW;
            SWP_mean = SWP_mean + SWP;
            
            % std deviation of rand Betweenness centrality
            BC_std_dev(:, i) = std(BC_rand, 0, 2);
        end

        % storing group results
        % group_measures.(short_m_names{m}).(folder_names{f}).('Weight') = W_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Strength') = str_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Strength_normalized') = str_norm_mean/nSubjects;
        % group_measures.(short_m_names{m}).(folder_names{f}).('Length') = L_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Betweenness_centrality') = BC_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Betweenness_centrality_normalized') = BC_norm_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Betweenness_centrality_std_deviations') = BC_std_dev;        
        % group_measures.(short_m_names{m}).(folder_names{f}).('Distance') = D_mean/nSubjects;
        % group_measures.(short_m_names{m}).(folder_names{f}).('n_of_edges_in_shortest_path') = B_mean/nSubjects;
        % group_measures.(short_m_names{m}).(folder_names{f}).('Modularity') = Ci_mean/nSubjects;
        % group_measures.(short_m_names{m}).(folder_names{f}).('Participation_coefficient') = P_mean/nSubjects;
        % group_measures.(short_m_names{m}).(folder_names{f}).('Module_degree_zscore') = Z_mean/nSubjects;
        % group_measures.(short_m_names{m}).(folder_names{f}).('Transitivity') = T_mean/nSubjects;
        % group_measures.(short_m_names{m}).(folder_names{f}).('Clustering_coefficient') = C_mean/nSubjects;
        % group_measures.(short_m_names{m}).(folder_names{f}).('Average_Clustering_coefficient') = mean(C_mean/nSubjects);
        % group_measures.(short_m_names{m}).(folder_names{f}).('Characteristic_path_length') = lambda_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Global_efficiency') = Eglob_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Global_efficiency_W_nrm') = Eglobv2_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Global_efficiency_normalized') = Eglob_norm_mean/nSubjects;
        % group_measures.(short_m_names{m}).(folder_names{f}).('Local_efficiency') = Eloc_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Small_worldness') = SW_mean/nSubjects;
        group_measures.(short_m_names{m}).(folder_names{f}).('Small_world_propensity') = SWP_mean/nSubjects;

        % save workspace for each measure selected
        % results = net_measures.(measure_names{m});
        % group_results = group_measures.(measure_names{m});

        % save(strcat('results/', erase(measure_names{m}, '_s1200_norm'), '_net_measures'), 'results', 'group_measures');
    end
    
    %% TEST-RETEST AVERAGE RESULTS
    
    net_measure_names = fieldnames(group_measures.(short_m_names{m}).(folder_names{f}));
    
    % removing std_deviation entry
    net_measure_names(strcmp(net_measure_names, 'Betweenness_centrality_std_deviations')) = [];
    
    % temp cell array
    c = cell(length(net_measure_names),1);
    
    group_measures.(short_m_names{m}).('all') = cell2struct(c, net_measure_names);
    
    for n = 1:numel(net_measure_names)
        group_measures.(short_m_names{m}).all.(net_measure_names{n}) = ...
            (group_measures.(short_m_names{m}).s_1200.(net_measure_names{n}) + ...
            group_measures.(short_m_names{m}).s_retest.(net_measure_names{n})) ./ 2;
    end
    
    
    %% STATISTICAL ANALYSIS

    group_measures.(short_m_names{m}).('stats') = cell2struct(c, net_measure_names); 
    
    % for each network measure
    for n = 1:numel(net_measure_names)
        
%         c = cell(5, 1);
%         stats_names = {'abs_difference', 'ICC', 'cv_intra', 'cv_inter', 'Wilcoxon'};
%         
%         group_measures.(short_m_names{m}).stats.(net_measure_names{n}) = cell2struct(c, stats_names);
        
        
        %% difference
        group_measures.(short_m_names{m}).stats.(net_measure_names{n}).abs_difference = ...
            abs(group_measures.(short_m_names{m}).s_1200.(net_measure_names{n}) - ...
            group_measures.(short_m_names{m}).s_retest.(net_measure_names{n}));
        
        %% standard deviation
        
        nRows = size(group_measures.(short_m_names{m}).(folder_names{f}).(net_measure_names{n}), 1);
        nCols = size(group_measures.(short_m_names{m}).(folder_names{f}).(net_measure_names{n}), 2);
        
        if nCols == 1 && nRows == 1
            tempStd1200 = zeros(1, nSubjects);
            dim = 1;
        elseif nCols == 1
            tempStd1200 = zeros(nRows, nSubjects);
            dim = 2;
        else
            dim = 3;
        end
        tempStdRetest = tempStd1200;
        
        for s = 1:nSubjects
            measure_1200 = net_measures.(short_m_names{m}).(folder_names{1}){s}.(net_measure_names{n});
            measure_retest = net_measures.(short_m_names{m}).(folder_names{2}){s}.(net_measure_names{n});
            switch dim
                case 1
                    tempStd1200(1, s) = measure_1200;
                    tempStdRetest(1, s) = measure_retest;
                case 2
                    tempStd1200(:, s) = measure_1200;
                    tempStdRetest(:, s) = measure_retest;
                otherwise
                    disp('std not performed');
                    break
            end
        end
        
        group_measures.(short_m_names{m}).stats.(net_measure_names{n}).std = ...
            cell2struct({tempStd1200, tempStdRetest, std(tempStd1200, 0, 2), std(tempStdRetest, 0, 2)}', ...
            {'res1200', 'resRetest', 'std1200', 'stdRetest'});
        
        %% ICC
    
        % Matrice dei valori ICC
        
        nRows = size(group_measures.(short_m_names{m}).(folder_names{f}).(net_measure_names{n}), 1);
        nCols = size(group_measures.(short_m_names{m}).(folder_names{f}).(net_measure_names{n}), 2);

        ICC_matrix = zeros(nCols);

        % Array di ausilio per calcolare std per ogni regione
        std_inter_array = zeros(1,nSubjects);
        std_intra_array = zeros(1,nSubjects);


        for i = 1:nRows
            for k = 1:nCols
                for s = 1:nSubjects

                    measure_1200 = net_measures.(short_m_names{m}).(folder_names{1}){s}.(net_measure_names{n});
                    measure_retest = net_measures.(short_m_names{m}).(folder_names{2}){s}.(net_measure_names{n});

                    % Accumulo valori connettività regione di ogni soggetto
                    std_inter_array(1,s) = (measure_1200(i,k) + measure_retest(i,k))/2;
                    % Faccio std tra medesima connettività regione del medesimo soggetto nelle
                    % due sessioni
                    std_intra_array(1,s) = (measure_1200(i,k) - measure_retest(i,k))^2;
                end
                % Calcolo valore ICC tra 
                ICC_matrix(i,k) = std(std_inter_array)^2 / (std(std_inter_array)^2 + sum(std_intra_array)/(2*nSubjects));  
            end 
        end
        
        group_measures.(short_m_names{m}).stats.(net_measure_names{n}).ICC = ICC_matrix;
        
        %% cv_intra
        
        % CV_intra -> VALORE per VALORE
        CV_intra_matrix = zeros(nRows);
        media_CVintra_array = zeros(1,nSubjects);
        sigws_array = zeros(1,nSubjects);
        for i = 1:nRows
            for k = 1:nCols
                for s = 1:nSubjects
                    % carico le misure
                    measure_1200 = net_measures.(short_m_names{m}).s_1200{s}.(net_measure_names{n});
                    measure_retest = net_measures.(short_m_names{m}).(folder_names{2}){s}.(net_measure_names{n});
                    % Vettore che serve per l'overall mean
                    media_CVintra_array(1,s) = mean([measure_1200(i,k), measure_retest(i,k)]);
                    % Calcolo per varianza inter-soggetto (sigma_ws)
                    sigws_array(1,s) = (measure_1200(i,k) - measure_retest(i,k))^2;
                end
                
                CV_intra_matrix(i,k) = ((sum(sigws_array)/(2*nSubjects))/mean(media_CVintra_array))*100;
            end
        end
        
        group_measures.(short_m_names{m}).stats.(net_measure_names{n}).cv_intra = CV_intra_matrix;
        
        %% cv_inter
        
        % Calcola il Coeffient of Variation secondo la formula presente
        % nel paper "On the Viability of Diffusion MRI-Based Microstructural Biomarkers
        % in Ischemic Stroke" di Boscolo Galazzo et al. (2018)

        % Facciamo sul 1200 (Test)
        CV_inter_1200_matrix = zeros(nRows);
        media_CVinter_array = zeros(1,nSubjects);
        sig_array = zeros(1,nSubjects);
        for i = 1:nRows
            for k = 1:nCols
                for s = 1:nSubjects
                    % Carico soggetto s1200
                    measure_1200 = net_measures.(short_m_names{m}).s_1200{s}.(net_measure_names{n});
                    % Vettore che serve per l'overall mean
                    media_CVinter_array(1,s) = measure_1200(i,k);
                    % Calcolo per varianza inter-soggetto (sigma_ws)
                    sig_array(1,s) = measure_1200(i,k);
                end
                CV_inter_1200_matrix(i,k) = (std(sig_array) / mean(media_CVinter_array))*100;
            end
        end

        % Facciamo sul Retest
        CV_inter_retest_matrix = zeros(nRows);
        media_CVinter_array = zeros(1,nSubjects);
        sig_array = zeros(1,nSubjects);
        for i = 1:nRows
            for k = 1:nCols
                for s = 1:nSubjects
                    measure_retest = net_measures.(short_m_names{m}).(folder_names{2}){s}.(net_measure_names{n});
                    % Vettore che serve per l'overall mean
                    media_CVinter_array(1,s) = measure_retest(i,k);
                    % Calcolo per varianza inter-soggetto (sigma_ws)
                    sig_array(1,s) = measure_retest(i,k);
                end
                CV_inter_retest_matrix(i,k) = (std(sig_array) / mean(media_CVinter_array))*100;
                
                % per i vettori
            end 
        end

        % Facciamo la media delle due 
        CV_inter_matrix = (CV_inter_1200_matrix + CV_inter_retest_matrix)/2;
        
        group_measures.(short_m_names{m}).stats.(net_measure_names{n}).cv_inter = CV_inter_matrix;
        
        %% Wilcoxon
        
        % returns the p-value of a paired, two-sided test for the null hypothesis that 
        % x  y comes from a distribution with zero median.

        % Matrice dei valori Wilcoxon
        p_matrix = zeros(nRows);
        h_matrix = zeros(nRows);
        % Matrice 45x2 che raccoglie i valori
        w_aux = zeros(nSubjects,2);
        for i = 1:nRows
            for k = 1:nCols
                for s = 1:nSubjects
                    % Carico soggetto s1200
                    measure_1200 = net_measures.(short_m_names{m}).s_1200{s}.(net_measure_names{n});
                    % Carico soggetto sretest che uso per overall mean
                    measure_retest = net_measures.(short_m_names{m}).(folder_names{2}){s}.(net_measure_names{n});
                    w_aux(s,1) = measure_1200(i,k);
                    w_aux(s,2) = measure_retest(i,k);
                    
                end
                
                % per SWP, nel caso di Pearson si otterrebbero tutti NaN,
                % facendo fallire sigrank. pongo un valore a 0 per non far
                % bloccare lo script. da verificare!
                if isnan(w_aux(:, 1))
                    w_aux(1,1)= 0;
                end
                if isnan(w_aux(:, 2))
                    w_aux(1,2)= 0;
                end
                
                [p_matrix(i,k), h_matrix(i,k)] = signrank(w_aux(:,1)', w_aux(:,2)');
            end
        end
        
        % Test Bonferroni
        % Numero dei tets. Consideriamo solo la matrice triangolare inferiore e non
        % dobbiamo fare cose strane per il calcolo delle nuove, perchè tanto i
        % valori superiori sono già a zero quindi x*n_test = 0
        switch dim
            case 1
                n_test = 1;
            case 2
                n_test = 84;
            otherwise
                n_test = (84*83)/2;
        end

        % Generiamo le nuove matrici P-Value con la Correzione di Bonferroni
        bonf_p_wilcoxon_matrix = p_matrix .* n_test;

        % Generiamo le nuove matrici H-Value con la Correzione di Bonferroni
        bonf_h_wilcoxon_matrix = bonf_p_wilcoxon_matrix < 0.05;
        
        
        % c = cell(4, 1);
        % group_measures.(short_m_names{m}).stats.(net_measure_names{n}).Wilcoxon = cell2struct(c, {'p_matrix', 'h_matrix', 'bonferroni_p_matrix', 'bonferroni_h_matrix'});
        group_measures.(short_m_names{m}).stats.(net_measure_names{n}).Wilcoxon_p_matrix = p_matrix;
        group_measures.(short_m_names{m}).stats.(net_measure_names{n}).Wilcoxon_h_matrix = h_matrix;
        group_measures.(short_m_names{m}).stats.(net_measure_names{n}).Wilcoxon_bonferroni_p_matrix = bonf_p_wilcoxon_matrix;
        group_measures.(short_m_names{m}).stats.(net_measure_names{n}).Wilcoxon_bonferroni_h_matrix = bonf_h_wilcoxon_matrix;

    end
end


save('results/full_workspace');
save('results/network_analysis', 'net_measures', 'group_measures');






