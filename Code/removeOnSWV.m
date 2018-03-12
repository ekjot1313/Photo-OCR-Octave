function [mserRegions mserStats]=removeOnSWV(mserRegions,mserStats)


strokeWidthThreshold = 0.4;
% Process the remaining regions
for j = 1:numel(mserStats)

    regionImage = mserStats(j).Image;
   


    regionImage = padarray(regionImage, [1 1], 0);

    distanceImage = bwdist(~regionImage);
 

%thinning the image
    skeletonImage = bwmorph(regionImage, 'thin', inf);




    strokeWidthValues = distanceImage(skeletonImage);

    strokeWidthMetric = std(strokeWidthValues)/mean(strokeWidthValues);

    strokeWidthFilterIdx(j) = strokeWidthMetric > strokeWidthThreshold;

end




% Remove regions based on the stroke width variation

mserRegions(strokeWidthFilterIdx) = [];
mserStats(strokeWidthFilterIdx) = [];


end