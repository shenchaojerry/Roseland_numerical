% this script plots embeddings for first 5 MNIST digits 
%% DM embedding
load('dm_embed.mat')
load('label.mat')

figure('Renderer', 'painters', 'Position', [10 10 1000 800]);
hold on;axis tight;
for i = 0:4
   dig = find(label==i);
   dig = dig(1:5:end);
   scatter3(dm_embed(dig,1), dm_embed(dig,2), dm_embed(dig,3), 6, 'filled'); 
end   
%[l, hobj, hout, mout] = legend({'Digit 0','Digit 1','Digit 2','Digit 3', 'Digit 4'}, 'fontsize', 30);
[l, hobj, hout, mout] = legend({'0','1','2','3', '4'}, 'fontsize', 30);
M = findobj(hobj,'type','patch');
set(M,'MarkerSize',20);
axis off

%export_fig('clean_mnist_dm','-transparent','-eps')
%% Roseland embedding
load('roseland_embed.mat')

figure('Renderer', 'painters', 'Position', [10 10 1000 800]);
hold on;axis tight;
for i = 0:4
   dig = find(label==i);
   dig = dig(1:5:end);
   scatter3(roseland_embed(dig,1), roseland_embed(dig,2), roseland_embed(dig,3), 6, 'filled'); 
end   
%[l, hobj, hout, mout] = legend({'Digit 0','Digit 1','Digit 2','Digit 3', 'Digit 4'}, 'fontsize', 30);
%M = findobj(hobj,'type','patch');
%set(M,'MarkerSize',20);
axis off


%% Nystrom
load('nystrom_embed.mat')

figure('Renderer', 'painters', 'Position', [10 10 1000 800]);
hold on;axis tight;
for i = 0:4
   dig = find(label==i);
   dig = dig(1:5:end);
   scatter3(nystrom_embed(dig,1), nystrom_embed(dig,2), nystrom_embed(dig,3), 6, 'filled'); 
end   
%[l, hobj, hout, mout] = legend({'Digit 0','Digit 1','Digit 2','Digit 3', 'Digit 4'}, 'fontsize', 30);
%M = findobj(hobj,'type','patch');
%set(M,'MarkerSize',20);
axis off

%% PCA
load('pca_embed.mat')

figure('Renderer', 'painters', 'Position', [10 10 1000 800]);
hold on;axis tight;
for i = 0:4
   dig = find(label==i);
   dig = dig(1:5:end);
   scatter3(pca_embed(dig,1), pca_embed(dig,2), pca_embed(dig,3), 6, 'filled'); 
end   
%[l, hobj, hout, mout] = legend({'Digit 0','Digit 1','Digit 2','Digit 3', 'Digit 4'}, 'fontsize', 30);
%M = findobj(hobj,'type','patch');
%set(M,'MarkerSize',20);
axis off
