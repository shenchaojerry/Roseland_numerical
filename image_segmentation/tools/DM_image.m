function [U, S] = DM_image(data, denoise, Dim)

% data is an image

[n, m] = size(data);
data = data(:);
%get pixal distance
pix_dist = pdist2(data,data,'squaredeuclidean');
pix_dist(pix_dist>50)=0;
pix_dist = sparse(pix_dist);

%get spatial distance
coord1 = repmat(1:n,1,m)';
coord2 = ones(n,m) * diag(1:m);
coord2 = coord2(:);
spa_dist = pdist2([coord1 coord2], [coord1 coord2], 'squaredeuclidean');
spa_dist(spa_dist>100)=0;
spa_dist = sparse(spa_dist);  
  
% bandwidth
sig_pix = 0.1;
sig_spa = 10;


% affinity matrix
W = exp(- pix_dist/sig_pix) .* exp(- spa_dist/sig_spa); 
W = sparse(W);
W = max(W, W');
if denoise
    W(logical(eye(size(W)))) = 0;
end   
   
% graph laplacian
D = sqrt(sum(W, 2)); 
W = bsxfun(@rdivide, bsxfun(@rdivide, W, D), transpose(D));
W = (W + W')./2;

% EVD
[U,S] = eigs(W, Dim + 1);
U = bsxfun(@rdivide, U(:, 2:end), D);
S = S(2:end, 2:end);

end