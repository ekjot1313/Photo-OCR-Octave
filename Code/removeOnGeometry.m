function [mserRegions mserStats]=removeOnGeometry(mserRegions,mserStats,I)



% Compute the aspect ratio using bounding box data.
bbox = vertcat(mserStats.BoundingBox);
w = bbox(:,3);
h = bbox(:,4);
aspectRatio = w./h;
boxarea=w.*h;

[L W H]=size(I);
imagearea=L*W*H;
%changing it to 0.001 of actual area
imagearea=0.0001*imagearea;


aspectRatio;

% Threshold the data to determine which regions to remove. These thresholds
% may need to be tuned for other images.

filterIdx = boxarea' < imagearea;
filterIdx = filterIdx | aspectRatio' > 3;
filterIdx = filterIdx | [mserStats.Eccentricity] > 0.999 ;
filterIdx = filterIdx | [mserStats.Solidity] > .65;
filterIdx = filterIdx | [mserStats.Extent] < 0.01 | [mserStats.Extent] > 0.9;
filterIdx = filterIdx | [mserStats.EulerNumber] < -4;




% Remove regions
mserStats(filterIdx) = [];
mserRegions(filterIdx) = [];

end