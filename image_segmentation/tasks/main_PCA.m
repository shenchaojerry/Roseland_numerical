% this script performs spectral based image segmentation using PCA
%% constants
images = ["hawks","cameraman"];
Add_noise = [0 1];
Patch_size = 5;
%%
for add_noise = Add_noise
    for img = images
        % load data
        image = imread(strcat(img,'.jpg'));
        if length(size(image)) == 3
            % 3 channels
            image = image(:,:,1);
        end
        image = double(image);

        [n,m]=size(image);
        embed_dim = 10;

        % add noise
        if add_noise == 1
            image = image ./ 255;
            rng(1);
            noise = 0.2 * randn(size(image)); % gaussian
            %noise =  trnd(4, size(image)) / sqrt(2) * .1; % student t
            image = image+ noise;
            image = image .* 255;
        end
        
        % patch data
        data = Patch_image(image, Patch_size);
        
        % PCA
        tic;
        coeff = pca(data);
        pca_embed = data * coeff(:,1:embed_dim);
        time_pca = toc; 
        
        if add_noise == 0
            cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
            save(strcat('pca_embed_',img,'.mat'), 'pca_embed');
           
        end
        if add_noise == 1
            cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
            save(strcat('pca_embed_',img,'.mat'), 'pca_embed');
           
        end
    end
end
