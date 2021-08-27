% This script performs spectral clustering using Diffusion Map
%% constants
add_noise = 1;
N = 70000;
embed_dim = 50;
kmean_iter = 12;
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
%% DM & accuracy
tic;
[dm_embed, ~] = DiffusionMap(data, embed_dim, 200, 0);
time_dm = toc;
% acc
acc_dm = get_acc(dm_embed,label,kmean_iter);
%% save
cd('/home/grad/chaos/Desktop')
dm_embed = dm_embed(:,1:3);
save('label.mat', 'label');
save('dm_embed.mat', 'dm_embed');
save('acc_dm.mat', 'acc_dm');
save('time_dm.mat', 'time_dm');
