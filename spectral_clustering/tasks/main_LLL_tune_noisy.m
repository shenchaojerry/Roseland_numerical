% this script tunes LLL parameters on noisy MNIST data
rng(32);
warning('off')
%% LLL
N = 70000;
iter = 5;
kmean_iter = 5;
Beta = [0.3 0.4 0.5];
knn = [100 200];
bandwidth = [200 250];
normalization = [0 1];
KZ = [3 10 20]; 
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
noise = 0.2*255*randn(size(data));  %gaussian
data = data+noise;

%% LLL & accuracy
curr_best_acc = [0 0 0];
curr_best_s = [0 0 0];
curr_best_kW = [0 0 0];
curr_best_kZ = [0 0 0];
curr_best_nl = [0 0 0];

sprintf('Setup: noisy MNIST dataset size=%d', N)
fprintf('Start LLL grid search on bandwidth(s), number of knn in affinity matrix(kW), number of landmarks each data point use(kZ), apply normalization or not(nl) \n')
for s = bandwidth
    for kW = knn 
        % Compute Gaussian affinities with bandwidth s and kW neighbours
        W = gaussaff(data,{'k',kW},s);
        path = sprintf('/home/grad/chaos/Desktop/noisy/s%d/kW%d', s, kW);
        mkdir(path)
        cd(path)
        save('LLL_affinity.mat', 'W');
        for kZ = KZ
            % number of landmarks each data point uses
            for nl = normalization 
                % Type of Laplacian. nl: normalised (1) or unnormalised (0) Laplacian.
                for index = 1:3 
                    beta = Beta(index);
                    landmark_size = round(N^beta);
                    d = min(50, landmark_size-1);
                    acc_LLL = zeros(iter, d);
                    for ii = 1:iter
                        [LLL_embed,~,~] = lll(data,W,d,landmark_size,kZ,nl);
                        % accuracy
                        acc_LLL(ii,:) = get_acc(LLL_embed,label,kmean_iter);
                    end
                    acc_LLL = mean(acc_LLL);
                    LLL_embed = LLL_embed(:,1:3);
    
                    path = sprintf('/home/grad/chaos/Desktop/noisy/s%d/kW%d/kZ%d/nl%d/beta%.1f', s, kW,kZ,nl,beta);
                    mkdir(path)
                    cd(path)
                    save('LLL_embed.mat', 'LLL_embed');
                    save('acc_LLL.mat', 'acc_LLL');
                    sprintf('When s=%d, kW=%d, kZ=%d, nl=%d, beta=%.1f, landmark size=%d, LLL acc dim1-5=%.2f, dim6-10=%.2f, dim11-20=%.2f, dim21-%d=%.2f',s,kW,kZ,nl,beta,landmark_size,max(acc_LLL(1:5)),max(acc_LLL(6:10)),max(acc_LLL(11:20)),d,max(acc_LLL(21:d)))

                    if max(acc_LLL) > curr_best_acc(index)
                        curr_best_acc(index) = max(acc_LLL);
                        curr_best_s(index)  = s;
                        curr_best_kW(index)  = kW;
                        curr_best_kZ(index) = kZ;
                        curr_best_nl(index)  = nl;
                    end
                end
            end
        end
    end
end

fprintf('Finished grid search on noisy data.')
for i = 1:3
    sprintf('Beta=%.1f, best LLL accuracy=%.2f, at s=%d, kW=%d, kZ=%d, nl=%d',Beta(i),curr_best_acc(i),curr_best_s(i),curr_best_kW(i),curr_best_kZ(i),curr_best_nl(i))
end