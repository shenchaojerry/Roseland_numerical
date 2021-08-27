% This script performs spectral clustering using LLL
%% constants
add_noise = 1;
N = 70000;
iter = 5;
kmean_iter = 6;
Beta = [0.3 0.4 0.5];
S = [250 200 250];
KW = [200 100 100];
KZ = [3 3 10];
NL = [0 1 1];
%% get data
load('mnist.mat')
data = [trainX;  testX];
label = [trainY testY]';
data = data(1:N,:);
label = label(1:N);
[~, ind] = sort(label);
data = double(data(ind, :));
label = double(label(ind));
%% add noise
if add_noise == 1
    noise = 0.2*255*randn(size(data));  %gaussian
    data = data+noise;
end
%% LLL & accuracy
for i = 1:3
    beta = Beta(i);
    s = S(i);
    kW = KW(i);
    tic;
    % Compute Gaussian affinities with bandwidth s and kW neighbours 
    W = gaussaff(data,{'k',kW},s);
    build_affinity_time = toc;
    
    kZ = KZ(i); % number of landmarks for each point, for LLL
    nl = NL(i); % Type of Laplacian
    
    subset_size = round(N^beta);
    embed_dim = min(50, subset_size-1);
    acc_LLL = zeros(iter, embed_dim);
    Time_LLL = zeros(iter,1);
    
    for ii = 1:iter    
        tic;
        [LLL_embed,~,~] = lll(data,W,embed_dim,subset_size,kZ,nl);
        time_LLL = toc;
        Time_LLL(ii) = time_LLL + build_affinity_time;
        
        % accuracy
        acc_LLL(ii,:) = get_acc(LLL_embed,label,kmean_iter);
    end
    
    % save
    path = sprintf('/home/grad/chaos/Desktop/beta%.1f', beta);
    mkdir(path)
    cd(path)

    LLL_embed = LLL_embed(:,1:3);
    
    save('LLL_label.mat', 'label');
    save('LLL_embed.mat', 'LLL_embed');
    save('acc_LLL.mat', 'acc_LLL');
    save('time_LLL.mat', 'Time_LLL');
end
