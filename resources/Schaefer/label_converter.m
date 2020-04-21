function label_converter(input_name, conversion_table, output_name)
    % import atlas in matlab
    % load atlas
    nii = load_untouch_nii(input_name);
    % extract atlas from file imported
    atlas = double(nii.img);
    % load conversion matrix, so every region can be converted
    table = load(conversion_table);

    %cycle through each voxel of atlas 
    for voxel = 1:numel(atlas)
        % becomes true if this voxel is inside one of the 84 regions
        flag = false;
        % cycle through each region
        for idx = 1:(numel(table)/2) %i just want the length of a single column
            % if this voxel is inside a region included in conversion_table, its
            % value is converted
            if atlas(voxel) == table(idx, 1)
               atlas(voxel) = table(idx, 2);
               % flag becomes true when label is found and converted
               flag = true;
               % break cycle, so I don't convert more times the same voxel
               break
            end
        end
        % if this voxel was not found in conversion_table, its new value will be -1
        if flag == false && atlas(voxel) ~= 0
            atlas(voxel) = -1;
        end
    end

    nii.img = atlas;

    save_untouch_nii(nii, output_name);
end