function stage1(i)
      
%i=imcomplement(i);
trim(i);
gi=i;
if size(i,3)==3 %if image is rgb
	gi=rgb2gray(i); % convert rgb image into grayscale
elseif islogical(i)%if image is binary
	i=uint8(i*255);
endif;


%preprocessing image before recognition
%gi=imagePreprocessing(gi);

[ei t]=edge(gi,'canny'); % generate canny edged image, t is threshold
name='t=[ ';
name=[ 'canny= ' name num2str(t) '].sampjpg']; %generate a name for image
%imwrite(ei,name); % write the canny image




eig = uint8(255 * ei); % canny img is binary(1,0), this convert it into gray bcz imgrad need gray

[grad dir]=imgradient(eig); % find gradient and direction of canny img



regionImage=eig;

cc = bwconncomp (ei);


mserStats = regionprops(cc,'all');
mserRegions=i;


if(size(mserStats,2)>0)
bbox = vertcat(mserStats.BoundingBox);
printboxes(bbox,ei,'original bbox',1);
endif




% Remove Non-Text Regions Based On Basic Geometric Properties
[mserRegions mserStats]=removeOnGeometry(mserRegions,mserStats,ei);

%printing bounding boxes around selected regions
if(size(mserStats,2)>0)
bbox = vertcat(mserStats.BoundingBox);
printboxes(bbox,ei,'After removeOnGeometry',1);
endif




%Remove Non-Text Regions Based On Stroke Width Variation from matlab's website
%[mserRegions mserStats]=removeOnSWV(mserRegions,mserStats);

%printing bounding boxes around selected regions
%if(size(mserStats,2)>0)
%bbox = vertcat(mserStats.BoundingBox);
%printboxes(bbox,ei,'After removeOnSWV');
	%bbox=expandAndMergeBoundBox(bbox,i,0);
%printboxes(bbox,ei,'After removeOnSWV + expandAndMergeBoundBox with 0 expansion');
%endif

%word boxes are numbered in increasing order of vertical distance only
%but they may be ordered like actual text.i.e, top to bottom and left to right
%bbox=orderBoxPlace(bbox,10);
%printboxes(bbox,ei,'After rearranging');

%link1to2(bbox,i);



%Remove Non-Text Regions Based On Stroke Width Variation coded by me
bboxNum=size(bbox,1);
if(bboxNum>0)
	bboxswt=[];
	for bboxnum=1:bboxNum
		bounds=bbox(bboxnum,:);%-[0 0 1 1]; %subtracting length and height to crop accurately
		%bboxswt=[bboxswt;mySWT2(imcrop(gi,bounds),bounds)];
		bboxswt=[bboxswt;textDetection(imcrop(gi,bounds),bounds)];
	endfor
endif

%word boxes are numbered in increasing order of vertical distance only
%but they may be ordered like actual text.i.e, top to bottom and left to right
bboxswt=orderBoxPlace(bboxswt,50);


%expanding vertically to include dots of i and j and
%printing bounding boxes around selected regions
%then sending them for recognition.
if(size(bboxswt,1)>0)
	bboxswt=expandAndMergeBoundBox(bboxswt,i,0,0.12);

printboxes(bboxswt,i,'final image after swt',1);
link1to2(bboxswt,i);

else
	clc;
	fprintf('No Text Detected.');
end;
	

end;



