%particlemovinginbox.m
%
%This script works out the solution to the 1D particle moving in a box.
%
%Tom Allison 7/18/2013

set(0,'DefaultLineLineWidth',2);

%% Construct quantum result

i = sqrt(-1);

h = 1;
m =1;
l = 1;

n = [990:1010] %Stationary states to superimpose
En = n.^2*h^2/(8*m*l^2);
En = En';
E = 1/length(n)*sum(En);
t = linspace(0,4*sqrt(m/(2*E)),200);

xovl = linspace(0,1,15*max(n)); % x/l, take is so there are roughly 10 points per cycle
psi_n = zeros(length(n),length(xovl)); % initialize psi_n, a matrix containing all the wavefunctions
psi_t = zeros(length(t),length(xovl)); %initialize psi_t, a matrix where each row is the wave function at a different time
psi2 = zeros(length(t),length(xovl));
xq = zeros(1,length(t));


%% Construct Classical Result

xc = zeros(1,length(t));

for j = 1:length(t);
    if mod(t(j)/(l/(2*E/m)^0.5),2) <= 1
        xc(j) = mod((2*E/m)^0.5*t(j),2)/l;
    else
        xc(j) = 2-mod((2*E/m)^0.5*t(j),2)/l;
    end
end

%% Construct quantum result

for j = 1:length(n)
    psi_n(j,:) = sqrt(2/l)*sin(n(j)*pi*xovl);
end

for j = 1:length(t)
    if length(n) > 1 % handle the exception of only one wavefunction
        phasemat = exp(-i*2*pi*En/h*ones(1,length(xovl))*t(j));
        psi_t(j,:) = 1/sqrt(length(n))*sum(phasemat.*psi_n);
    else
        psi_t(j,:) = psi_n;
    end
    psi2(j,:) = psi_t(j,:).*conj(psi_t(j,:)); %\psi^2
    xq(j) = (xovl(2)-xovl(1))*trapz(psi2(j,:).*xovl); % calculate expectation value.
end

maxy = max(max(psi2)); % biggest value in psi2, need to do max twice because psi2 is a matrix.

%% Plot moving wave packet

figure(1);
for j = 1:length(t)
    hq = plot(xovl,psi2(j,:),'r');
    hold on
    hc = plot(xc(j)*ones(1,100),linspace(0,maxy),'k'); % plot a blue vertical line 
    hold off
    axis([0 1 0 max(max(psi2))]);
    xlabel('x/L');
    ylabel('|\psi(t)|^2');
    title(['t/(l(2m/E)^{1/2} =  ',num2str(t(j)*sqrt(E/(2*m))/l)]);
    M(j) = getframe(gcf);
    legend([hc,hq],'classical x(t)/L','quantum |\Psi|^2');
    setfigfont(1,14);
end

%% Plot <x>(t) for quantum result and classical result 

figure(2);
hc = plot(t/(l/(2*E/m)^0.5),xc,'k--');
hold on
hq = plot(t/(l/(2*E/m)^0.5),xq,'r-');
hold off
grid on
xlabel('t/(l(m/2E)^{1/2})');
ylabel('x/L');
setfigfont(2,14);
legend([hc,hq],'classical x(t)/L','quantum <x>(t)/L');

%% Construct histogram on x of particle
% edges = linspace(0,1,30);
% Nc = histc(xc,edges);
% Nq = histc(xq,edges);
% 
% Nc = Nc(1:end-1); % throw out last point
% Nq = Nq(1:end-1);
% 
% boxcenters = (edges(1:end-1)+edges(2:end))/2;
% figure(2)
% hxbar = plot(boxcenters,Nq/((boxcenters(2)-boxcenters(1))*trapz(Nq)),'r');
% hold on
% hpsi2 = plot(xovl,mean(psi2));
% hclass = hline(gcf,1,'k--');
% hold off
% xlabel('x/l');
% grid on
% legend([hxbar,hpsi2,hclass],'Time Average of <x/l>',...
%     'Time average of |\Psi|^2','Classical Result');
% title('Probability for finding the particle at x/l');
% setfigfont(2,14);

%% Play movie using MATLABs movie feature.

%figure(3)
%movie(gcf,M,1,4)


