function bounds=dimensions2bounds(dim)

if(size(dim,1)>0)
% Convert from the [xmin ymin xmax ymax][x y width height] bounding box format
% to the [x y width height] format for convenience.
xmin = dim(:,1);
ymin = dim(:,2);
xmax = dim(:,3);
ymax = dim(:,4);

bounds = [xmin ymin xmax-xmin+1 ymax-ymin+1];
end