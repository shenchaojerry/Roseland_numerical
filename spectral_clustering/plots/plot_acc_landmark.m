% this script plots Roseland accuracies aganist number of landmarks
%% load
cd '/home/grad/chaos/Desktop/mnist_result/result/acc_landmarks/clean_data_clean_landmark'
load('acc_roseland.mat')
acc_roseland_clean_clean = acc_roseland;
cd '/home/grad/chaos/Desktop/mnist_result/result/acc_landmarks/noisy_data_clean_landmark'
load('acc_roseland.mat')
acc_roseland_noisy_clean = acc_roseland;
cd '/home/grad/chaos/Desktop/mnist_result/result/acc_landmarks/noisy_data_noisy_landmark'
load('acc_roseland.mat')
acc_roseland_noisy_noisy = acc_roseland;
cd '/home/grad/chaos/Desktop'

Subset_size = 25:15:250;
Embed_dim = [20 30 50];

%% fix dim, accuracy vs number of landmark
pick = 3;
figure('Renderer', 'painters', 'Position', [10 10 1300 900]); hold on;
plot(Subset_size(pick:end), acc_roseland_clean_clean(pick,pick:end), '--o', 'MarkerSize', 25, 'linewidth', 3)
plot(Subset_size(pick:end), acc_roseland_noisy_noisy(pick,pick:end), '--s', 'MarkerSize', 25, 'linewidth', 3)
plot(Subset_size(pick:end), acc_roseland_noisy_clean(pick,pick:end), '--^', 'MarkerSize', 25, 'linewidth', 3)
grid on; grid minor

if pick == 3
    yticks(0.6:.03:0.85) % for clean landmark
end  
Xticks = 25:25:250;
xticks(Xticks(pick:end))
xt = get(gca, 'XTick');
set(gca, 'FontSize', 35)
axis tight
xlabel('Number of landmarks', 'fontsize', 35)
ylabel('Accuracy', 'fontsize', 35)
legend({'clean data','noisy data, noisy landmark','noisy data, clean landmark'}, 'fontsize', 35)

%export_fig('acc_landmark_dim20','-transparent','-eps')