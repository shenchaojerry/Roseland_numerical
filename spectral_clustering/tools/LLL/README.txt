(C) 2013 by Max Vladymyrov and Miguel A. Carreira-Perpinan
    Electrical Engineering and Computer Science
    University of California, Merced
    http://eecs.ucmerced.edu

Matlab code for large-scale dimensionality reduction using Locally Linear 
Embedding (LLL) for Laplacian Eigenmaps.

References:
- Original Laplacian Eigenmaps algorithm:
  M. Belkin & P. Niyogi: "Laplacian Eigenmaps for dimensionality reduction 
  and data representation", Neural Computation, 2003.
- The paper introducing LLL:
  M. Vladymyrov & M. A. Carreira-Perpinan: "Locally Linear Landmarks for 
  large-scale manifold learning", ECML-PKDD, 2013.

Given a dataset Y, a typical use of this code is: 
  X = lll(Y,W,d,L,kZ);
where:
- X: low-dimensional coordinates of Y.
- W: affinity matrix of the dataset Y.
- d: dimensionality of the latent space.
- L: total number of landmarks (as large as computationally feasible).
- kZ: number of landmarks each point uses (sligthly bigger than d).

See demo.m for detailed examples of usage and a comparison with Laplacian
Eigenmaps.

List of functions:
- lll.m: computes the embedding X using LLL for Laplacian Eigenmaps.
- lllmap.m: out-of-sample mapping for LLL.
See each function for detailed usage instructions.

The following are auxiliary or used internally by other functions:
- lmarks.m: selects L landmarks from the dataset (random or k-means).
- lweights.m: reconstruction weights of each point from its kZ landmarks.
- gaussaff.m: computes Gaussian affinities of a dataset.
- lapeig.m: original Laplacian Eigenmaps algorithm.
- kmeans.m: k-means algorithm.
- sqdist: matrix of Euclidean squared distances between two point sets.

