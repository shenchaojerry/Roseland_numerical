function W = LLL_affinity(data, patch_size, kW)

[n, m] = size(data);

% patch data to get pixel distance
data = Patch_image(data, patch_size);
% coordinates to get spatial distance
coord1 = repmat(1:n,1,m)';
coord2 = ones(n,m) * diag(1:m);
coord2 = coord2(:);
concat = [coord1 coord2];

% knn
[N, ~] = size(data) ;

[index,distance]= knnsearch(concat, concat, 'k', kW);
sig = median(median(distance, 2));
distance = exp(- distance.^2 / sig );

%{
index = zeros(N, kW);
distance = zeros(N, kW);

for i = 1:N
    %{
    pix_dist = pdist2(data(i,:),data,'squaredeuclidean');
    spa_dist = pdist2(concat(i,:), concat, 'squaredeuclidean');
    sig_pix = median(pix_dist);
    sig_spa = median(spa_dist);
    dist = exp(- pix_dist/sig_pix) .* exp(- spa_dist/sig_spa);
    [~, idx] = sort(dist);
    index(i,:) = idx(1:kW);
    distance(i,:) = dist(idx(1:kW));
    %}
    spa_dist = pdist2(concat(i,:), concat, 'squaredeuclidean');
    [~, idx] = sort(spa_dist);
    index(i,:) = idx(1:kW);
    spa_dist = spa_dist(1:kW);
    sig_spa = median(spa_dist);
    dist = exp(- spa_dist/sig_spa);
    distance(i,:) = dist;
end   
%}



% make sure d(x,x)=0
distance(:,1)=0;     

ii = (1:N)'*ones(1,kW);
W = sparse(ii, index, distance, N, N);
W = (W+W')/2;

end