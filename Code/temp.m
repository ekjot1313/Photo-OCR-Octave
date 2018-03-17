
i=imread('E:\Photo OCR\Project\Code\Sample Images\swt.jpg'); % reads given image in rgb form

gi=rgb2gray(i); % convert rgb image into grayscale

%preprocessing image before recognition
%gi=imagePreprocessing(gi);

[ei t]=edge(gi,'canny'); % generate canny edged image, t is threshold
name='t=[ ';
name=[ 'canny= ' name num2str(t) '].jpg']; %generate a name for image
%imwrite(ei,name); % write the canny image




eig = uint8(255 * ei); % canny img is binary(1,0), this convert it into gray bcz imgrad need gray

[grad dir]=imgradient(eig); % find gradient and direction of canny img













regionImage=eig;

cc = bwconncomp (ei);


mserStats = regionprops(cc,'all');
mserRegions=i;

% Remove Non-Text Regions Based On Basic Geometric Properties
[mserRegions mserStats]=removeOnGeometry(mserRegions,mserStats,ei);

%printing bounding boxes around selected regions
if(size(mserStats,2)>0)
bbox = vertcat(mserStats.BoundingBox);
printboxes(bbox,ei);
endif




%Remove Non-Text Regions Based On Stroke Width Variation from matlab's website
[mserRegions mserStats]=removeOnSWV(mserRegions,mserStats);

%printing bounding boxes around selected regions
if(size(mserStats,2)>0)
bbox = vertcat(mserStats.BoundingBox);
printboxes(bbox,ei);
endif

%Remove Non-Text Regions Based On Stroke Width Variation coded by me
[mserRegions mserStats]=mySWT(mserRegions,mserStats,gi);

%printing bounding boxes around selected regions
if(size(mserStats,2)>0)
bbox = vertcat(mserStats.BoundingBox);
printboxes(bbox,ei);
endif








% Get bounding boxes for all the regions
bboxes = vertcat(mserStats.BoundingBox);

%Merging overlaping bounding boxes
if(size(mserStats,2)>0)
textBBoxes=expandAndMergeBoundBox(bboxes,i);

% Show the final text detection result.
printboxes(textBBoxes,gi);
endif