function printboxes(bbox,i,Title)
figure
imshow(i)
title(Title);

if(size(bbox,1)>0)
% Convert from the [x y width height] bounding box format to the [xmin ymin
% xmax ymax] format for convenience.
%xmin = bbox(:,1);
%ymin = bbox(:,2);
%xmax = xmin + bbox(:,3) - 1;
%ymax = ymin + bbox(:,4) - 1;



% Clip the bounding boxes to be within the image bounds
%xmin = max(xmin, 1);
%ymin = max(ymin, 1);
%xmax = min(xmax, size(i,2));
%ymax = min(ymax, size(i,1));

expandedBBoxes=bbox;%bounds2dimensions(bbox,i);

% Show the expanded bounding boxes

%expandedBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];


% Show remaining regions



for i=1:size(expandedBBoxes,1)
	
rectangle('position',expandedBBoxes(i,:),'edgecolor','r','LineWidth',3);
text(expandedBBoxes(i,1),expandedBBoxes(i,2),num2str(i),'Color','g','FontSize',14);
end
end
end