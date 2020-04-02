function clusters(filename)
    % import atlas in matlab
    %filename = 'aparc+aseg2fmri_mask.nii.gz';
    % load atlas
    nii = load_untouch_nii(filename);
    % extract atlas from file imported
    atlas = double(nii.img);
    % load conversion matrix, every region is converted to fs_default.txt
    load('label_conversion.csv');

    %cycle through each voxel of atlas 
    for idx = 1:numel(atlas)
        % becomes true if this voxel is inside one of the 84 regions
        flag = false;
        % cycle through each region
        for new_roi = 1:84
            old_roi = label_conversion(new_roi, 1);
            % if this voxel in inside a region included in fs_default, its
            % value is converted
            if atlas(idx) == old_roi
               atlas(idx) = new_roi;
               % flag becomes true when label is found and converted
               flag = true;
               % break cycle, so I don't convert more times the same voxel
               break
            end
        end
        % if this voxel was not found in label_conversion, its new value will be -1
        if flag == false
            atlas(idx) = -1;
        end
    end

    nii.img = atlas;

    save_untouch_nii(nii, 'atlas_84regions.nii.gz');
end