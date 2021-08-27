% Xt = lllmap(Yt,Y0,kZ,X0) Out-of-sample mapping for LLL
%
% This projects a test set of high-dimensional points Yt to low-dimensional
% space coordinates Xt. You have to run lll.m first in a training set Y:
%   [X,lx,Z,Y0,X0] = lll(Y,W,d,L,kZ,nl);
%   Xt = lllmap(Yt,Y0,kZ,X0);
%
% In:
%   Yt: MxD matrix of M row D-dimensional vectors, the test data.
%   Y0: LxD matrix of L row D-dimensional vectors, the landmarks.
%   kZ: number of neighbouring landmarks to use for each data point.
%   X0: L x d matrix of L row d-dimensional vectors, the landmark projections.
% Out:
%   Xt: M x d matrix of M row d-dimensional vectors, the projections of Yt.

% Copyright (c) 2013 by Max Vladymyrov and Miguel A. Carreira-Perpinan

function Xt = lllmap(Yt,Y0,kZ,X0)

Zt = lweights(Yt,Y0,kZ);	% Find reconstruction weights
Xt = Zt'*X0;			% Reconstruct low-dimensional projections

