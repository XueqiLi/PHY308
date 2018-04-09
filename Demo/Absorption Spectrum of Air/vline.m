function h_line = vline(fignum,x,linestyle)
%VLINE
%
%vline(fignum,x,linestyle) puts a vertical line on the figure with handle
%fignum at position x. The style of the line is specified in the string
%linestyle. e.g. linestyle = 'k-' puts a black dashed line.
%
%Tom Allison  7/7/2008

figure(fignum);

h_axis = gca;

Axlimits = axis(h_axis);

y = linspace(Axlimits(3),Axlimits(4),50);
x = x*ones(1,50);
h_line = plot(x,y,linestyle);

