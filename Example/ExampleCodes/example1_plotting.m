%example1_plotting.m
%
%This script illustrates how to plot data and functions in matlab.
%You use the percent symbol to put notes in that MATLAB does not try and
%execute.
%
%Tom Allison 8/22/2013

set(0,'DefaultLineLineWidth',2); % make the default plotting linewidth 2

x = -10:0.5:10; % make x a linearly spaced array from -10 to 10 with step size 0.5
              % use semicolon
              
y = (1/30)*x.^3 - x.*cos(x); % define another array representing a 
                        % function y(x) = (1/30)x^3 - xcos(x)
                        % you need to use .^2 and .* because you do not
                        % want to do matrix/array multiplication but
                        % instead have MATLAB do multiplication or squaring
                        % element by element on the array.

figure(1) % open a new figure, figure 1                       
h1 = plot(x,y,'k-o') % plot y vs. x.'k' means black and '-o' means circles connected by lines.
hold on           % tell MATLAB to hold on to the current plot and don't overwrite it
h2 = plot(x,3*sin(x),'r-'); % now plot the function 'sin' evaluated at the array points x. 'r-' = red solid line
hold off            % make future plots on this figure overwrite previous plots
xlabel('x')
ylabel('y or sin');
title('Example Plot');
legend([h1,h2],'y','sin(x)'); % make a nice legend for labeling the plots 
grid







                        
                        

