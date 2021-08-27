function [u_ext, s] = Nystrom(data, sample, dim, denoise, sig, alpha)
% Nystrom adapts to DM

if nargin < 6
    alpha = 0;
end

if nargin < 4
    denoise = 0;
end

n = size(sample, 1);

KNN = n;

[index, distance]= knnsearch(sample, sample, 'k', KNN);
%distance(:,1)=0;

% DM within samples
% affinity matrix
if nargin < 5
    sig = quantile(distance(:,end).^2, .98);
end

ker = exp(- 3 * distance.^2 / sig);
ii = (1:n)'*ones(1,KNN);
A = sparse(ii, index, ker, n, n);
A = max(A, A');
A = full(A);

if denoise
    A(logical(eye(size(A)))) = 0;
end

if alpha
    % alpha-normalization
    D = sum(A, 2).^1;
    A = bsxfun(@rdivide, bsxfun(@rdivide, A, D), transpose(D));
end

D = sum(A, 2);
D = D.^(-0.5);
D = diag(D);
A = D * A * D;
A = (A + A') / 2;
[u, s] = eigs(A, dim + 1);
u = D * u;
%u = u * s;

%affinity B between sample and data
B = pdist2(data, sample);
B = exp(- B.^2 / sig);
D_ext = sum(B, 2);

u_ext = B * (u *  inv(s)) ./ D_ext;
u_ext = [u; u_ext];
s = diag(s);
end
