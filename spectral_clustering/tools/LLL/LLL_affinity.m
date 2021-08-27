function W = LLL_affinity(data, kW, sig)


[n, ~] = size(data) ;


% search for K nearnest neighbors
[index,distance]= knnsearch(data, data, 'k', kW);

% make sure d(x,x)=0
distance(:,1)=0;     

% affinities
ker = exp(- distance.^2/ sig.^2 / 2); 

ii = (1:n)'*ones(1,KNN);
W = sparse(ii, index, ker, n, n);
W = (W+W')/2;

end