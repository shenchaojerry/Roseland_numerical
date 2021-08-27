% this scripts times Nystrom and Roseland
%% list of images
% COCO dataset can be downloaded from https://cocodataset.org/#home
listing = dir('/home/grad/chaos/Desktop/image_seg/image_seg/COCOval2017');
images = listing(3:end);
%% constants
iter = 100;
n = 480;
m = 640;
Beta = [0.2, 0.3, 0.4];
Patch_size = 3;
embed_dim = 10;
Nys_runtime = zeros(iter, length(Beta));
Roseland_runtime = zeros(iter, length(Beta));
%%
for j = 1:length(Beta)
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

        % get subset
        p = image(:);
        diff = p(2:end)-p(1:end-1);
        low = quantile(diff, 0.05);
        high = quantile(diff, 0.95);
        % candidates for edges
        candidate_edge = [find(diff<low); find(diff>high)];
        N = length(candidate_edge);
        subind = randperm(N);
        subset_size = round((n*m)^Beta(j));
        subset_ind = candidate_edge(subind(1:subset_size));
    
        % nystrom
        tic;
        [nys_embed, ~] = Nystrom_image(image, Patch_size, embed_dim, subset_ind, 0);
        time_nys = toc;
        % Roseland
        [roseland_embed, ~, time_roseland] = Roseland_image(image, Patch_size, embed_dim, subset_ind, 1);
        
        Nys_runtime(i,j) = time_nys;
        Roseland_runtime(i,j) = time_roseland;
    end
end

%% save
cd('/home/grad/chaos/Desktop')
save('Nys_runtime.mat', 'Nys_runtime');
save('Roseland_runtime.mat', 'Roseland_runtime');
