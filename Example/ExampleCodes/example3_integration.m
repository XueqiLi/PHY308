%example3_differentiation.m
%
%This script gives examples about how to numerically evaluate a deriviative
%
%Tom Allison 8/22/2013

set(0,'DefaultLineLineWidth',2); % make the default plotting linewidth 2

x = linspace(-3,3,100); % construct linearly spaced array for x, 100 points
dx = x(2) - x(1); %spacing between points in x

y = (1/3)*x.^3 - x; % construct array representing function y = (1/3)x^3 -x

dydx_analytic = x.^2 -1; % construct array representing derivative of y calculated analytically

dydx_numeric = diff(y)/dx; % estimate numerical derivative of y as difference between
                           % adjacent y values divided by spacing in x.
                           
%Now you cannot just plot(x,dydx_numeric) because the length of diff(y) 
%and thus dydx_numeric is 1 element smaller than y because if there are 100
%elements in y there are only 99 intervals between the elements.
%dydx_numeric is really representing the derivative at the points midway
%between the values of x, so we should construct an array that has these
%midpoint values. viz.

x2 = (x(1:end-1) + x(2:end))/2; % array with the midpoints of the x array

figure(1);
hy = plot(x,y,'k');
hold on
hypn = plot(x2,dydx_numeric,'r');
hypa = plot(x,dydx_analytic,'b:');
hold off
grid on
xlabel('x');
ylabel('y and dy/dx');
title('Differentiation Example');
legend([hy,hypn,hypa],'y = (1/3)x^3 - x','numeric derivative','analytic derivative');





