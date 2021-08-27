% this scripts times PCA
%% list of images
listing = dir('/home/grad/chaos/Desktop/image_seg/image_seg/COCOval2017');
images = listing(3:end);
%% constants
iter = 100;
n = 480;
m = 640;
embed_dim = 10;
kW = 500;
Patch_size = 5;
pca_runtime = zeros(iter,1);
%%
for i = 1:iter

    % get an image
    image = imread(images(i).name);
    if length(size(image)) == 3
        % 3 channels
        image = image(:,:,1);
    end
    image = double(image);
    enlarge = [image image; image image];
    image = enlarge(1:n, 1:m);
    
    % patch data
    data = Patch_image(image, Patch_size);
    
    % PCA
    tic;
    coeff = pca(data);
    pca_embed = data * coeff(:,1:embed_dim);
    pca_runtime(i) = toc; 
end
%% save
cd('/home/grad/chaos/Desktop')
save('pca_runtime.mat', 'pca_runtime');
