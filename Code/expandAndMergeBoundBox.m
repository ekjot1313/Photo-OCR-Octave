function textBBoxes=expandAndMergeBoundBox(bboxes,i,ExpRatio)


% Convert from the [x y width height] bounding box format to the [xmin ymin
% xmax ymax] format for convenience.
xmin = bboxes(:,1);
ymin = bboxes(:,2); 
xmax = xmin + bboxes(:,3) - 1;
ymax = ymin + bboxes(:,4) - 1;


% Expand the bounding boxes by a small amount.
expansionAmountX = ExpRatio*bboxes(:,3);
expansionAmountY = ExpRatio*bboxes(:,4);

%xmin = (1-expansionAmount) * xmin;
%ymin = (1-expansionAmount) * ymin;
%xmax = (1+expansionAmount) * xmax;
%ymax = (1+expansionAmount) * ymax;

xmin = xmin - expansionAmountX;
ymin = ymin - 1.1*expansionAmountY;%more to include dots on i and j
xmax = xmax + expansionAmountX;
ymax = ymax + expansionAmountY;



% Clip the bounding boxes to be within the image bounds
xmin = max(xmin, 1);
ymin = max(ymin, 1);
xmax = min(xmax, size(i,2));
ymax = min(ymax, size(i,1));


expandedBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];

%merging boxes
textBBoxes = mergeBoundBox(expandedBBoxes);
a=zeros(size(textBBoxes));

%many boxes donot merge because of earlier all boxes are small so 
%it may donot overlap with any box. But after initial merging, box expand to 
%encompass the overlapping boxes. Now, the said box may overlap the expanded box.
%So, the process of merging is repeated to encompass all such left out boxes.
%It is repeated when there is no change of bounding box values.


while ~isequal(a,textBBoxes)
	a=textBBoxes;
textBBoxes = mergeBoundBox(textBBoxes);
end
end