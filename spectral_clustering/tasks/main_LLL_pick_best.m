% this script selects LLL parameters from grid search results
% based on the highest median accuracy
%%
Beta = [0.3 0.4 0.5];
knn = [100 200];
bandwidth = [200 250];
normalization = [0 1];
KZ = [3 10 20]; 
%% plot all grid search results
clean = 0;
figure('Renderer', 'painters', 'Position', [10 10 1800 800]);
for i = 1:3
    beta = Beta(i);
    subplot(1,3,i); hold on
    for s = bandwidth
        for kW = knn
            for kZ = KZ
                for nl = normalization
                    if clean == 1
                        path = sprintf('/home/grad/chaos/Desktop/clean/s%d/kW%d/kZ%d/nl%d/beta%.1f', s, kW,kZ,nl,beta);
                    else
                        path = sprintf('/home/grad/chaos/Desktop/noisy/s%d/kW%d/kZ%d/nl%d/beta%.1f', s, kW,kZ,nl,beta);
                    end
                    cd(path)
                    load('acc_LLL.mat')
                    plot(acc_LLL)
                    xlabel(sprintf('beta = %.1f', beta), 'fontsize', 25)
                end
            end
        end
    end
end

%% pick the curve with highest median acc
curr_best = [0 0 0];
curr_best_s = [0 0 0];
curr_best_kW = [0 0 0];
curr_best_kZ = [0 0 0];
curr_best_nl = [0 0 0];

clean = 0;
for i = 1:3
    beta = Beta(i);
    for s = bandwidth
        for kW = knn
            for kZ = KZ
                for nl = normalization
                    if clean == 1
                        path = sprintf('/home/grad/chaos/Desktop/clean/s%d/kW%d/kZ%d/nl%d/beta%.1f', s, kW,kZ,nl,beta);
                    else
                        path = sprintf('/home/grad/chaos/Desktop/noisy/s%d/kW%d/kZ%d/nl%d/beta%.1f', s, kW,kZ,nl,beta);
                    end
                    cd(path)
                    load('acc_LLL.mat')
                    if median(acc_LLL) > curr_best(i)
                    %if acc_LLL(10) > curr_best(i)
                        curr_best(i) = median(acc_LLL);
                        %curr_best(i) = acc_LLL(10);
                        curr_best_s(i)  = s;
                        curr_best_kW(i)  = kW;
                        curr_best_kZ(i) = kZ;
                        curr_best_nl(i)  = nl;
                    end  
                end
            end
        end
    end
end

figure('Renderer', 'painters', 'Position', [10 10 1800 800]);
for i = 1:3
    beta = Beta(i);
    s = curr_best_s(i);
    kW = curr_best_kW(i);
    kZ = curr_best_kZ(i);
    nl = curr_best_nl(i);
    
    subplot(1,3,i); hold on
    if clean == 1
        path = sprintf('/home/grad/chaos/Desktop/clean/s%d/kW%d/kZ%d/nl%d/beta%.1f', s, kW,kZ,nl,beta);
    else
        path = sprintf('/home/grad/chaos/Desktop/noisy/s%d/kW%d/kZ%d/nl%d/beta%.1f', s, kW,kZ,nl,beta);
    end
    cd(path)
    load('acc_LLL.mat')
    plot(acc_LLL)
    xlabel(sprintf('beta = %.1f', beta), 'fontsize', 25)
    title(sprintf('s=%d,kw=%d,kz=%d,nl=%d',s,kW,kZ,nl))
end
