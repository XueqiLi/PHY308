%example2_integration.m
%
%This example script shows how to use trapezoidal integration and also quadl
%to integrate a function.
%
%Tom Allison 8/22/2013

set(0,'DefaultLineLineWidth',2); % make the default plotting linewidth 2

%% Part 1: Use trapezoidal integration

numpoints = 10; % define variable numpoints which keeps track of how many points to use for the numerical integration
                % YOU SHOULD ADJUST THIS AND SEE HOW THE ACCURACY OF THE
                % METHOD INCREASES

x = linspace(0,1,numpoints); % make a linear array going from 0 to 1 with numpoints points
y = x.^2; % define array y to represent the function y = x^2
dx = x(2)-x(1); % calculate step size from difference in first two elements of array x

inty = dx*trapz(y) % perform the definite integral using the trapazoidal rule

err = inty - 1/3; % compare to exact result

inty_vs_x = dx*cumtrapz(y); % do comulative integral \int_0^x dx' y(x')

figure(1);
hy = plot(x,y,'k-o'); % plot original function
hold on
hi = plot(x,inty_vs_x,'r'); % plot cumulative integral
hexact = plot(x,1/3*x.^3,'b:'); % plot exact result with dotted line
hold off
grid on
legend([hy,hi,hexact],'y = x^2','Numerical Integral','Exact Integral',...
    'Location','NorthWest');
xlabel('x');
ylabel('y = x^2 and its integral');

%% Part 2 use adaptive step size quadl algorithm

f = inline('x.^2'); % construct inline function f = x^2

intf = quadl(@(x)f(x),0,1) % tell quadl to integrate this function from x goes from 0 to 1
                           % quadl has lots of settings that let you
                           % specify the desired accuracy, etc.
                       

                           
                        