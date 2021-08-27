% this script performs spectral based image segmentation using Nystrom and
% Roseland
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

        % subset
        p = image(:);
        diff = p(2:end)-p(1:end-1);
        low = quantile(diff, 0.05);
        high = quantile(diff, 0.95);
        % candidates for edges
        candidate_edge = [find(diff<low); find(diff>high)];
        N = length(candidate_edge);
        rng(1);
        subind = randperm(N);
        subset_size = round((n*m)^0.45);
        subset_ind = candidate_edge(subind(1:subset_size));
        % nystrom
        [nys_embed, S] = Nystrom_image(image, Patch_size, embed_dim, subset_ind, 0);
        nys_embed = nys_embed * diag(S);
        % Roseland
        [roseland_embed, S, ~] = Roseland_image(image, Patch_size, embed_dim, subset_ind, 1);
        roseland_embed = roseland_embed * diag(S);
        
        if add_noise == 0
            cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/clean_image')
            save(strcat('nys_embed_',img,'.mat'), 'nys_embed');
            save(strcat('roseland_embed_',img,'.mat'), 'roseland_embed');
        end
        if add_noise == 1
            cd('/home/grad/chaos/Desktop/image_seg_result/kmeans/noisy_image')
            save(strcat('nys_embed_',img,'.mat'), 'nys_embed');
            save(strcat('roseland_embed_',img,'.mat'), 'roseland_embed');
        end
    end
end

%%
eigenvec_plot(nys_embed,n,m)
eigenvec_plot(roseland_embed,n,m)
%%
num = 4;
k=4;
seg_plot_kmean(nys_embed,k,num,n,m)
seg_plot_kmean(roseland_embed,k,num,n,m)