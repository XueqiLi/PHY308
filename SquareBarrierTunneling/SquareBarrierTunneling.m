%SquareBarrierTunneling.m
%
%This script calculates the transmission and reflection probability for
%tunneling through a 1D square barrier of height Vb using nonrelativistic
%quantum mechanics.
%
%Tom Allison 2/6/2017

%% Preliminaries

set(0,'DefaultLineLineWidth',2);
i = sqrt(-1);
hbar = 1;
m = 1;
Vb = 4;
L = 2;

E = linspace(0.01*Vb,5*Vb,75);
k1 = sqrt(2*m*E/hbar^2);
kap2 = sqrt(2*m*(Vb-E)/hbar^2);
k3 = k1;

BCDF = zeros(4,length(E)); %initialize matrix to store the coefficients.

%% Define matrix
for j = 1:length(E);
    
    RHS = [1
           i*k1(j)
           0
           0    ];
    
    S = [ -1            1                           1                       0              ;
          i*k1(j)      -kap2(j)                     kap2(j)                 0              ;
           0            exp(-kap2(j)*L)             exp(kap2(j)*L)          -exp(i*k3(j)*L);
           0            -kap2(j)*exp(-kap2(j)*L)     kap2(j)*exp(kap2(j)*L)  -i*k3(j)*exp(i*k3(j)*L)];
    
    BCDF(:,j) = inv(S)*RHS;
    
end

R = BCDF(1,:).*conj(BCDF(1,:));
T = BCDF(4,:).*conj(BCDF(4,:));

%% plot results

x= linspace(-5*L,6*L,1E3);
psi = zeros(1,length(x));
V = zeros(1,length(x));
I = find(x > 0 & x < L);
V(I) = Vb;
for j = 1:length(E);
    
    figure(1);
    subplot(2,1,1);
    hR = plot(E(1:j)/Vb,R(1:j),'r-o');
    hold on
    hT = plot(E(1:j)/Vb,T(1:j),'k-o');
    hold off
    xlabel('E/Vb');
    ylabel('R or T');
    legend([hR,hT],'R','T');
    grid on
    axis([0,max(E)/Vb,0,1]);   
    subplot(2,1,2);
    A = 1;
    B = BCDF(1,j);
    C = BCDF(2,j);
    D = BCDF(3,j);
    F = BCDF(4,j);
    I1 = find(x<0);
    psi(I1) =  A*exp(i*k1(j)*x(I1)) + B*exp(-i*k1(j)*x(I1));
    I2 = find(x >= 0 & x< L);
    psi(I2) = C*exp(-kap2(j)*x(I2)) + D*exp(kap2(j)*x(I2));
    I3 = find(x >= L); 
    psi(I3) = F*exp(i*k3(j)*x(I3)); 
    hreal = plot(x,real(psi)+E(j),'r');
    hold on
    himag = plot(x,imag(psi)+E(j),'b');
    htot = plot(x,psi.*conj(psi)+E(j),'m');
    plot(x,V,'k','LineWidth',3)
%     hline(gcf,E(j),'k--');
    grid on
    hold off
    xlabel('x');
    ylabel('\psi');
%     setfigfont(1,14);
    legend([hreal,himag,htot],'real \psi','imaginary \psi','|\psi|^2','Location','SouthEast');
%     setfigfont(1,16);
    
    pause
end
    
    
    

