% Author: Francesco Zumerle, Universty of Verona

%% SCHAEFER_REORGANIZATION
% This script generates a functional reorganization of the signal matrix
% obtained from HCP subjects in resting_state

%% INPUT FILES
Schaefer_input = 'Schaefer2018_100Parcels_7Networks_order_FSLMNI152_2mm.nii.gz';
conversion_table = 'Schaefer100Parcels_conversion.csv';
Schaefer_converted = 'Schaefer2018_7Networks.nii.gz';
hcp_84regions = 'atlas_84regions.nii.gz';

%% Section 1: label conversion
% running label_converter in order to regroup all 100 parcels in 7
% functional Networks
label_converter(Schaefer_input, conversion_table, Schaefer_converted);

%% Section 2: Network assignment
% load Schaefer image
Schaefer_nii = load_untouch_nii(Schaefer_converted);
% extract atlas from file imported
Schaefer_atlas = double(Schaefer_nii.img);

% same for 84regions image
hcp_nii = load_untouch_nii(hcp_84regions);
hcp_atlas = double(hcp_nii.img);

% Now, each region from hcp_atlas will be analyzed, in order to determine
% which Network it belongs to.

results = zeros(84, 8); % last column contains the sum of non-zero voxels

for roi = 1:84
    
    % single_roi is created as a copy of Schaefer_atlas
    roi_atlas = hcp_atlas;
    
    % in this for cycle every voxel not belonging to roi is removed
    for voxel = 1:numel(roi_atlas)
        if roi_atlas(voxel) ~= roi
           % if voxel is not inside roi, remove it (set to 0 its value)
           roi_atlas(voxel) = 0;
        end
    end
    % now single_roi only contains voxels belonging to current roi
    
    % debugging 
%    if roi == 35
%        hcp_nii.img = roi_atlas;
%        save_untouch_nii(hcp_nii, 'test.nii.gz');
%    end
    
    % Networks will keep track of how many voxels belong to each network
    networks = zeros(1, 8);
    for voxel = 1:numel(roi_atlas)
        
        % check each region
        if roi_atlas(voxel) == roi
            networks(8) = networks(8) + 1;
            if Schaefer_atlas(voxel) ~= 0
                networks(Schaefer_atlas(voxel)) = networks(Schaefer_atlas(voxel)) + 1;
            end
        end

    end
    
    % Networks is copyed in results
    results(roi, :) = networks;
end


%% Section 3: results

% results is complete and can be used to choose, for each region, the
% network with highest number of voxels

Schaefer_full_results = zeros(84, 17);
Schaefer_full_results(:, 1:8) = results;

for i = 1:84
    for net = 1:7
        Schaefer_full_results(i, net + 8) = results(i, net)/results(i,8);
    end
    
    [x, y] = max(Schaefer_full_results(i, 9:15));
    
    % here cutoff is 0.40
    if x > 0.4
        Schaefer_full_results(i, 16) = y;
    else
        Schaefer_full_results(i, 16) = 0;
    end
    
    % here cutoff is 0.10
    if x > 0.1
        Schaefer_full_results(i, 17) = y;
    else
        Schaefer_full_results(i, 17) = 0;
    end
    
    % subcortical regions are automatically removed from networks
    if i >= 35 && i <= 49
        Schaefer_full_results(i, 16:17) = 0;
    end
end



% saving results 
dlmwrite('Schaefer_full_results.txt', Schaefer_full_results, 'delimiter', '\t');

%% Section 4: generating conversion table

% column chosen
c = 17; % 0.10 cutoff

left = 1;
right = 43;

% regions are reoragnized in networks, keeping left & right divided
T = zeros(84, 1);
for net = 1:7
    for i = 1:84
        if Schaefer_full_results(i, c) == net
            if i <= 42
                T(left) = i;
                left = left + 1;
            else
                T(right) = i;
                right = right + 1;
            end
        end
    end
end

% Finally, adding ignored regions (value == 0)
for i = 1:84
    if Schaefer_full_results(i, c) == 0 && i <= 42
        T(left) = i;
        left = left + 1;
    elseif Schaefer_full_results(i, c) == 0 && i > 42
        T(right) = i;
        right = right + 1;
    end
end

dlmwrite('Schaefer_reorganization.txt', T, 'delimiter', '\t');