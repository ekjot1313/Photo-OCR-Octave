
i=imread('E:\Photo OCR\Project\Code\Sample Images\abcd.jpg'); % reads given image in rgb form

gi=i;
if size(i,3)==3 %if image is rgb
	gi=rgb2gray(i); % convert rgb image into grayscale
endif


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
printboxes(bbox,ei,'After removeOnGeometry');
endif




%Remove Non-Text Regions Based On Stroke Width Variation from matlab's website
[mserRegions mserStats]=removeOnSWV(mserRegions,mserStats);

%printing bounding boxes around selected regions
if(size(mserStats,2)>0)
bbox = vertcat(mserStats.BoundingBox);
printboxes(bbox,ei,'After removeOnSWV');
	bbox=expandAndMergeBoundBox(bbox,i,0);
printboxes(bbox,ei,'After removeOnSWV + expandAndMergeBoundBox with 0 expansion');
endif
bbox;


%Remove Non-Text Regions Based On Stroke Width Variation coded by me
bboxNum=size(bbox,1);
if(bboxNum>0)
	bboxswt=[];
	for bboxnum=1:bboxNum
		bounds=bbox(bboxnum,:)-[0 0 1 1]; %subtracting length and height to crop accurately
		bboxswt=[bboxswt;mySWT(imcrop(gi,bounds),bounds)];
	endfor
endif
bboxswt;
%printing bounding boxes around selected regions
if(size(bboxswt,1)>0)
printboxes(bboxswt,ei,'final image after swt');
endif


bboxes=bboxswt;

%Merging overlaping bounding boxes
if(size(bboxes,1)>0)
textBBoxes=expandAndMergeBoundBox(bboxes,i,0.05);%0.05 is expansion ration

% Show the final text detection result.
printboxes(textBBoxes,gi,'final image');
endif