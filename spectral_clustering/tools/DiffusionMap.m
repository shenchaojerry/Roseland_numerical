function [U, S] = DiffusionMap(data, Dim, KNN, denoise)

[n, ~] = size(data) ;

% search for K nearnest neighbors
[index,distance]= knnsearch(data, data, 'k', KNN);

% make sure d(x,x)=0
distance(:,1)=0;     
  
% find sigma
sig = quantile(distance(:,end).^2, .5) ;
% affinity matrix
%ker = exp(- 4 * distance.^2/sig); 
ker = exp(- 3.5 * distance.^2/sig); 

ii = (1:n)'*ones(1,KNN);
W = sparse(ii, index, ker, n, n);
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
