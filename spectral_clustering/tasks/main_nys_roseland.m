% This script performs spectral clustering using Roseland and Nystrom
%% constants
add_noise = 0;
clean_subset = 0;
N = 70000;
iter = 15;
kmean_iter = 5;
Beta = [0.3 0.4 0.5];
%% get data
load('mnist.mat')
data = [trainX;  testX]./ 255;
label = [trainY testY]';
data = data(1:N,:);
label = label(1:N);
[~, ind] = sort(label);
data = double(data(ind, :));
label = double(label(ind));
%% add noise
if add_noise == 1
    clean_data = data;
    noise = 0.2*randn(size(data));  %gaussian
    %noise = trnd(4, size(data)) / sqrt(2) * .2; % student t
    data = data+noise;
end
%% Roseland & Nystrom & accuracy
for beta = Beta
    subset_size = round(N^beta);
    embed_dim = min(50, subset_size-1);
    
    acc_roseland = zeros(iter, embed_dim);
    acc_nys = zeros(iter, embed_dim);
    Time_nys = zeros(iter,1);
    Time_roseland = zeros(iter,1);

    for ii = 1:iter
        % landmarks
        subind = randperm(N);
        if clean_subset == 1 && add_noise == 1
            subset = clean_data(subind(1:subset_size), :);
        else
            subset = data(subind(1:subset_size), :);
        end
        % roseland
        tic;
        [roseland_embed, ~] = Roseland(data, embed_dim, subset, 1);
        time_roseland = toc;
        Time_roseland(ii) = time_roseland;

        % Nystrom
        tic;
        [nystrom_embed, ~] = Nystrom(data, subset, embed_dim, 0);
        time_nys = toc;
        Time_nys(ii) = time_nys;
        nystrom_embed = nystrom_embed(subset_size+1:end, 2:end);

        % accuracy
        acc_roseland(ii,:) = get_acc(roseland_embed,label,kmean_iter);
        acc_nys(ii,:) = get_acc(nystrom_embed,label,kmean_iter);
    end
    
    % save
    path = sprintf('/home/grad/chaos/Desktop/beta%.1f', beta);
    mkdir(path)
    cd(path)

    roseland_embed = roseland_embed(:,1:3);
    nystrom_embed = nystrom_embed(:,1:3);
    save('label.mat', 'label');

    save('roseland_embed.mat', 'roseland_embed');
    save('nystrom_embed.mat', 'nystrom_embed');

    save('acc_roseland.mat', 'acc_roseland');
    save('acc_nys.mat', 'acc_nys');

    save('time_nys.mat', 'Time_nys');
    save('time_roseland.mat', 'Time_roseland');
end
