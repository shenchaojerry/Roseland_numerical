function res = Patch_image(image, patch_size)
    % image: n by m matrix
    % patch_size: the side length of a patch, make it odd, e.g. 3
    % res: (nxm) by (patch_sizexpatch_size) matrix

    [n,m]=size(image);
    pad = (patch_size-1)/2;
    patch_image = zeros(n + pad*2, m + pad*2);
    patch_image((pad+1):(n+pad), (pad+1):(m+pad)) = image;
    % extend the padding places
    % top
    patch_image(1:pad,(pad+1):(m+pad)) = repmat(image(1,:), pad, 1);
    % botton
    patch_image((n+pad+1):end,(pad+1):(m+pad)) = repmat(image(n,:), pad, 1);
    % left
    patch_image(:,1:pad) = repmat(patch_image(:,pad+1), 1, pad);
    % right
    patch_image(:,(m+pad+1):end) = repmat(patch_image(:,m+pad), 1, pad);
    
    res = zeros(n*m, patch_size*patch_size);
    coord1 = repmat(1:n,1,m)';
    coord2 = ones(n,m) * diag(1:m);
    coord2 = coord2(:);
    concat = [coord1 coord2];
    for ii = 1:(n*m)
        i = concat(ii,1);
        j = concat(ii,2);
        temp = patch_image(i:i+2*pad, j:j+2*pad);
        res(ii,:) = temp(:)';
    end
end