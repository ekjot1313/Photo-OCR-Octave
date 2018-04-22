function bbox=textDetection(I,bounds)
%s=input("Enter an existing image for ocr\n","s");
%I=imread(s);
%I=i=imread('E:\Photo OCR\Project\Code\Sample Images\abcd.jpg'); % reads given image in rgb form

%figure;
%imshow(I);
%title('original image');
%convert image to grayscale
 [r,c,channels]=size(I);
  if channels>1
  I=rgb2gray(I);
endif;


c=edge(I,'canny');
distanceImage = bwdist(~I);
%    figure;
%imagesc(distanceImage);
%title('distanceImage');

    skeletonImage = bwmorph(c, 'thin', inf);
%    figure;
%imagesc(skeletonImage);
%title('skeletonImage');
  strokeWidthValues = distanceImage(skeletonImage);
    bbox=bounds;
strokeWidthMetric=0;
    if mean(strokeWidthValues)>0
    	strokeWidthMetric = std(strokeWidthValues)/mean(strokeWidthValues);
    	titl=[num2str(strokeWidthMetric)];

    	if (strokeWidthMetric)<0.1||(strokeWidthMetric)>2
    		titl=[titl,'rejected'];
    		bbox=[];
    	%figure;
    	%imagesc(skeletonImage);
    	%title(titl);    		
    	end;

    	%figure;
    	%imagesc(skeletonImage);
    	%title(titl);

    endif


%%%%%%


 
end;