function eigenvec_plot(embedding,n,m)
    figure('Renderer', 'painters', 'Position', [10 10 1100 800]);
    for i = 1:9
        embed = embedding(:,i);
        %thre = quantile(embed, 0.8);
        %embed(embed<thre)=0;
        subplot(3,3,i)
        imagesc(reshape(embed, n, m)); colormap(gray)
        axis off
    end
end