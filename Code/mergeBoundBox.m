function textBBoxes=mergeBoundBox(expandedBBoxes)


xmin = expandedBBoxes(:,1);
ymin = expandedBBoxes(:,2); 
xmax = xmin + expandedBBoxes(:,3) - 1;
ymax = ymin + expandedBBoxes(:,4) - 1;

% Compute the overlap ratio
overlapRatio = bboxOverlapRatio(expandedBBoxes, expandedBBoxes);

% Set the overlap ratio between a bounding box and itself to zero to
% simplify the graph representation.
n = size(overlapRatio,1);
overlapRatio(1:n+1:n^2) = 0;

%adding load path of Octave Graph Theory library
addpath('E:\Photo OCR\Project\Code\lib\octave-networks-toolbox-master');

% Create the graph
g = graph(overlapRatio);

% Find the connected text regions within the graph
[componentIndices numRegionsInGroup]= conncomp(g);% compInd is cell array containing connected nodes



% Merge the boxes based on the minimum and maximum dimensions.

xmin = accumarray(componentIndices', xmin, [], @min);
ymin = accumarray(componentIndices', ymin, [], @min);
xmax = accumarray(componentIndices', xmax, [], @max);
ymax = accumarray(componentIndices', ymax, [], @max);

% Compose the merged bounding boxes using the [x y width height] format.
textBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];
end