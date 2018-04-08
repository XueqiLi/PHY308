%example4_matrices
%
%This example script shows how matrix multiplication and diagonalization
%works in MATLAB.
%
%Tom Allison 8/22/2013 

%Define some matrices

A = [1 0 0
     0 1 -2
    0 -2 3]; % a Hermitian matrix
  
B = [1 0 0 
     0  2 0
     0 0  2]; % another Hermitian and diagonalized matrix. Degenerate eigenvalues
 
%Multiply the matrices

F = A*B % use * here instead .* because now we want to do matrix 
             % multiplication- NOT element wise multiplication.

 
 % Evaluate the commutator
 
C = A*B-B*A; % use * here instead .* because now we want to do matrix 
             % multiplication- NOT element wise multiplication.

[V,D] = eig(A); % get the eigenvectors and eigenvalues of A   
                % V is a matrix containg the Eigenvalues as the columnts
                % D is a diagonal matrix with the eigenvalues as the 

% unpack the eigenvalues
lam1 = D(1,1);  % the first eigen value is the 1,1 element of D
lam2 = D(2,2);
lam3 = D(3,3);

% upack the eigenvectors
v1 = V(:,1); % take the first column of V as the first eigenvector.
v2 = V(:,2);
v3 = V(:,3);

% Verify that v3 is an eigenvector of A with eigenvalue lam3

test1 = A*v3 

test2 = lam3*v3

%test1 does equal test2. Check!

%Now verify that the eigenvectors are also eigenvectors of B, which they
%should be because A and B commute. Recognizing that matrix multiplication
%is just a series of matrix vector multiplications, you can see that we
%have A*V = V*D where V is the matrix with eigenvalues as columns and D is
%the diagonal matrix with eigenvalues on the diagonal. The eigenvalues of B
%using the eigenvectors of A should then be given by

DB = inv(V)*B*V; %take the inverse of V using inv(V)

% since DB is diagonal, the eigenvectors of A are also eigenvectors of B.

% You can also check that the eigenvectors of A are orthogonal, which they
% should be because A is Hermitian. You can do this using MATLAB's dot
% product

dp12 = dot(v1,v2)
dp13 = dot(v1,v3)
dp23 = dot(v2,v3)

% the eigenvectors are orthognal and the eigenvalues are real. Looks like a
% Hermitian matrix to me!!!




             
              
             
 
 