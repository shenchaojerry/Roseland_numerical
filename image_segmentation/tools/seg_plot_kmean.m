function seg_plot_kmean(embedding,k,num,n,m)

% weird outputs of kmeans swaping indices and kmeans..
rng(32);
[a, b] = kmeans(embedding(:,1:num),k);
if size(a,1) == size(embedding,1)
    clusters = a;
elseif size(b,1) == size(embedding,1)
    clusters = b;
end
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(clusters, n,m));
axis off
end