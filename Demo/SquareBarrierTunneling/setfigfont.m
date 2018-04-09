function setfigfont(h,fontsize);
%SETFIGFONT
%
%setfigfont(h,fontsize) sets the fontsize of all the text in a figure to
%fontsize.
%
%Tom Allison 3/12/2008

hfonts = findall(h,'FontUnits','points');
set(hfonts,'FontSize',fontsize);
