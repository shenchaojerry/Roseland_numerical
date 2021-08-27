% this script plots MNIST embeddings
%%
noisy_data = 0;
clean_landmark = 0;
%% load results

if noisy_data == 0
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/dm')
    load('dm_embed.mat')
    load('label.mat')
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/pca')
    load('pca_embed.mat')
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/beta0.3')
    load('nystrom_embed.mat')
    load('roseland_embed.mat')
    load('LLL_embed.mat')
    nystrom_embed_03 = nystrom_embed;
    roseland_embed_03 = roseland_embed;
    LLL_embed_03 = LLL_embed;
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/beta0.4')
    load('nystrom_embed.mat')
    load('roseland_embed.mat')
    load('LLL_embed.mat')
    nystrom_embed_04 = nystrom_embed;
    roseland_embed_04 = roseland_embed;
    LLL_embed_04 = LLL_embed;
    cd('/home/grad/chaos/Desktop/mnist_result/result/clean data/beta0.5')
    load('nystrom_embed.mat')
    load('roseland_embed.mat')
    load('LLL_embed.mat')
    nystrom_embed_05 = nystrom_embed;
    roseland_embed_05 = roseland_embed;
    LLL_embed_05 = LLL_embed;
elseif noisy_data == 1
    cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/dm')
    load('dm_embed.mat')
    load('label.mat')
    cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/pca')
    load('pca_embed.mat')
    if clean_landmark == 0
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/noisy subset/beta0.3')
        load('nystrom_embed.mat')
        load('roseland_embed.mat')
        load('LLL_embed.mat')
        nystrom_embed_03 = nystrom_embed;
        roseland_embed_03 = roseland_embed;
        LLL_embed_03 = LLL_embed;
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/noisy subset/beta0.4')
        load('nystrom_embed.mat')
        load('roseland_embed.mat')
        load('LLL_embed.mat')
        nystrom_embed_04 = nystrom_embed;
        roseland_embed_04 = roseland_embed;
        LLL_embed_04 = LLL_embed;
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/noisy subset/beta0.5')
        load('nystrom_embed.mat')
        load('roseland_embed.mat')
        load('LLL_embed.mat')
        nystrom_embed_05 = nystrom_embed;
        roseland_embed_05 = roseland_embed;
        LLL_embed_05 = LLL_embed;
    elseif clean_landmark == 1
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/clean subset/beta0.3')
        load('nystrom_embed.mat')
        load('roseland_embed.mat')
        nystrom_embed_03 = nystrom_embed;
        roseland_embed_03 = roseland_embed;
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/clean subset/beta0.4')
        load('nystrom_embed.mat')
        load('roseland_embed.mat')
        nystrom_embed_04 = nystrom_embed;
        roseland_embed_04 = roseland_embed;
        cd('/home/grad/chaos/Desktop/mnist_result/result/noisy data/Gaussian/clean subset/beta0.5')
        load('nystrom_embed.mat')
        load('roseland_embed.mat')
        nystrom_embed_05 = nystrom_embed;
        roseland_embed_05 = roseland_embed;
    end
end
%% DM embedding
figure('Renderer', 'painters', 'Position', [10 10 800 800]);
hold on;axis tight;
for i = 0:9
   dig = find(label==i);
   dig = dig(1:15:end);
   scatter3(dm_embed(dig,1), dm_embed(dig,2), dm_embed(dig,3), 10, 'filled'); 
end   
%[l, hobj, hout, mout] = legend({'Digit 0','Digit 1','Digit 2','Digit 3','Digit 4','Digit 5','Digit 6','Digit 7','Digit 8','Digit 9'}, 'fontsize', 20);
%[l, hobj, hout, mout] = legend({'0','1','2','3','4','5','6','7','8','9'}, 'fontsize', 20);
%M = findobj(hobj,'type','patch');
%set(M,'MarkerSize',20);
axis off

cd('/home/grad/chaos/Desktop')
%export_fig('clean_mnist_dm','-transparent','-eps')
%export_fig('noisy_mnist_dm','-transparent','-eps')
%% Roseland embedding

figure('Renderer', 'painters', 'Position', [10 10 800 800]);
hold on;axis tight;
for i = 0:9
   dig = find(label==i);
   dig = dig(1:10:end);
   scatter3(roseland_embed_05(dig,1), roseland_embed_05(dig,2), roseland_embed_05(dig,3), 10, 'filled'); 
end   
%[l, hobj, hout, mout] = legend({'Digit 0','Digit 1','Digit 2','Digit 3','Digit 4','Digit 5','Digit 6','Digit 7','Digit 8','Digit 9'}, 'fontsize', 20);
%M = findobj(hobj,'type','patch');
%set(M,'MarkerSize',20);
axis off

cd('/home/grad/chaos/Desktop')
%export_fig('clean_mnist_roseland','-transparent','-eps')
%export_fig('noisy_mnist_noisy_sub_roseland','-transparent','-eps')
%export_fig('noisy_mnist_clean_sub_roseland','-transparent','-eps')
%% Nystrom

figure('Renderer', 'painters', 'Position', [10 10 800 800]);
hold on;axis tight;
for i = 0:9
   dig = find(label==i);
   dig = dig(1:10:end);
   scatter3(nystrom_embed_05(dig,1), nystrom_embed_05(dig,2), nystrom_embed_05(dig,3), 10, 'filled'); 
end   
%[l, hobj, hout, mout] = legend({'Digit 0','Digit 1','Digit 2','Digit 3','Digit 4','Digit 5','Digit 6','Digit 7','Digit 8','Digit 9'}, 'fontsize', 20);
%M = findobj(hobj,'type','patch');
%set(M,'MarkerSize',20);
axis off

cd('/home/grad/chaos/Desktop')
%export_fig('clean_mnist_nys','-transparent','-eps')
%export_fig('noisy_mnist_noisy_sub_nys','-transparent','-eps')
%export_fig('noisy_mnist_clean_sub_nys','-transparent','-eps')
%% PCA
figure('Renderer', 'painters', 'Position', [10 10 800 800]);
hold on;axis tight;
for i = 0:9
   dig = find(label==i);
   dig = dig(1:10:end);
   scatter3(pca_embed(dig,1), pca_embed(dig,2), pca_embed(dig,3), 10, 'filled'); 
end   
%[l, hobj, hout, mout] = legend({'Digit 0','Digit 1','Digit 2','Digit 3', 'Digit 4'}, 'fontsize', 30);
%M = findobj(hobj,'type','patch');
%set(M,'MarkerSize',20);
axis off

cd('/home/grad/chaos/Desktop')
%export_fig('clean_mnist_pca','-transparent','-eps')
%export_fig('noisy_mnist_pca','-transparent','-eps')

%% LLL

figure('Renderer', 'painters', 'Position', [10 10 800 800]);
hold on;axis tight;
for i = 0:9
   dig = find(label==i);
   dig = dig(1:10:end);
   scatter3(LLL_embed_05(dig,1), LLL_embed_05(dig,2), LLL_embed_05(dig,3), 10, 'filled'); 
end   
%[l, hobj, hout, mout] = legend({'Digit 0','Digit 1','Digit 2','Digit 3','Digit 4','Digit 5','Digit 6','Digit 7','Digit 8','Digit 9'}, 'fontsize', 20);
%M = findobj(hobj,'type','patch');
%set(M,'MarkerSize',20);
axis off

cd('/home/grad/chaos/Desktop')
%export_fig('clean_mnist_LLL','-transparent','-eps')
%export_fig('noisy_mnist_noisy_sub_LLL','-transparent','-eps')