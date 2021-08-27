function Acc = get_acc(embedding, label, K)
% embedding: data embeddings
% label: true labels
% K = number of k-means to average
    dim = size(embedding, 2);
    Acc = zeros(K,dim,10);
    for k = 1:K
        for d = 1:dim
            % weird outputs of kmeans swaping indices and kmeans..
            [a, b] = kmeans(embedding(:,1:d),10);
            if size(a,1) == size(embedding,1)
                clusters = a;
            elseif size(b,1) == size(embedding,1)
                clusters = b;
            end
            for i = 1:10
                get_cluster_labels = label(clusters==i);
                pred_cluster_label = mode(get_cluster_labels);
                acc = sum(get_cluster_labels==pred_cluster_label) / length(get_cluster_labels);
                Acc(k,d,i) = acc;
            end
        end
    end

    Acc = mean(Acc,3);
    Acc = mean(Acc,1);
end