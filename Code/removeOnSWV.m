function [mserRegions mserStats]=removeOnSWV(mserRegions,mserStats)


strokeWidthThreshold = 5;
% Process the remaining regions
for j = 1:numel(mserStats)

    regionImage = mserStats(j).Image;
   


    regionImage = padarray(regionImage, [1 1], 0);



    distanceImage = bwdist(~regionImage);


%thinning the image
    skeletonImage = bwmorph(regionImage, 'thin', inf);
m=max(max(distanceImage));
%distanceImage=m-distanceImage;

figure;subplot(1,4,1);imagesc(regionImage);title('regionImage');
subplot(1,4,2);imagesc(distanceImage);title('distanceImage');
subplot(1,4,3);imagesc(skeletonImage);title('skeletonImage');






    strokeWidthValues = distanceImage(skeletonImage);

    %strokeWidthValues = distanceImage.*skeletonImage;

    subplot(1,4,4);imagesc(strokeWidthValues);title('strokeWidthValues');
    strokeWidthMetric = std(strokeWidthValues)/mean(strokeWidthValues);
%subplot(1,3,2);imagesc(regionImage);title('regionImage');
%subplot(1,3,3);imshow(strokeWidthValues);title(num2str(strokeWidthMetric));

    

    %subplot(1,3,3);imshow(strokeWidthValues);title(num2str(strokeWidthMetric));

    strokeWidthFilterIdx(j) = strokeWidthMetric > strokeWidthThreshold;

end




% Remove regions based on the stroke width variation

mserRegions(strokeWidthFilterIdx) = [];
mserStats(strokeWidthFilterIdx) = [];


end