% LLL and Laplacian Eigenmaps with a Swissroll dataset
% (6000 points training, 2000 test).
% This demo uses a medium-size dataset so it runs in a few seconds.
% The speedup of LLL over Laplacian Eigenmaps is larger with larger datasets.

rng(1);

% Generate Swissroll dataset
Nall = 8000; N = 6000;
a = ((7/2*pi-pi/2)*(rand(Nall,1).^0.65)+pi/2); tall = 100*rand(Nall,1);
Yall = [a.*cos(a) tall a.*sin(a)];
Y = Yall(1:N,:); t = tall(1:N);			% Training dataset
Yt = Yall(N+1:end,:); tt = tall(N+1:end);	% Test dataset

figure(1); scatter3(Y(:,1),Y(:,2),Y(:,3),3,t); daspect([1 1 1]); view(-10,2);
figure(2); scatter3(Yt(:,1),Yt(:,2),Yt(:,3),3,tt);daspect([1 1 1]);view(-10,2);
drawnow;

% Compute Gaussian affinities with bandwidth s and kW neighbours
fprintf('Computing Gaussian affinities... ');
s = 1.5; kW = 400; tic; W = gaussaff(Y,{'k',kW},s); t0 = toc;
fprintf('%3.2f seconds\n',t0);

% Type of Laplacian and dimension of latent space
nl = 0; d = 2;

% The usual Laplacian Eigenmaps on the entire dataset
fprintf('Computing Laplacian Eigenmaps... ');
tic; XLE = lapeig(d,W,nl); t1 = toc;
fprintf('%3.2f seconds\n',t1);

% Total number of landmarks and number of landmarks for each point, for LLL
L = 500; kZ = 3;
% LLL
fprintf('Computing LLL... ');
tic; [X,Y0,X0] = lll(Y,W,d,L,kZ,nl); t2 = toc;
fprintf('%3.2f seconds\n',t2);

% Project test points (in Yt) using LLL out-of-sample mapping
fprintf('Computing LLL out-of-sample mapping... ');
tic; Xt = lllmap(Yt,Y0,kZ,X0); t3 = toc;
fprintf('%3.2f seconds\n',t3);

figure(3); scatter(XLE(:,1),XLE(:,2),20,t); daspect([1 1 1]);
title(['Laplacian Eigenmaps, runtime: ' num2str(t1) ' s']);
figure(4); scatter(X(:,1),X(:,2),20,t); daspect([1 1 1]);
title(['LLL, runtime: ' num2str(t2) ' s']);
figure(5); scatter(Xt(:,1),Xt(:,2),20,tt); daspect([1 1 1]);
title(['LLL (out-of-sample), runtime: ' num2str(t3) ' s']);

