function [nbound,En] = finitesquarewell(V0,a)
%FINITESQUAREWELL
%
%[nbound,En] = finitesquarewell(V0,a) 
%This function finds and plots the bound solutions of the 1D Schrodinger
%equation for the finite square well of depth V0. V0 is a positive number 
%and the well bottom is at -V0. Works in units where the width of the well
%2a and hbar and m = 1. nbound is the number of 
%bound solutions. En is the energy of the bound state solutions in the 
%same units of V0 (E = 1 = hbar^2/m(2*a)^2)
%
%Notation and equations follow notation of D.J. Griffths' "Introduction to
%Quantum Mechanics".
%
%Tom Allison 8/31/2013

set(0,'DefaultLineLineWidth',2);

m = 1;
hbar = 1;
Escale = (2*pi)^2*hbar^2/(m*a^2); % natural energy scale for this problem in these units

z0 = a/hbar*sqrt(2*m*V0)
eps = 1E-6; %eps is a small offset on the search intervals that keep finder away from infinities!

x = linspace(-6,6,1E3); % this must be symmetric for code to work (same number of negative and positive x points)

%calculate Levine's b parameter so we know how many states to look for
b = sqrt(2*m*V0)*(2*a)/hbar

nbound = ceil(b/pi) %round up using Levine equation 2.36

%% Initialize arrays and matrices
psin = zeros(nbound,length(x)); % each row of this matrix will correspond to a bound state
En = zeros(nbound,1); % column vector with the energy eigenvalues
kapn = zeros(nbound,1);
kn = zeros(nbound,1);

%% Solve for wave functions and energies
% This for loop looks for alternating even and odd solutions to the TISE
for j = 1:nbound
    if mod(j+1,2) == 0 % even number
        zguess = [(j-1)*pi/2+eps,min([j*pi/2-eps,z0-eps])]; % the zeros for the even functions are expected in these interval
        zz = fzero(@zerome_even,zguess); %looking for even bound state. Search for z = ka
        En(j) = hbar^2*zz^2/(2*m*a^2)-V0; % calculate energy        
        kn(j) = zz/a; % calculate wavevector k in well region
        kapn(j) = sqrt(-2*m*En(j)/hbar^2); %calculate exponential decay outside of well
        FoverD = cos(kn(j)*a)*exp(kapn(j)*a); % ratio of coefficients        
        
        Iexp = find(abs(x)>=a); % find indeces for x outside the well
            psin(j,Iexp) = FoverD*exp(-kapn(j)*abs(x(Iexp))); % assign function for x outside the well
        Icos = find(abs(x)<a); % find indeces
            psin(j,Icos) = cos(kn(j)*x(Icos)); %assign function for x inside the well    
    
    else % odd number
        
        zguess = [(j-1)*pi/2+eps,min([j*pi/2-eps,z0-eps])]; % same as before
        zz = fzero(@zerome_odd,zguess); %looking for odd bound state.

        En(j) = hbar^2*zz^2/(2*m*a^2)-V0;        
        kn(j) = sqrt(2*m*(En(j)+V0)/hbar^2);
        kapn(j) = sqrt(-2*m*En(j)/hbar^2);
        
        FoverC = sin(kn(j)*a)*exp(kapn(j)*a); % ratio of coefficients 
        
        Iexp = find(x>=a); % find indeces for x outside the well to the right
            psin(j,Iexp) = FoverC*exp(-kapn(j)*abs(x(Iexp))); % assign function for x outside the well
        Isin = find(x<a & x >= 0); % find indeces for right half of well
            psin(j,Isin) = sin(kn(j)*x(Isin)); %assign function for x inside the well (right half)
        
        Ineg = find(x<0);
            psin(j,Ineg) = -1*psin(j,reverse([Isin,Iexp])); % assign negative values based on oddness
    end    
end

%rescale psin so it looks nice on the plot
psin = psin*V0/(2*nbound);

colors = 'rbgcmk';
colors = [colors,colors,colors,colors,colors,colors,colors,colors]; %make longer colors array

figure(1);
Ileft = find(x<=-a); % find indeces for x outside the wel
Imid = find(abs(x)<a);
Iright = find(x>=a);

%make a plotable potential
V = [zeros(1,length(Ileft)),-1*V0*ones(1,length(Imid)),zeros(1,length(Iright))];

plot(x,V,'k','LineWidth',4); %plot the potentials
hold on

for j = 1:nbound
    plot(x,En(j)*ones(1,length(x)),'k--')
    hold on
    plot(x,psin(j,:) + En(j),colors(j)) % plot the potentials offset by the energies
end

hold off
axis( [xlim,min(psin(1,:))-1-V0,max(psin(end,:))+1] ); % scale axes nicely so everyone fits
xlabel('x');
ylabel('\psi_n (not normalized)');
hfonts = findall(1,'FontUnits','points'); % switch to 14 point font
set(hfonts,'FontSize',14);
title(['hbar = m = 1, a = ',num2str(a),', V0 = ',num2str(V0)]);
grid on

% Functions that are zeroed to find the solutions.

function q = zerome_even(z)
%q = zerome_even(z)
%The zeros of this function correspond to the even solutions of the finite
%square well. z = ka = sqrt(2*(E+V0)*m/hbar^2).
   q = tan(z)-sqrt((z0./z).^2-1);  
end

function q = zerome_odd(z)
%q = zerome_odd(z)
%The zeros of this function correspond to the odd solutions of the finite
%square well. z = ka = sqrt(2*(E+V0)*m/hbar^2).
   q = tan(z) + sqrt(z.^2./(z0^2-z.^2));
    
end

end

   