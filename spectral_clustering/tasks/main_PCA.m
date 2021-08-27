% This script performs spectral clustering using PCA
%% constants
N = 70000;
embed_dim = 50;
kmean_iter = 12;
Add_noise = [0 1];
%%
for add_noise = Add_noise
    % get data
    load('mnist.mat')
    data = [trainX;  testX]./ 255;
    label = [trainY testY]';
    data = data(1:N,:);
    label = label(1:N);
    [~, ind] = sort(label);
    data = double(data(ind, :));
    label = double(label(ind));

    % add noise
    if add_noise == 1
        noise = 0.2*randn(size(data));  %gaussian
        %noise = trnd(4, size(data)) / sqrt(2) * .2; % student t
        data = data+noise;
    end

    % PCA & accuracy
    tic;
    coeff = pca(data);
    pca_embed = data * coeff(:,1:embed_dim);
    time_pca = toc;

    % acc
    acc_pca = get_acc(pca_embed,label,kmean_iter);

    % save
    path = sprintf('/home/grad/chaos/Desktop/add_noise%d', add_noise);
    mkdir(path)
    cd(path)
    
    pca_embed = pca_embed(:,1:3);
    save('label.mat', 'label');
    save('time_pca.mat', 'time_pca');
    save('pca_embed.mat', 'pca_embed');
    save('acc_pca.mat', 'acc_pca');
end
