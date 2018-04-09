function [] = plotsphericalharmonic(J,m)
%plotsphericalharmonic
%
%plotsphericalharmonic(J,m) plots the spherical harmonic with azimuthal
%quantum number J and magnetic quantum number m. The function spits out
%several plots.
%
%figure 1: plot |YJm|^2 in the xz plane.
%
%figure 2: 3D surface plot where the distance from the orign is |YJm| and
%the color represents the sign of the Legendre Polynomial. very useful for
%for m=0 functions.
%
%figure 3: 3D surface plot where distance from origin is |YJm| and color
%represents real part.
%
%figure 4: 3D surface plot where distance from origin is |YJ| and color
%represents imaginary part. 
%
%Tom Allison

i = sqrt(-1);

% Create the grid
delta = pi/(20*(J+1));
theta = 0 : delta : pi; % altitude
phi = 0 : 2*delta : 2*pi; % azimuth
[PHI,THETA] = meshgrid(phi,theta); % make 2D meshgrid

Y = zeros(size(PHI));
signmat = zeros(size(PHI));

% Calculate the harmonic
Yat_phi0 = Ylm(J,m,theta,0);

for k = 1:length(phi);
    Y(:,k) = Yat_phi0*exp(i*m*phi(k));
    signmat(:,k) = sign(Yat_phi0);
end

% conver to xyz coordinates for surface plot.
x = abs(Y).*sin(THETA).*cos(PHI); 
y = abs(Y).*sin(THETA).*sin(PHI);
z = abs(Y).*cos(THETA);

Ipos = find(Yat_phi0 >= 0); % find positive lobes
Ypos = Yat_phi0(Ipos);

Ineg = find(Yat_phi0 < 0); % find negative lobes
Yneg = Yat_phi0(Ineg);

figure(1);
hpos = polar(theta(Ipos)+pi/2,Ypos,'r') %plot positive lobe
hold on
hneg = polar(theta(Ineg)+pi/2,abs(Yneg),'g'); % plot negative lobe
polar(-theta(Ineg)+pi/2,abs(Yneg),'g'); % plot mirror images
polar(-theta(Ipos)+pi/2,Ypos,'r')
hold off
legend([hpos,hneg],'Y positive','Y negative');


% Plot the surface
figure(2);
clf
surf(x,y,z,signmat); % 3D surface plot
light
lighting phong
axis tight equal
zlabel('z');
xlabel('x');
ylabel('y');

view(40,30)
%camzoom(1.5)
colormap([0 1 0; 1 0 0])
title('Binary Color Shading on Sign of Legendre Polynomial');

figure(3);
clf
surf(x,y,z,real(Y))
light
lighting phong
axis tight equal
zlabel('z');
xlabel('x');
ylabel('y');
view(40,30)
title('Color Shading for Real Part');

figure(4)
clf
surf(x,y,z,imag(Y))
light
lighting phong
axis tight equal
zlabel('z');
xlabel('x');
ylabel('y');
view(40,30)
title('Color Shading for Imaginary Part');

