%WavePacket_demo.m
%
%This script lets you create a wave packet and watch it move by specifying
%it's momentum space distrubition. Works in units where hbar = m = 1.
%
%Tom Alliosn 2/5/2017

% with hbar = m = 1, k = p = 2*pi/(de Broglie Wavelength).

%% Preliminaries

set(0,'DefaultLineLineWidth',2);

i = sqrt(-1);
k0 = 3; % central momentum.
kw = 0.5; % standard deviation of distribution in momentum space.
k = linspace(-10,10,2^10); % number of points should be a power of 2 if you want to later use FFT algorthims. %
%omega = k.^2/2; % the all important dispersion relation for matter waves.
%omega = k0*k; % dispersion relation for light waves with the same speed as the matter wave.
omega = 2*k0^(3/2)*sqrt(abs(k)); %dispersion relation for water waves with the same speed as the matter wave.
dk = k(2)-k(1);

%% Define phi(k).
% Three preset options.

% Gaussian
phi_k = sqrt(1/sqrt(2*pi*kw^2))*exp(-(k-k0).^2/(4*kw^2)); 

% sech^2
% phi_k = sech((k-k0)/kw).^2; % un-normalized sech^2 pulse.
% phi_k = phi_k/sqrt(dk*trapz(phi_k.*conj(phi_k))); % normalize it


% square
%  phi_k = zeros(1,length(k));
%  I = find(abs(k-k0) < kw);
%  phi_k(I) = 1/(2*kw); % normalized square;
% 

avek = dk*trapz(conj(phi_k).*k.*conj(phi_k)); % expectation value of k
aveksq = dk*trapz(conj(phi_k).*k.^2.*conj(phi_k)); % expectation value of k^2
sigmak = sqrt(aveksq-avek^2);

figure(1);
subplot(2,1,1);
hk = plot(k,abs(phi_k));
xlabel('k');
ylabel('|\phi(k)|^2');
legend(hk,'|\Phi(k,0)|^2');
grid on

%% Calculate Psi(x,t) via Fourier transform.
% All of the Fourier transform math would be much faster here using the FFT
% algorithm, but we leave it here explicitly for pedagogical purposes.
% Also plot results.

xend = 50;
t = linspace(0,xend/avek,20); % enough time for the wave packet to travel xend units.
x = linspace(-30,100,4*length(k)); % autosize grid so wavepacket doesn't run off it.

PSI = zeros(length(t),length(x));   
    
for l = 1:length(t)% Calculate PSI(l,:) for each time step.
    for j = 1:length(x); % do integral for each value of x.
        PSI(l,j) = 1/sqrt(2*pi)*dk*trapz( phi_k.*exp(i*( k*x(j)-omega*t(l) )) ); % make psi at t = 0 as simple Fourier transform.
    end
    subplot(2,1,2);
    hreal = plot(x,real(PSI(l,:)),'k');
    hold on
    henv = plot(x,abs(PSI(l,:)),'r');
    plot(x,-abs(PSI(l,:)),'r');
    hold off
    xlabel('x');
    ylabel('\Psi(x,t)');
    axis([xlim,-1,1]);
    setfigfont(1,14);
    title(['t = ',num2str(t(l))]);
    legend([hreal,henv],'Real Part','Envelope |\Psi|');
    grid on
    pause(0.2)
    
end



