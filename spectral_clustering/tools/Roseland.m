function [U, S] = Roseland(data, Dim, ref, denoise)

[n, ~] = size(data) ;
% form affinity matrix wrt the ref set
affinity_ext = pdist2(data, ref).^2;
% affinity matrix W
sig = median(median(affinity_ext, 2));

if denoise
    W_ref = exp( - 6 * affinity_ext / sig );
else
    W_ref = exp( - 5 * affinity_ext / sig );
end

W_ref = sparse(W_ref);

% make W row stochastic
% form sparse D = D^{-.5}
D = W_ref * sum(W_ref, 1)';
D = D.^(-.5);
D = sparse(1:n, 1:n, D, n, n);
W_ref = D * W_ref;

% SVD on D * W_ref
[U, S, ~] = svds(W_ref, Dim+1);
U = D * U(:, 2:end);
S = diag(S);
S = S(2:end) .^ 2;
end
