function h_line = hline(fignum,y,linestyle,varargin)
%HLINE
%
%hline(fignum,y,linestyle) puts a horizontal line on the figure with handle
%fignum at position y. The style of the line is specified in the string
%linestyle. e.g. linestyle = 'k-' puts a black dashed line.
%
%hline(fignum,y,linestyle,linewidth) lets you manually set the linewidth.
%
%Tom Allison  7/7/2008
%Revised 10/21/2010 - added linewidth feature

figure(fignum);

h_axis = gca;

Axlimits = axis(h_axis);

x = linspace(Axlimits(1),Axlimits(2),50);
y = y*ones(1,50);

if isempty(varargin) % use whatever the default linewidth is
    h_line = plot(x,y,linestyle);
elseif length(varargin) == 1
    h_line = plot(x,y,linestyle,'LineWidth',varargin{1});
end


