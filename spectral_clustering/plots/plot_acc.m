% this script plots spectral clustering accuracies
%%
noisy_data = 1;
clean_landmark = 0;
%% load results
if noisy_data == 0
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/dm')
    load('acc_dm.mat')
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/pca')
    load('acc_pca.mat')
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/beta0.3')
    load('acc_nys.mat')
    load('acc_roseland.mat')
    load('acc_LLL.mat')
    acc_nys_03 = mean(acc_nys);
    acc_roseland_03 = mean(acc_roseland);
    acc_LLL_03 = acc_LLL;
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/beta0.4')
    load('acc_nys.mat')
    load('acc_roseland.mat')
    load('acc_LLL.mat')
    acc_nys_04 = mean(acc_nys);
    acc_roseland_04 = mean(acc_roseland);
    acc_LLL_04 = acc_LLL;
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/beta0.5')
    load('acc_nys.mat')
    load('acc_roseland.mat')
    load('acc_LLL.mat')
    acc_nys_05 = mean(acc_nys);
    acc_roseland_05 = mean(acc_roseland);
    acc_LLL_05 = acc_LLL;
elseif noisy_data == 1
    cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/dm')
    load('acc_dm.mat')
    cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/pca')
    load('acc_pca.mat')
    if clean_landmark == 0
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/noisy subset/beta0.3')
        load('acc_nys.mat')
        load('acc_roseland.mat')
        load('acc_LLL.mat')
        acc_nys_03 = mean(acc_nys);
        acc_roseland_03 = mean(acc_roseland);
        acc_LLL_03 = acc_LLL;
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/noisy subset/beta0.4')
        load('acc_nys.mat')
        load('acc_roseland.mat')
        load('acc_LLL.mat')
        acc_nys_04 = mean(acc_nys);
        acc_roseland_04 = mean(acc_roseland);
        acc_LLL_04 = acc_LLL;
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/noisy subset/beta0.5')
        load('acc_nys.mat')
        load('acc_roseland.mat')
        load('acc_LLL.mat')
        acc_nys_05 = mean(acc_nys);
        acc_roseland_05 = mean(acc_roseland);
        acc_LLL_05 = acc_LLL;
    elseif clean_landmark == 1
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/clean subset/beta0.3')
        load('acc_nys.mat')
        load('acc_roseland.mat')
        acc_nys_03 = mean(acc_nys);
        acc_roseland_03 = mean(acc_roseland);
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/clean subset/beta0.4')
        load('acc_nys.mat')
        load('acc_roseland.mat')
        acc_nys_04 = mean(acc_nys);
        acc_roseland_04 = mean(acc_roseland);
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/clean subset/beta0.5')
        load('acc_nys.mat')
        load('acc_roseland.mat')
        acc_nys_05 = mean(acc_nys);
        acc_roseland_05 = mean(acc_roseland);
    end
end

%% accuracy version: fix beta = 0.3
embed_dim = 27;
dim = 2:3:embed_dim;
figure('Renderer', 'painters', 'Position', [10 10 900 700]); hold on;
plot(dim, acc_pca(dim), '--*', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_dm(dim), '--o', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_roseland_03(dim), '--s', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_nys_03(dim), '--^', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_LLL_03(dim), '--+', 'MarkerSize', 20, 'linewidth', 3)
grid on; grid minor
%yticks(0.35:.1:0.85) % for clean data
yticks(0.3:.1:0.8) % for noisy data
xticks([2:3:embed_dim])
xt = get(gca, 'XTick');
set(gca, 'FontSize', 25)
axis tight
xlabel('Embedding dimension', 'fontsize', 25)
ylabel('Accuracy', 'fontsize', 25)
legend({'PCA','DM','Roseland','Nystrom','LLL'}, 'fontsize', 18)

cd('/home/grad/chaos/Desktop')
%export_fig('clean_mnist_err_beta03','-transparent','-eps')
%export_fig('noisy_mnist_err_beta03','-transparent','-eps')


%% accuracy version: fix beta = 0.4
embed_dim = 50;
dim = 2:3:embed_dim;
figure('Renderer', 'painters', 'Position', [10 10 900 700]); hold on;
plot(dim, acc_pca(dim), '--*', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_dm(dim), '--o', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_roseland_04(dim), '--s', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_nys_04(dim), '--^', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_LLL_04(dim), '--+', 'MarkerSize', 20, 'linewidth', 3)
grid on; grid minor
%yticks(0.35:.1:0.85) % for clean data
yticks(0.3:.1:0.8) % for noisy data
xticks([2:6:embed_dim])
xt = get(gca, 'XTick');
set(gca, 'FontSize', 25)
axis tight
xlabel('Embedding dimension', 'fontsize', 25)
ylabel('Accuracy', 'fontsize', 25)
legend({'PCA','DM','Roseland','Nystrom','LLL'}, 'fontsize', 18)

cd('/home/grad/chaos/Desktop')
%export_fig('clean_mnist_err_beta04','-transparent','-eps')
%export_fig('noisy_mnist_err_beta04','-transparent','-eps')

%% accuracy version: fix beta = 0.5
embed_dim = 50;
dim = 2:3:embed_dim;
figure('Renderer', 'painters', 'Position', [10 10 900 700]); hold on;
plot(dim, acc_pca(dim), '--*', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_dm(dim), '--o', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_roseland_05(dim), '--s', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_nys_05(dim), '--^', 'MarkerSize', 20, 'linewidth', 3)
plot(dim, acc_LLL_05(dim), '--+', 'MarkerSize', 20, 'linewidth', 3)
grid on; grid minor
%yticks(0.35:.1:0.85) % for clean data
yticks(0.3:.1:0.8) % for noisy data
xticks([2:6:embed_dim])
xt = get(gca, 'XTick');
set(gca, 'FontSize', 25)
axis tight
xlabel('Embedding dimension', 'fontsize', 25)
ylabel('Accuracy', 'fontsize', 25)
legend({'PCA','DM','Roseland','Nystrom','LLL'}, 'fontsize', 18)

cd('/home/grad/chaos/Desktop')
%export_fig('clean_mnist_err_beta05','-transparent','-eps')
%export_fig('noisy_mnist_err_beta05','-transparent','-eps')