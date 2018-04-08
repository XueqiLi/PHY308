%example5_minzero.m
%
%This example shows how to use fminsearch and fzero to find minima and
%zeros of a function. Minimizes the function func521.m. If you can't get
%this to run make sure you have func521 in the same directory.
%
%This example is fairly simple. But fminsearch and fzero can be used for
%the variational method and other non-trivial quantum chemistry tasks.
%
%
%Tom Allison 8/22/2013

set(0,'DefaultLineLineWidth',2);

%lets have a look at the function to see where would be a good place to
%guess.

x = linspace(0,10);
figure(1);
hfunc = plot(x,func521(x),'k');
grid on

%Looks like function has a zero near 1 and a minimum near 2. Lets try these
%for guesses

x0 = fzero(@func521,1); % look for zero of func521 near 1
xmin = fminsearch(@func521,2); % look for min of func521 near 2

%return to figure(1) and put markers where MATLAB found the minimum and the
%zero to visually check that it is working.

figure(1)
hold on
h0 = plot(x0,func521(x0),'ro');  % put a dot on the found zero
hmin = plot(xmin,func521(xmin),'bo'); % put a dot on the found minimum
hold off
legend([hfunc,hmin,h0],'func521','minimum','zero');
xlabel('x');
ylabel('func521(x)');
title('Minimization and Zeroing example');






