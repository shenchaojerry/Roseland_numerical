% this script performs spectral based image segmentation using LLL
%% constants
images = ["hawks","cameraman"];
Add_noise = [0 1];
Patch_size = 5;
kW = 1681;
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
        
        % affinity
        tic;
        W = LLL_affinity(image, Patch_size, kW);
        build_affinity_time = toc;
        % patch data
        data = Patch_image(image, Patch_size);
        % LLL
        subset_size = round((n*m)^0.45);
        kZ = min(50, subset_size);
        tic;
        [LLL_embed,~,~] = lll(data,W,embed_dim,subset_size,kZ,0);
        time_LLL = toc;
        Time_LLL = time_LLL + build_affinity_time;
        
        if add_noise == 0
            cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
            save(strcat('LLL_embed_',img,'.mat'), 'LLL_embed');
           
        end
        if add_noise == 1
            cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
            save(strcat('LLL_embed_',img,'.mat'), 'LLL_embed');
           
        end
    end
end

%%
eigenvec_plot(LLL_embed,n,m)
%%
num = 4;
k=4;
seg_plot_kmean(LLL_embed,k,num,n,m)