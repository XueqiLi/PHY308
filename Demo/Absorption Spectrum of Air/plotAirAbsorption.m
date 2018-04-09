%plotAirAbsorption.m
%
%This script plots the absorption of air from HITRAN.
%
%Tom Allison 2/22/2017

set(0,'DefaultLineLineWidth',2);

[h,d] = mhdrload('AirSpectrumLonger4.txt');

WN = d(:,1)
xsection = d(:,3);

hnu = WN*1.239842E-4

hnu700 = 1239.842/700;
hnu450 = 1239.842/450;

WN700 = 1/0.7E-4;
WN450 = 1/0.45E-4;


figure(1);
semilogx(hnu,xsection,'k');
hold on
vline(gcf,hnu700,'r--');
vline(gcf,hnu450,'b--');
hold off
grid on
xlabel('photon energy [eV]');
ylabel('Absorption Cross Section per molecule [cm^2]');
axis([min(hnu),max(hnu)+0.3,1E-28,1.42E-20]);
setfigfont(gcf,16)

figure(2);
loglog(hnu,xsection,'k');
hold on
vline(gcf,hnu700,'r--');
vline(gcf,hnu450,'b--');
hold off
grid on
xlabel('Wave Number [cm^{-1}]');
ylabel('Absorption Cross Section per molecule [cm^2]');
axis([min(hnu),max(hnu)+0.3,1E-28,1E-19]);
setfigfont(gcf,16)

figure(3);
semilogx(WN,xsection,'k');
hold on
vline(gcf,WN700,'r--');
vline(gcf,WN450,'b--');
hold off
grid on
xlabel('Wave Number [cm^{-1}]');
ylabel('Absorption Cross Section per molecule [cm^2]');
axis([min(WN),max(WN),1E-28,1.4E-20]);
setfigfont(gcf,16)

figure(4);
loglog(WN,xsection,'k');
hold on
vline(gcf,WN700,'r--');
vline(gcf,WN450,'b--');
hold off
grid on
xlabel('Wave Number [cm^{-1}]');
ylabel('Absorption Cross Section per molecule [cm^2]');
axis([min(WN),max(WN),1E-28,1E-19]);
setfigfont(gcf,16)
