function y = func521(x)
%func521
%
%y = func521(x) is a 1D function of x used for the purpose of illustrating
%funciton minimization and zeroing. Used by example5_minzero.m
%
%Tom Allison 8/22/2013

y = besselj(0,x) - 3*besselj(1,x); % make example function out of a
                                   % superposition of bessel functions

end
