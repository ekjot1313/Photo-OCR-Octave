function bbox=orderBoxPlace(bbox,gintRange)


%bounding boxes are numbered in increasiing order of vertical distance only
%but they may be ordered like actual text.i.e, top to bottom and left to right


bbox=[bbox,floor(bbox(:,2)/gintRange)];
%let gintRange is 100 pixels, then
%above is a gint function which ranges in 100pixels. i.e, if there are 
%two or more bounding boxes with there vertical distance less than 100pixels,
%they will be assign similar number, say 1. Then next set will be assign say 2
%and so on.

bbox=sortrows(bbox,[5,1]);%boxes are sorted on the number assigned in above 
                      %function and later if two boxes have same assigned number
                      %then they will be sorted on there first column ie 
                      %horizontal distance.

bbox=bbox(:,1:4);%new column removed


end