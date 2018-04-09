%Hradialwavefunction.m
%
%This script plots radial wave functions of the hydrogen atom in atomic 
%units. Uses Laguerre polynomials LaguerreGen.m, downloaded from MATLAB
%central.
%
%Tom Allison 9/28/2013

set(0,'DefaultLineLineWidth',2);

nl = [1 0;
    2 1
    2 0];
%     2 1
%     3 0
%     3 1
%     4 0]


r = linspace(0,10*max(nl(:,1)),100*max(nl(:,1)) );

[numfunc,c] = size(nl)

R = zeros(numfunc,length(r));

for j = 1:numfunc
    n = nl(j,1);
    l = nl(j,2);
    R(j,:) = sqrt(factorial(n-l-1)/( 2*n*factorial(n+l)))*(2/n)^(l+3/2)...
        *r.^l.*exp(-r/n).*polyval(LaguerreGen(n-l-1,2*l+1),2*r/n); 
    % Note normalization here is different than Griffiths and McQuarrie
    % because my Laguerre polynomial generator differs by factorial(n+l) in
    % the prefactor. These wavefunctions are properly normalized.
end


% construct string for legend units
grid on

figure(1);
subplot(2,1,1);
plot(r,R);
xlabel('r [a.u.]');
ylabel('R_{nl}');
legstring = [num2str(nl)]
legend(legstring);
grid on
axis([xlim,-0.2,0.8]);

subplot(2,1,2);
Rsq = R.^2;
plot(r,Rsq.*(ones(numfunc,1)*(r.^2)));
grid on
xlabel('r [a.u.]');
ylabel('Electron Density d\rho/dr');
trapz(r,(Rsq.*(ones(numfunc,1)*(r.^2)))') % integral to check normalization.
legstring = [num2str(nl)]
legend(legstring);
setfigfont(1,14)
