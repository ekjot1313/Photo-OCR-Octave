function dim=bounds2dimensions(bounds)
bbox=bounds;

if(size(bbox,1)>0)
% Convert from the [x y width height] bounding box format to the [xmin ymin
% xmax ymax] format for convenience.
xmin = bbox(:,1);
ymin = bbox(:,2);
xmax = xmin + bbox(:,3) - 1;
ymax = ymin + bbox(:,4) - 1;


dim=[xmin ymin xmax ymax];
endif
end