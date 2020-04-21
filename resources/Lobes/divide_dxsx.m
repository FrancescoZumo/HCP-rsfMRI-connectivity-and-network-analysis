load('lobe_mapping.txt');
%%cycle through each voxel of atlas
M = zeros(84, 1);
l = 1;
r = 1;
for i = 1:84
    if lobe_mapping(i, 1) <= 42
        M(l, 1) = lobe_mapping(i, 1);
        l = l + 1;
    else
        M(r + 42, 1) = lobe_mapping(i, 1);
        r = r + 1;
    end
end

dlmwrite('lobe_reorganization.txt', M, 'delimiter', '\t');