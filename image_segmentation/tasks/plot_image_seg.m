% this script plots spectral based image segmentations
%% Nystrom
%% hawks clean
k = 4; %number of clusters
num = 3; %number of eigenvectors
image = imread('hawks.jpg');
[n,m]=size(image);
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
load('nys_embed_hawks.mat')
seg_plot_kmean(nys_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('clean_hawks_seg_nys','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(nys_embed(:,3), n,m));
axis off
%export_fig('clean_hawks_seg_nys_eigenvec1','-transparent','-eps')
%% hawks noisy
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
load('nys_embed_hawks.mat')
seg_plot_kmean(nys_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('noisy_hawks_seg_nys','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(nys_embed(:,1), n,m));
axis off
%export_fig('noisy_hawks_seg_nys_eigenvec1','-transparent','-eps')
%% Roseland
%% hawks clean
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
load('roseland_embed_hawks.mat')
seg_plot_kmean(roseland_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('clean_hawks_seg_roseland','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(roseland_embed(:,3), n,m));
axis off
%export_fig('clean_hawks_seg_roseland_eigenvec1','-transparent','-eps')
%% hawks noisy
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
load('roseland_embed_hawks.mat')
seg_plot_kmean(roseland_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('noisy_hawks_seg_roseland','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(roseland_embed(:,3), n,m));
axis off
%export_fig('noisy_hawks_seg_roseland_eigenvec1','-transparent','-eps')
%% LLL
%% hawks clean
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
load('LLL_embed_hawks.mat')
seg_plot_kmean(LLL_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('clean_hawks_seg_LLL','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(LLL_embed(:,3), n,m));
axis off
%export_fig('clean_hawks_seg_LLL_eigenvec1','-transparent','-eps')
%% hawks noisy
image = imread('hawks.jpg');
[n,m]=size(image);
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
load('LLL_embed_hawks.mat')
seg_plot_kmean(LLL_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('noisy_hawks_seg_LLL','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(LLL_embed(:,3), n,m));
axis off
%export_fig('noisy_hawks_seg_LLL_eigenvec1','-transparent','-eps')
%% PCA
%% hawks clean
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
load('pca_embed_hawks.mat')
seg_plot_kmean(pca_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('clean_hawks_seg_pca','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(pca_embed(:,3), n,m));
axis off
%export_fig('clean_hawks_seg_pca_eigenvec1','-transparent','-eps')
%% hawks noisy
image = imread('hawks.jpg');
[n,m]=size(image);
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
load('pca_embed_hawks.mat')
seg_plot_kmean(pca_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('noisy_hawks_seg_pca','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(pca_embed(:,3), n,m));
axis off
%export_fig('noisy_hawks_seg_pca_eigenvec1','-transparent','-eps')

%% Nystrom
%% cameraman clean
k = 4; %number of clusters
num = 4; %number of eigenvectors
image = imread('cameraman.jpg');
image = mean(image,3);
[n,m]=size(image);
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
load('nys_embed_cameraman.mat')
seg_plot_kmean(nys_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('clean_cameraman_seg_nys','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(nys_embed(:,4), n,m));
axis off
%export_fig('clean_cameraman_seg_nys_eigenvec1','-transparent','-eps')
%% cameraman noisy
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
load('nys_embed_cameraman.mat')
seg_plot_kmean(nys_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('noisy_cameraman_seg_nys','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(nys_embed(:,4), n,m));
axis off
%export_fig('noisy_cameraman_seg_nys_eigenvec1','-transparent','-eps')
%% Roseland
%% cameraman clean
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
load('roseland_embed_cameraman.mat')
seg_plot_kmean(roseland_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('clean_cameraman_seg_roseland','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(roseland_embed(:,4), n,m));
axis off
%export_fig('clean_cameraman_seg_roseland_eigenvec1','-transparent','-eps')
%% cameraman noisy
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
load('roseland_embed_cameraman.mat')
seg_plot_kmean(roseland_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('noisy_cameraman_seg_roseland','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(roseland_embed(:,4), n,m));
axis off
%export_fig('noisy_cameraman_seg_roseland_eigenvec1','-transparent','-eps')
%% LLL
%% cameraman clean
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
load('LLL_embed_cameraman.mat')
seg_plot_kmean(LLL_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('clean_cameraman_seg_LLL','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(LLL_embed(:,4), n,m));
axis off
%export_fig('clean_cameraman_seg_LLL_eigenvec1','-transparent','-eps')
%% cameraman noisy
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
load('LLL_embed_cameraman.mat')
seg_plot_kmean(LLL_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('noisy_cameraman_seg_LLL','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(LLL_embed(:,4), n,m));
axis off
%export_fig('noisy_cameraman_seg_LLL_eigenvec1','-transparent','-eps')
%% PCA
%% cameraman clean
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
load('pca_embed_cameraman.mat')
seg_plot_kmean(pca_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('clean_cameraman_seg_pca','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(pca_embed(:,4), n,m));
axis off
%export_fig('clean_cameraman_seg_pca_eigenvec1','-transparent','-eps')
%% cameraman noisy
cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
load('pca_embed_cameraman.mat')
seg_plot_kmean(pca_embed,k,num,n,m)
cd('/home/grad/chaos/Desktop')
%export_fig('noisy_cameraman_seg_pca','-transparent','-eps')
%%
figure('Renderer', 'painters', 'Position', [10 10 m n]);
imagesc(reshape(pca_embed(:,4), n,m));
axis off
%export_fig('noisy_cameraman_seg_pca_eigenvec1','-transparent','-eps')