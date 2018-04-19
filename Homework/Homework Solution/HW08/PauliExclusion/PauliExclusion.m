%PauliExclusion.m
%
%This script makes plots of an excited configuration of the two electron in
%a box problem. Illustrates the Pauli Exclusion principle.
%
%Tom Allison 11/10/2013

%% Part a)
% See pdf scan

%% Part b)

x1 = linspace(0,1);
x2 = linspace(0,1);

[X1,X2] = meshgrid(x1,x2);

PSI = 2*(sin(pi*X1).*sin(2*pi*X2) - sin(pi*X2).*sin(2*pi*X1));

figure(1)
surf(X1,X2,PSI.^2);
xlabel('x_1/L');
ylabel('x_2/L');
view([0 0 1]);
setfigfont(1,14);

%% Interpretation
% The wavefunction has a node when x1 = x2 because the two particles have
% the same spin. When they have the same spin, the Pauli exclusion
% principle prevents them from being at the same place. This problem shows
% that the antisymeterization requirement takes care of the particles not
% being at the same place with the same spin because the probability of
% that happening is Psi(x,x) with x1 = x2, and this is identicaly zero.



