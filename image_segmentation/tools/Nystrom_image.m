function [u_ext, s] = Nystrom_image(data, patch_size, dim, subset_ind, denoise)
[n, m] = size(data);
data = Patch_image(data, patch_size);
sample = data(subset_ind,:);

% DM within samples
%get pixal distance
pix_dist = pdist2(data,sample,'squaredeuclidean');
%get spatial distance
coord1 = repmat(1:n,1,m)';
coord2 = ones(n,m) * diag(1:m);
coord2 = coord2(:);
concat = [coord1 coord2];
spa_dist = pdist2(concat, concat(subset_ind,:), 'squaredeuclidean');

% bandwidth
sig_pix = median(median(pix_dist, 2));
sig_spa = median(median(spa_dist, 2));


% affinity matrix
A = exp(- pix_dist(subset_ind,:)/sig_pix) .* exp(- spa_dist(subset_ind,:)/sig_spa); 
A = max(A, A');

if denoise
    A(logical(eye(size(A)))) = 0;
end

D = sum(A, 2);
D = D.^(-0.5);
D = diag(D);
A = D * A * D;
A = (A + A') / 2;
[u, s] = eigs(A, dim + 1);
u = u(:, 2:end);
u = D * u;
s = s(2:end, 2:end);
%u = u * s;

%affinity B between sample and data
B = exp(- pix_dist/sig_pix) .* exp(- spa_dist/sig_spa); 
D_ext = sum(B, 2);
u_ext = B * (u *  inv(s)) ./ D_ext;
s = diag(s);
end
