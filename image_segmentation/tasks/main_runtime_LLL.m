% this scripts times LLL
%% list of images
listing = dir('/home/grad/chaos/Desktop/image_seg/image_seg/COCOval2017');
images = listing(3:end);
%% constants
iter = 100;
n = 480;
m = 640;
Beta = [0.2, 0.3, 0.4];
embed_dim = 10;
kW = 500;
Patch_size = 5;
LLL_runtime = zeros(iter, length(Beta));
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

        % affinity
        tic;
        W = LLL_affinity(image, Patch_size, kW);
        build_affinity_time = toc;
        
        % patch data
        data = Patch_image(image, Patch_size);
        % LLL
        subset_size = round((n*m)^Beta(j));
        kZ = min(50, subset_size);
        tic;
        [LLL_embed,~,~] = lll(data,W,embed_dim,subset_size,kZ,0);
        time_LLL = toc;
        LLL_runtime(i,j) = time_LLL + build_affinity_time;
        
    end
end

%% save
cd('/home/grad/chaos/Desktop')
save('LLL_runtime.mat', 'LLL_runtime');
