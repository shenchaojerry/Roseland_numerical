% This script performs spectral clustering using Roseland with different
% landmark sizes and different embedding dimensions
%% constants
add_noise = 1;
clean_subset = 1;
N = 70000;
iter = 30;
kmean_iter = 5;
Subset_size = 25:15:250;
Embed_dim = [20 30 50];
% rows are embed_dim, columns beta or number of landmarks used
acc_roseland = zeros(length(Embed_dim), length(Subset_size));
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
%% Roseland & accuracy

for j = 1:length(Subset_size)

    subset_size = Subset_size(j);

    acc_roseland_temp = zeros(length(Embed_dim), iter);

    for ii = 1:iter
        % landmarks
        subind = randperm(N);
        if clean_subset == 1 && add_noise == 1
            subset = clean_data(subind(1:subset_size), :);
        else
            subset = data(subind(1:subset_size), :);
        end
        % roseland
        [roseland_embed, ~] = Roseland(data, min(subset_size,50), subset, 1);

        % accuracy
        acc_roseland_temp(:,ii) = get_acc2(roseland_embed,Embed_dim,label,kmean_iter);
    end

    acc_roseland(:,j) = mean(acc_roseland_temp, 2);
end

% save
if add_noise == 0
    path = '/home/grad/chaos/Desktop/acc_landmarks/clean_data_clean_landmark';
    mkdir(path)
    cd(path)
elseif add_noise == 1 && clean_subset == 0
    path = '/home/grad/chaos/Desktop/acc_landmarks/noisy_data_noisy_landmark';
    mkdir(path)
    cd(path)
elseif add_noise == 1 && clean_subset == 1
    path = '/home/grad/chaos/Desktop/acc_landmarks/noisy_data_clean_landmark';
    mkdir(path)
    cd(path) 
end
save('acc_roseland.mat', 'acc_roseland');
