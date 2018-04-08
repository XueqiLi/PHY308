%example6_polyfit.m
%
%This script gives an exampe of polynomial fitting. 
%
%Tom Allison 8/22/2013

%define a set of data, say from an experiment or a numerical calculation
xdat = [0
    0.3
    0.8
    1.4
    2.0
    2.6
    3.5];

ydat = [0.1
    0.3
    1.5
    4.2
    7
    8
    9]

xdisplay = linspace(min(xdat),max(xdat)); % make a linearly spaced x axis for plotting the functions

P1 = polyfit(xdat,ydat,1); % do first order polynmial fit. Returns the coefficients in vector P.
y1 = polyval(P1,xdisplay); % evaluate polynmial at xdisplay values

P2 = polyfit(xdat,ydat,2); % second order
y2 = polyval(P2,xdisplay);

P3 = polyfit(xdat,ydat,3); % third order
y3 = polyval(P3,xdisplay);

% plot data and fits
figure(1)
h1 = plot(xdisplay,y1,'r');
hold on
h2 = plot(xdisplay,y2,'b');
h3 = plot(xdisplay,y3,'g');
hdat = plot(xdat,ydat,'ko','Linewidth',4);
hold off
xlabel('x');
ylabel('data and fits');
grid on
title('Polynomial Fitting Example');
legend([hdat,h1,h2,h3],'Data','Linear Fit','2nd order fit',...
    '3rd order fit','Location','NorthWest');


    




