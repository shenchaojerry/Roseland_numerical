function [U, S, time] = Roseland_image(data, patch_size, Dim, ref_ind, denoise)
% data is an image

[n, m] = size(data);
data = Patch_image(data, patch_size);

tic;
%get pixal distance
pix_dist = pdist2(data,data(ref_ind,:),'squaredeuclidean');

%get spatial distance
coord1 = repmat(1:n,1,m)';
coord2 = ones(n,m) * diag(1:m);
coord2 = coord2(:);
concat = [coord1 coord2];
%spa_dist = pdist2(concat, concat, 'squaredeuclidean');
%spa_dist = spa_dist(:,ref_ind);
spa_dist = pdist2(concat, concat(ref_ind,:), 'squaredeuclidean');


% bandwidth
sig_pix = median(median(pix_dist, 2));
sig_spa = median(median(spa_dist, 2));

% affinity matrix W
if denoise
    W_ref = exp(- 2*pix_dist/sig_pix) .* exp(- spa_dist/sig_spa); 
else
    W_ref = exp(- pix_dist/sig_pix) .* exp(- spa_dist/sig_spa);
end


W_ref = sparse(W_ref);

% make W row stochastic
% form sparse D = D^{-.5}
D = W_ref * sum(W_ref, 1)';

D = D.^(-.5);
N = n*m;
D = sparse(1:N, 1:N, D, N, N);
W_ref = D * W_ref;


% SVD on D * W_ref
[U, S, ~] = svds(W_ref, Dim+1);
U = D * U(:, 2:end);
S = diag(S);
S = S(2:end) .^ 2;

time = toc;
end